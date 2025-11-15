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

class _MissionPlayScreenState extends ConsumerState<MissionPlayScreen> {
  int _currentIndex = 0;
  final List<String> _doneMissionIds = [];
  final List<String> _skippedMissionIds = [];
  List<Mission> _missions = [];

  @override
  void initState() {
    super.initState();
    _loadMissions();
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
      });
    } else {
      _showCompletionDialog();
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
          title: const Text('ミッションプレイ'),
        ),
        body: const Center(
          child: Text('このカテゴリにはミッションがありません'),
        ),
      );
    }

    if (_currentIndex >= _missions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ミッションプレイ'),
        ),
        body: const Center(
          child: Text('すべてのミッションを完了しました'),
        ),
      );
    }

    final mission = _missions[_currentIndex];
    final progress = (_currentIndex + 1) / _missions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category}のミッション'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // プログレスバー
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentIndex + 1} / ${_missions.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // ミッションカード
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mission.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        mission.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Icon(
                            Icons.star,
                            color: index < mission.difficulty
                                ? Colors.amber
                                : Colors.grey[300],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    child: OutlinedButton(
                      onPressed: () => _completeMission(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('スキップ'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _completeMission(true),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('達成'),
                    ),
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
