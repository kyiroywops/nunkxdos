import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/question_models.dart';

class QuestionsNotifier extends StateNotifier<List<Question>> {
  QuestionsNotifier() : super([]);

  void loadQuestions(String category) {
    // Lista simulada de todas las preguntas
    List<Question> allQuestions = [
      Question(category: 'normal', content: '1'),
      Question(category: 'normal', content: '2'),
      Question(category: 'normal', content: '3'),
      Question(category: 'normal', content: '4'),
      Question(category: 'sexual', content: 'Yo nunca nunca he...'),
      // Agrega más preguntas aquí...
    ];

    // Filtrar preguntas por categoría
    List<Question> filteredQuestions = allQuestions.where((question) => question.category == category).toList();
    state = filteredQuestions..shuffle(Random());
  }
}

final questionsProvider =
    StateNotifierProvider.family<QuestionsNotifier, List<Question>, String>(
  (ref, category) => QuestionsNotifier()..loadQuestions(category),
);
