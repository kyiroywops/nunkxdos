import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/question_models.dart';

final questionsProvider = Provider.family<List<Question>, String>((ref, category) {
  // Retorna tus preguntas filtradas por categoría
  return QuestionsRepository().getQuestionsByCategory(category);
});

class QuestionsRepository {
  // Puedes inicializar tus preguntas aquí o cargarlas de una fuente externa si es necesario.
  List<Question> _questions = [
    Question(category: 'normal', content: '1'),
    Question(category: 'normal', content: '2'),
    Question(category: 'normal', content: '3'),
    Question(category: 'normal', content: '4'),
    Question(category: 'sexual', content: 'Yo nunca nunca he...'),
    // Agrega más preguntas aquí.
  ];

  List<Question> getQuestionsByCategory(String category) {
    return _questions.where((question) => question.category == category).toList();
  }
}
