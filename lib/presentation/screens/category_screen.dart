import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/question_models.dart';
import 'package:nunkxdos/presentation/providers/questions_provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  final String category;

  QuestionsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  late List<Question> questions;
  late int questionIndex;

  @override
  void initState() {
    super.initState();
    // Obtener las preguntas de la categoría y mezclarlas
    questions = ref.read(questionsProvider(widget.category))..shuffle(Random());
    questionIndex = 0; // Índice de la pregunta actual
  }

  void _onCardSwiped() {
    // Incrementar el índice de la pregunta para mostrar la siguiente
    setState(() {
      questionIndex++;
    });

    if (questionIndex >= questions.length) {
      // Se han acabado todas las preguntas
      _showFinishedDialog();
    }
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¡Bien hecho!'),
          content: Text('Has respondido a todas las preguntas de esta categoría.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.of(context).pop(); // Regresar a la pantalla anterior
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Preguntas de ${widget.category}')),
        body: Center(child: Text('No hay preguntas disponibles.')),
      );
    }

    final Question currentQuestion = questions[questionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Preguntas de ${widget.category}')),
      body: SwipeCards(
        matchEngine: MatchEngine(
          swipeItems: questions.map((question) {
            return SwipeItem(
              content: question,
              likeAction: _onCardSwiped,
              nopeAction: _onCardSwiped,
              superlikeAction: _onCardSwiped,
            );
          }).toList(),
        ),
        // En tu método itemBuilder dentro de SwipeCards
itemBuilder: (BuildContext context, int index) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8, // 80% del ancho de la pantalla
      height: MediaQuery.of(context).size.height * 0.5, // 50% de la altura de la pantalla
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7), // Fondo negro con opacidad
        borderRadius: BorderRadius.circular(20), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 2), // Sombra ligeramente hacia abajo
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questions[index].category.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            questions[index].content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9), // Texto blanco con un poco de opacidad
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
},
        onStackFinished: _showFinishedDialog, // Se llama cuando se han deslizado todas las tarjetas
      ),
    );
  }
}