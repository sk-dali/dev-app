import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../../shared/models/talk_question.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/talk_repository.dart';

class TalkState {
  final TalkQuestion? current;
  final String? selectedCategory;
  final Set<String> favoriteIds;
  final List<TalkQuestion> availableQuestions;

  TalkState({
    this.current,
    this.selectedCategory,
    Set<String>? favoriteIds,
    List<TalkQuestion>? availableQuestions,
  })  : favoriteIds = favoriteIds ?? {},
        availableQuestions = availableQuestions ?? [];

  TalkState copyWith({
    TalkQuestion? current,
    String? selectedCategory,
    Set<String>? favoriteIds,
    List<TalkQuestion>? availableQuestions,
  }) {
    return TalkState(
      current: current ?? this.current,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      availableQuestions: availableQuestions ?? this.availableQuestions,
    );
  }
}

class TalkController extends StateNotifier<TalkState> {
  final TalkRepository _repository;
  final LocalStorageService _storageService;
  final Random _random = Random();

  TalkController(this._repository, this._storageService)
      : super(TalkState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await _storageService.loadFavoriteTalkIds();
    state = state.copyWith(favoriteIds: ids.toSet());
  }

  void init() {
    final allQuestions = _repository.getAll();
    final question = allQuestions[_random.nextInt(allQuestions.length)];
    state = state.copyWith(
      current: question,
      availableQuestions: allQuestions,
    );
  }

  void next() {
    final questions = state.availableQuestions;
    if (questions.isEmpty) return;

    final currentIndex = state.current != null
        ? questions.indexWhere((q) => q.id == state.current!.id)
        : -1;

    int nextIndex;
    if (currentIndex == -1 || currentIndex == questions.length - 1) {
      nextIndex = 0;
    } else {
      nextIndex = currentIndex + 1;
    }

    state = state.copyWith(current: questions[nextIndex]);
  }

  void previous() {
    final questions = state.availableQuestions;
    if (questions.isEmpty) return;

    final currentIndex = state.current != null
        ? questions.indexWhere((q) => q.id == state.current!.id)
        : -1;

    int previousIndex;
    if (currentIndex == -1 || currentIndex == 0) {
      previousIndex = questions.length - 1;
    } else {
      previousIndex = currentIndex - 1;
    }

    state = state.copyWith(current: questions[previousIndex]);
  }

  void changeCategory(String? category) {
    final questions = category == null
        ? _repository.getAll()
        : _repository.getByCategory(category);

    if (questions.isEmpty) {
      state = state.copyWith(
        selectedCategory: category,
        availableQuestions: questions,
        current: null,
      );
      return;
    }

    final question = questions[_random.nextInt(questions.length)];
    state = state.copyWith(
      selectedCategory: category,
      availableQuestions: questions,
      current: question,
    );
  }

  Future<void> toggleFavorite() async {
    if (state.current == null) return;

    final currentId = state.current!.id;
    final newFavorites = Set<String>.from(state.favoriteIds);

    if (newFavorites.contains(currentId)) {
      newFavorites.remove(currentId);
    } else {
      newFavorites.add(currentId);
    }

    state = state.copyWith(favoriteIds: newFavorites);
    await _storageService.saveFavoriteTalkIds(newFavorites.toList());
  }

  bool isFavorite(String questionId) {
    return state.favoriteIds.contains(questionId);
  }
}

final talkControllerProvider =
    StateNotifierProvider<TalkController, TalkState>((ref) {
  final repository = ref.read(talkRepositoryProvider);
  final storageService = ref.read(localStorageServiceProvider);
  return TalkController(repository, storageService);
});

