import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/datasources/question_service.dart';
import 'package:nunkxdos/infrastructure/models/question_models.dart';

class QuestionsNotifier extends StateNotifier<AsyncValue<List<Question>>> {
  final QuestionService _questionService;
  var _isLoading = false;

  QuestionsNotifier(this._questionService, String category)
      : super(AsyncValue.loading()) {
    loadQuestions(category);
  }
 Future<void> loadQuestions(String category) async {
  state = AsyncValue.loading();
  try {
    List<Question> categoryQuestions =
        await _questionService.loadQuestions(category);
    state = AsyncValue.data(categoryQuestions..shuffle(Random()));
  } catch (e, stack) { // Aquí capturas también el StackTrace del error
    state = AsyncValue.error(e, stack); // Y aquí lo pasas como segundo argumento
  }
}
}

final questionServiceProvider = Provider<QuestionService>((ref) {
  return QuestionService();
});

final questionsProvider = StateNotifierProvider.family<QuestionsNotifier,
    AsyncValue<List<Question>>, String>(
  (ref, category) {
    final questionService = ref.watch(questionServiceProvider);
    return QuestionsNotifier(questionService, category);
  },
);
