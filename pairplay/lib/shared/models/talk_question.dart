class TalkQuestion {
  final String id;
  final String category;
  final String text;

  const TalkQuestion({
    required this.id,
    required this.category,
    required this.text,
  });

  TalkQuestion copyWith({
    String? id,
    String? category,
    String? text,
  }) {
    return TalkQuestion(
      id: id ?? this.id,
      category: category ?? this.category,
      text: text ?? this.text,
    );
  }
}

