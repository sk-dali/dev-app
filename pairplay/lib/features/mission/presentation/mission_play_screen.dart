import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../domain/mission_repository.dart';
import '../../../shared/models/mission.dart';
import '../../../features/history/domain/history_service.dart';

class MissionPlayScreen extends ConsumerStatefulWidget {
  final String category;

  const MissionPlayScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<MissionPlayScreen> createState() => _MissionPlayScreenState();
}

class _MissionPlayScreenState extends ConsumerState<MissionPlayScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<String> _doneMissionIds = [];
  final List<String> _skippedMissionIds = [];
  List<Mission> _missions = [];
  
  // スワイプアニメーション用
  double _dragPosition = 0.0;
  double _rotation = 0.0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _loadMissions();
    _dragPosition = 0.0;
    _rotation = 0.0;
    _isAnimating = false;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadMissions() {
    final repository = ref.read(missionRepositoryProvider);
    _missions = repository.getByPlaceCategory(widget.category);
  }

  void _completeMission(bool isDone) {
    if (_currentIndex >= _missions.length) return;

    final mission = _missions[_currentIndex];
    if (isDone) {
      _doneMissionIds.add(mission.id);
    } else {
      _skippedMissionIds.add(mission.id);
    }

    if (_currentIndex < _missions.length - 1) {
      setState(() {
        _currentIndex++;
        _dragPosition = 0.0;
        _rotation = 0.0;
        _isAnimating = false;
      });
    } else {
      _showCompletionDialog();
    }
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

  void _onPanEnd(DragEndDetails details) {
    if (_isAnimating) return;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.3; // 画面幅の30%を閾値とする
    
    if (_dragPosition.abs() > threshold) {
      // 閾値を超えたら、カードを画面外に飛ばす
      _isAnimating = true;
      final targetPosition = _dragPosition > 0 
          ? screenWidth * 1.5 
          : -screenWidth * 1.5;
      
      _animation = Tween<double>(
        begin: _dragPosition,
        end: targetPosition,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
      
      _animationController.forward().then((_) {
        // アニメーション完了後、ミッションを完了
        if (_dragPosition > 0) {
          _completeMission(true); // 右スワイプで達成
        } else {
          _completeMission(false); // 左スワイプでスキップ
        }
        _animationController.reset();
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

  Future<void> _showCompletionDialog() async {
    final total = _missions.length;
    final done = _doneMissionIds.length;
    final score = total > 0 ? (done / total * 100).round() : 0;

    // 履歴を保存
    final historyService = ref.read(historyServiceProvider);
    await historyService.addMissionSession(DateTime.now(), _doneMissionIds);

    String comment;
    if (score >= 80) {
      comment = '素晴らしい！二人の絆が深まりましたね✨';
    } else if (score >= 50) {
      comment = 'いい感じです！次回も頑張りましょう💪';
    } else {
      comment = '無理せず、楽しむことが大切です😊';
    }

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('おつかれさま！'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$done / $total',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(comment),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ダイアログを閉じる
              context.go('/'); // ホームに戻る
            },
            child: const Text('ホームに戻る'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_missions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ミッションプレイ',
            style: TextStyle(
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
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
          child: const Center(
            child: Text(
              'このカテゴリにはミッションがありません',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    if (_currentIndex >= _missions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ミッションプレイ',
            style: TextStyle(
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
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
          child: const Center(
            child: Text(
              'すべてのミッションを完了しました',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    final mission = _missions[_currentIndex];
    final progress = (_currentIndex + 1) / _missions.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'ホーム',
          onPressed: () => context.go('/'),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          '${widget.category}のミッション',
          style: const TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
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
            // プログレスバー
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentIndex + 1} / ${_missions.length}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),

            // ミッションカード
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    // 背景のヒント表示
                    if (_dragPosition.abs() > 10)
                      Positioned.fill(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                            color: _dragPosition > 0
                                ? Colors.green.withOpacity(
                                    (_dragPosition / MediaQuery.of(context).size.width * 0.3).clamp(0.0, 0.8))
                                : Colors.orange.withOpacity(
                                    (-_dragPosition / MediaQuery.of(context).size.width * 0.3).clamp(0.0, 0.8)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _dragPosition > 0
                              ? const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 24),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.white, size: 32),
                                        SizedBox(width: 16),
                                        Text(
                                          '達成',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'スキップ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Icon(Icons.skip_next,
                                            color: Colors.white, size: 32),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    // カード
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        final position = _isAnimating ? _animation.value : _dragPosition;
                        final currentRotation = _isAnimating
                            ? position * 0.001
                            : _rotation;
                        
                        return Transform.translate(
                          offset: Offset(position, 0),
                          child: Transform.rotate(
                            angle: currentRotation,
                            child: GestureDetector(
                              onPanUpdate: _onPanUpdate,
                              onPanEnd: _onPanEnd,
                              child: AppCard(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      mission.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      mission.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.white.withOpacity(0.9),
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        3,
                                        (index) => Icon(
                                          Icons.star,
                                          color: index < mission.difficulty
                                              ? Colors.amber
                                              : Colors.white.withOpacity(0.3),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ボタン
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _completeMission(false),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Text(
                                    'スキップ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _completeMission(true),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Text(
                                    '達成',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
