import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/talk_question.dart';
import '../data/mock_talk_data.dart';

abstract class TalkRepository {
  List<TalkQuestion> getAll();
  List<TalkQuestion> getByCategory(String category);
}

class TalkRepositoryImpl implements TalkRepository {
  @override
  List<TalkQuestion> getAll() {
    return List.from(mockTalkQuestions);
  }

  @override
  List<TalkQuestion> getByCategory(String category) {
    return mockTalkQuestions
        .where((question) => question.category == category)
        .toList();
  }
}

final talkRepositoryProvider = Provider<TalkRepository>((ref) {
  return TalkRepositoryImpl();
});

