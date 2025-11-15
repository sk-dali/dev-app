class Mission {
  final String id;
  final String placeCategory;
  final String title;
  final String description;
  final int difficulty;

  const Mission({
    required this.id,
    required this.placeCategory,
    required this.title,
    required this.description,
    this.difficulty = 1,
  });
}

