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

class _TalkScreenState extends ConsumerState<TalkScreen> {
  final List<String> categories = ['すべて', '恋愛', '未来', 'もしも', '性格'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(talkControllerProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(talkControllerProvider);
    final controller = ref.read(talkControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'ホーム',
          onPressed: () => context.go('/'),
        ),
        automaticallyImplyLeading: false,
        title: const Text('ふたりトーク'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag_outlined),
            tooltip: 'ミッション',
            onPressed: () => context.go('/mission'),
          ),
        ],
      ),
      body: SafeArea(
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
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // 質問カード
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: state.current != null
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: AppCard(
                          key: ValueKey(state.current!.id),
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: Text(
                              state.current!.text,
                              style:
                                  Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('質問がありません'),
                      ),
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
                        : null,
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
    );
  }
}
