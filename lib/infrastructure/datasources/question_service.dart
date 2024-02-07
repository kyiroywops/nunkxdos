import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nunkxdos/infrastructure/models/question_models.dart';

class QuestionService {
  Future<List<Question>> loadQuestions(String category) async {
    final String fileName = 'assets/jsons/$category.json';  // Asegúrate de que la ruta del archivo sea correcta
    final String jsonString = await rootBundle.loadString(fileName);
    final List<dynamic> jsonResponse = json.decode(jsonString)['questions'];
    
    // Asigna la categoría a cada pregunta basada en el nombre del archivo
    return jsonResponse.map((qJson) => Question.fromJson(qJson, category)).toList();
  }
}
