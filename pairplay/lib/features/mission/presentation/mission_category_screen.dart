import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';

class MissionCategoryScreen extends StatelessWidget {
  const MissionCategoryScreen({super.key});

  final List<Map<String, String>> categories = const [
    {'name': '遊園地', 'icon': '🎢', 'description': 'スリル満点のアトラクション'},
    {'name': 'カフェ', 'icon': '☕', 'description': 'ゆったりとした時間を過ごそう'},
    {'name': '公園', 'icon': '🌳', 'description': '自然の中でリラックス'},
    {'name': 'その他', 'icon': '✨', 'description': 'いろいろな場所で'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'ホーム',
          onPressed: () => context.go('/'),
        ),
        automaticallyImplyLeading: false,
        title: const Text('ふたりミッション'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'デート先を選ぶ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'どこでミッションに挑戦しますか？',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: AppCard(
                        onTap: () {
                          context.go(
                            '/mission/play?category=${category['name']}',
                          );
                        },
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              category['icon']!,
                              style: const TextStyle(fontSize: 48),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category['name']!,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category['description']!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

