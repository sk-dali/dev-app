import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PairPlay'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildMenuCard(
                context,
                icon: Icons.chat_bubble_outline,
                title: 'ふたりトーク',
                description: 'お互いをもっと知るための質問をしてみよう',
                onTap: () => context.go('/talk'),
              ),
              const SizedBox(height: 16),
              _buildMenuCard(
                context,
                icon: Icons.flag_outlined,
                title: 'ふたりミッション',
                description: '一緒にチャレンジして思い出を作ろう',
                onTap: () => context.go('/mission'),
              ),
              const SizedBox(height: 16),
              _buildMenuCard(
                context,
                icon: Icons.psychology_outlined,
                title: '診断',
                description: '準備中',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('準備中です')),
                  );
                },
                isDisabled: true,
              ),
              const SizedBox(height: 16),
              _buildMenuCard(
                context,
                icon: Icons.favorite_outline,
                title: '思い出',
                description: 'これまでのトークとミッションを振り返ろう',
                onTap: () => context.go('/history'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    bool isDisabled = false,
  }) {
    return AppCard(
      onTap: isDisabled ? null : onTap,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            icon,
            size: 48,
            color: isDisabled
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isDisabled ? Colors.grey : null,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDisabled ? Colors.grey : null,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: isDisabled ? Colors.grey : null,
          ),
        ],
      ),
    );
  }
}

