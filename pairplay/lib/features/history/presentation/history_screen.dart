import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../features/history/domain/history_service.dart';
import '../../../shared/services/local_storage_service.dart';
import '../../../features/talk/domain/talk_repository.dart';
import '../../../shared/models/talk_question.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final historyService = ref.watch(historyServiceProvider);
    final localStorageService = ref.watch(localStorageServiceProvider);
    final talkRepository = ref.watch(talkRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'ホーム',
          onPressed: () => context.go('/'),
        ),
        automaticallyImplyLeading: false,
        title: const Text('思い出'),
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, List<String>>>(
          future: historyService.loadAllMissionSessions(),
          builder: (context, missionSnapshot) {
            return FutureBuilder<List<String>>(
              future: localStorageService.loadFavoriteTalkIds(),
              builder: (context, talkSnapshot) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ミッション履歴
                      Text(
                        '最近のふたりミッション',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      if (missionSnapshot.connectionState ==
                          ConnectionState.waiting)
                        const Center(child: CircularProgressIndicator())
                      else if (missionSnapshot.hasData &&
                          missionSnapshot.data!.isNotEmpty)
                        ...missionSnapshot.data!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: AppCard(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '達成したミッション: ${entry.value.length}件',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      else
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('まだミッション履歴がありません'),
                        ),
                      const SizedBox(height: 32),
                      // トーク履歴
                      Text(
                        'お気に入りの質問',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      if (talkSnapshot.connectionState ==
                          ConnectionState.waiting)
                        const Center(child: CircularProgressIndicator())
                      else if (talkSnapshot.hasData &&
                          talkSnapshot.data!.isNotEmpty)
                        ...talkSnapshot.data!.take(5).map((favoriteId) {
                          final allQuestions = talkRepository.getAll();
                          final question = allQuestions.firstWhere(
                            (q) => q.id == favoriteId,
                            orElse: () => const TalkQuestion(
                              id: '',
                              category: '',
                              text: '質問が見つかりません',
                            ),
                          );
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: AppCard(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    question.category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    question.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      else
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('まだお気に入りの質問がありません'),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

