class Question {
  final String category;
  final String content;

  Question({required this.category, required this.content});

  factory Question.fromJson(Map<String, dynamic> json, String category) {
    return Question(
      category: category,  // Utiliza el parámetro category pasado al método
      content: json['content'],
    );
  }
}
