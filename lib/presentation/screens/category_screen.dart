import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/question_models.dart';
import 'package:nunkxdos/presentation/providers/questions_provider.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  final String category;

  QuestionsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  late List<Question> questions;
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    resetQuestions();
  }

  void resetQuestions() {
    questions = ref.read(questionsProvider(widget.category))..shuffle(Random());
    changeBackgroundColor();
  }

  void changeBackgroundColor() {
    setState(() {
      backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

  void changeQuestion() {
    if (questions.isNotEmpty) {
      questions.removeLast();
      changeBackgroundColor();
    } else {
      _showFinishedDialog();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Salir'),
            content: Text('Si sales ahora, la partida se terminará. ¿Quieres salir?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false), // No permite salir
              ),
              TextButton(
                child: Text('Sí'),
                onPressed: () {
                  Navigator.of(context).pop(true); // Permite salir
                  resetQuestions(); // Opcional: resetear preguntas si es necesario
                },
              ),
            ],
          ),
        )) ??
        false; // Si el dialogo es cerrado por cualquier otra razón, no salir
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Fin de las preguntas'),
        content: Text('Has pasado por todas las preguntas de esta categoría.'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ).then((_) => resetQuestions()); // Reiniciar preguntas cuando se cierra el diálogo
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Preguntas de ${widget.category}'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        backgroundColor: backgroundColor,
        body: questions.isEmpty
            ? Center(child: Text('No hay más preguntas.'))
            : GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    changeQuestion();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    questions.last.content,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: changeQuestion,
        ),
      ),
    );
  }
}
