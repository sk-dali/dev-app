import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import 'talk_controller.dart';

class TalkScreen extends ConsumerStatefulWidget {
  const TalkScreen({super.key});

  @override
  ConsumerState<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends ConsumerState<TalkScreen>
    with SingleTickerProviderStateMixin {
  final List<String> categories = ['すべて', '恋愛', '未来', 'もしも', '性格'];

  // スワイプアニメーション用
  double _dragPosition = 0.0;
  double _rotation = 0.0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isAnimating = false;
  String? _previousQuestionId;

  @override
  void initState() {
    super.initState();
    _dragPosition = 0.0;
    _rotation = 0.0;
    _isAnimating = false;
    _previousQuestionId = null;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(talkControllerProvider.notifier).init();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isAnimating) return;

    setState(() {
      _dragPosition += details.delta.dx;
      // 回転角度を計算（最大30度）
      _rotation = _dragPosition * 0.001;
      if (_rotation > 0.5) _rotation = 0.5;
      if (_rotation < -0.5) _rotation = -0.5;
    });
  }

  void _onPanEnd(DragEndDetails details, TalkController controller) {
    if (_isAnimating) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.3; // 画面幅の30%を閾値とする

    if (_dragPosition < -threshold) {
      // 左にスワイプして閾値を超えたら、カードを画面外に飛ばす
      _isAnimating = true;
      final targetPosition = -screenWidth * 1.5;

      _animation = Tween<double>(
        begin: _dragPosition,
        end: targetPosition,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));

      _animationController.forward().then((_) {
        // アニメーション完了後、次の質問へ
        controller.next();
        // 次の質問が表示されるまで少し待つ
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _dragPosition = 0.0;
              _rotation = 0.0;
              _isAnimating = false;
            });
            _animationController.reset();
          }
        });
      });
    } else {
      // 閾値未満なら、元の位置に戻す
      _animation = Tween<double>(
        begin: _dragPosition,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));

      _animationController.forward().then((_) {
        setState(() {
          _dragPosition = 0.0;
          _rotation = 0.0;
        });
        _animationController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(talkControllerProvider);
    final controller = ref.read(talkControllerProvider.notifier);

    // 質問が変わったときにドラッグ位置をリセット
    final currentQuestionId = state.current?.id;
    if (currentQuestionId != null && currentQuestionId != _previousQuestionId) {
      final previousId = _previousQuestionId;
      _previousQuestionId = currentQuestionId;
      // アニメーション中でない場合、または前の質問から新しい質問に変わった場合のみリセット
      if (!_isAnimating || previousId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isAnimating) {
            setState(() {
              _dragPosition = 0.0;
              _rotation = 0.0;
            });
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'ホーム',
          onPressed: () => context.go('/'),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'ふたりトーク',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag_outlined),
            tooltip: 'ミッション',
            onPressed: () => context.go('/mission'),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE1BEE7), // 薄い紫
              Color(0xFFCE93D8), // ライトパープル
              Color(0xFFBA68C8), // ミディアムパープル
              Color(0xFF9C27B0), // 濃い紫
            ],
          ),
        ),
        child: SafeArea(
        child: Column(
          children: [
            // カテゴリ選択
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    final isSelected = (category == 'すべて' &&
                            state.selectedCategory == null) ||
                        (category != 'すべて' &&
                            state.selectedCategory == category);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (category == 'すべて') {
                            controller.changeCategory(null);
                          } else {
                            controller.changeCategory(category);
                          }
                        },
                        backgroundColor: Colors.white.withOpacity(0.2),
                        selectedColor: Colors.white.withOpacity(0.3),
                        checkmarkColor: const Color(0xFF1A1A1A),
                        labelStyle: TextStyle(
                          color: const Color(0xFF1A1A1A),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // 質問カード
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // 利用可能なサイズの90%を計算（幅）
                  final cardWidth = constraints.maxWidth * 0.9;
                  // 縦方向は利用可能なサイズの100%
                  final cardHeight = constraints.maxHeight;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: state.current != null
                        ? Builder(
                            builder: (context) {
                              // 次の質問を取得
                              final questions = state.availableQuestions;
                              final currentIndex = questions.indexWhere(
                                (q) => q.id == state.current!.id,
                              );
                              final nextIndex = currentIndex != -1 &&
                                      currentIndex < questions.length - 1
                                  ? currentIndex + 1
                                  : 0;
                              final nextQuestion = questions.isNotEmpty
                                  ? questions[nextIndex]
                                  : null;

                              return OverflowBox(
                                maxWidth: double.infinity,
                                maxHeight: double.infinity,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // 次の質問カード（右上にずらして重ねる）
                                    if (nextQuestion != null)
                                      Positioned(
                                        left: 20,
                                        right: -20,
                                        top: -20,
                                        bottom: 20,
                                        child: Transform.scale(
                                          scale: 0.98,
                                          child: SizedBox(
                                            width: cardWidth,
                                            height: cardHeight,
                                            child: AppCard(
                                              padding: const EdgeInsets.all(32),
                                              child: Center(
                                                child: Text(
                                                  nextQuestion.text,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium
                                                      ?.copyWith(
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    // 背景のヒント表示
                                    if (_dragPosition < -10)
                                      Positioned.fill(
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 100),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(
                                              (-_dragPosition /
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.3)
                                                  .clamp(0.0, 0.8),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 24),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '次へ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 16),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.white,
                                                    size: 32,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    // 現在の質問カード
                                    AnimatedBuilder(
                                      animation: _animation,
                                      builder: (context, child) {
                                        final position = _isAnimating
                                            ? _animation.value
                                            : _dragPosition;
                                        final currentRotation = _isAnimating
                                            ? position * 0.001
                                            : _rotation;

                                        return Center(
                                          child: Transform.translate(
                                            offset: Offset(position, 0),
                                            child: Transform.rotate(
                                              angle: currentRotation,
                                              child: Transform.scale(
                                                scale: 0.98,
                                                child: GestureDetector(
                                                  onPanUpdate: _onPanUpdate,
                                                  onPanEnd: (details) =>
                                                      _onPanEnd(
                                                          details, controller),
                                                  child: SizedBox(
                                                    width: cardWidth,
                                                    height: cardHeight,
                                                    child: AppCard(
                                                      key: ValueKey(
                                                          state.current!.id),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              32),
                                                      child: Center(
                                                        child: Text(
                                                          state.current!.text,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium
                                                              ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              '質問がありません',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  );
                },
              ),
            ),

            // ボタン群
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      state.current != null &&
                              controller.isFavorite(state.current!.id)
                          ? Icons.star
                          : Icons.star_border,
                    ),
                    iconSize: 32,
                    color: state.current != null &&
                            controller.isFavorite(state.current!.id)
                        ? Colors.amber
                        : Colors.white,
                    onPressed: () => controller.toggleFavorite(),
                  ),
                  AppButton(
                    text: 'もっと話してみる',
                    onPressed: state.current != null
                        ? () => controller.next()
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
