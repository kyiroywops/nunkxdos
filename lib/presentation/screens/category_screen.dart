import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/player_models.dart';
import 'package:nunkxdos/presentation/providers/gamemode_provider.dart';
import 'package:nunkxdos/presentation/providers/player_provider.dart';
import 'package:nunkxdos/presentation/providers/questions_provider.dart';
import 'package:nunkxdos/presentation/providers/vidas_iniciales_provider.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  final String category;

  QuestionsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  late Color backgroundColor;
  String? selectedPlayerForLifeLoss; // Cambiado para almacenar solo un nombre
  int currentPlayerIndex = 0;
  int currentQuestionIndex = 0; // Nuevo índice para la pregunta actual

  @override
  void initState() {
    super.initState();
    backgroundColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    Future.microtask(
      () => ref
          .read(questionsProvider(widget.category).notifier)
          .loadQuestions(widget.category),
    );
  }

  
  void nextQuestion() {
   changeBackgroundColor();
  // Solo cambia la pregunta sin restar vidas a ningún jugador.
  final questions = ref.read(questionsProvider(widget.category)).value;
  if (questions != null && currentQuestionIndex < questions.length - 1) {
    setState(() {
      currentQuestionIndex++;
    });
  } else {
    // No hay más preguntas disponibles, muestra el diálogo de fin.
    _showFinishedDialog();
  }
}


  void loadNewQuestions() {
    // Solicita al provider que cargue nuevamente las preguntas.
    // Esto asume que el provider maneja adecuadamente la lógica para recargar y mezclar las preguntas.
    ref
        .read(questionsProvider(widget.category).notifier)
        .loadQuestions(widget.category);
  }

  void changeBackgroundColor() {
    setState(() {
      backgroundColor =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

void changeQuestion() {
  // Verifica si hay un jugador seleccionado para perder una vida.
  if (selectedPlayerForLifeLoss == null) {
    // Muestra una alerta indicando que se debe seleccionar un jugador.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        backgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.orange, width: 2),
        ),
        title: Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 68.0,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Selecciona un jugador',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Selecciona a un jugador para restarle una vida.',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      );
      },
    );
    return; // Sale del método sin cambiar la pregunta.
  }
  changeBackgroundColor();
  // Si un jugador ha sido seleccionado, procede a restarle una vida.
  handleLifeLoss(); // Llama a la función que maneja la pérdida de vidas.
  rotatePlayer(); // Rota al siguiente jugador.

  // Reinicia el estado de selectedPlayerForLifeLoss después de restar la vida.
  setState(() {
    selectedPlayerForLifeLoss = null;
  });

  // Obtiene el estado actual de las preguntas.
  final questions = ref.read(questionsProvider(widget.category)).value;
  // Verifica si hay más preguntas disponibles.
  if (questions != null && currentQuestionIndex < questions.length - 1) {
    setState(() {
      currentQuestionIndex++;
    });
  } else {
    // No hay más preguntas disponibles, muestra el diálogo de fin.
    _showFinishedDialog();
  }
}

void rotatePlayer() {
  // Verifica si hay jugadores con vidas.
  final hasPlayersWithLives = ref.read(playerProvider).any((player) => player.lives > 0);
  if (!hasPlayersWithLives) {
    // Manejar el caso en que no hay jugadores con vidas, si es necesario.
    return;
  }

  int nextPlayerIndex = currentPlayerIndex;

  // Encuentra el índice del próximo jugador con vidas.
  do {
    nextPlayerIndex = (nextPlayerIndex + 1) % ref.read(playerProvider).length;
  } while (ref.read(playerProvider)[nextPlayerIndex].lives <= 0);

  // Actualiza el índice del jugador actual.
  setState(() {
    currentPlayerIndex = nextPlayerIndex;
  });
}



void restartGame() {
  // Reinicia el índice de la pregunta actual a 0
  setState(() {
    currentQuestionIndex = 0;
  });
  // Vuelve a cargar las preguntas
  loadNewQuestions();
}

void _showFinishedDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,

    builder: (context) =>AlertDialog(
        backgroundColor: Colors.grey.shade300, // Fondo del AlertDialog
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Icon(
            Icons.hourglass_empty,
            color: Colors.black,
            size: 68.0,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
      child: Text(
        'Se acabaron las preguntas 😢',
        style: TextStyle(
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w800,
          fontSize: 24,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ),
    SizedBox(height: 16),
    Text(
      'Has respondido a todas las preguntas disponibles en esta categoría. Puedes reiniciar para jugar de nuevo o volver al menú principal para explorar otras opciones.',
      style: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
          ],
        ),
        actions: [
          
          ElevatedButton(
            onPressed: () {
            // Obtén el valor inicial de las vidas desde el provider
            final initialLives = ref.read(initialLivesProvider);
            // Restablece las vidas de todos los jugadores
            ref.read(playerProvider.notifier).resetPlayersLives(initialLives);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
            child: Text('Salir', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
  ).then((_) {
    // Opcional: Reiniciar el juego automáticamente si el diálogo se cierra sin seleccionar ninguna opción.
    restartGame();
  });
}

  Future<bool> _onWillPop() async {
    bool shouldPop = (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey.shade300, // Fondo del AlertDialog
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Icon(
                Icons.autorenew,
                color: Colors.black,
                size: 68.0,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text('¿Deseas salir?',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w800,
                            fontSize: 20))),
                SizedBox(height: 8),
                Text(
                    'Si presionas "Salir", irás a la pantalla asignar cartas y se reiniciará la partida.',
                    style: TextStyle(
                        fontFamily: 'Lexend', fontWeight: FontWeight.w400)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: TextStyle(
                        fontFamily: 'Lexend', fontWeight: FontWeight.w800)),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Salir',
                    style: TextStyle(
                        fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;

    return shouldPop;
  }

void _showWinnerDialog(Player winner) {
  showDialog(
    context: context,
    barrierDismissible: false,

    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey.shade300, // Fondo del AlertDialog
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      title: Center( // Centra el icono en el título
        child: Icon(
          Icons.star,
          color: Colors.black,
          size: 68.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        // Ajusta la alineación aquí para centrar
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('¡Felicidades ${winner.name}!', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800, fontSize: 20), textAlign: TextAlign.center),
          SizedBox(height: 8),
          Text('¡Has ganado con ${winner.lives} vidas restantes!', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w400), textAlign: TextAlign.center),
          Padding(
            padding: EdgeInsets.only(top: 20),
            // Agrandar la imagen aumentando el radio
            child: CircleAvatar(
              backgroundImage: AssetImage(winner.avatar),
              radius: 50, // Aumenta el tamaño del radio aquí para agrandar la imagen
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            // Añadir otro icono
            child: Text(winner.name, style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w900, fontSize: 25), textAlign: TextAlign.center),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center, // Esto centra los botones de acción
      actions: [
        ElevatedButton(
          onPressed: () {
            // Obtén el valor inicial de las vidas desde el provider
            final initialLives = ref.read(initialLivesProvider);
            // Restablece las vidas de todos los jugadores
            ref.read(playerProvider.notifier).resetPlayersLives(initialLives);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text('Cerrar partida', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
      
      ],
    ),
  );
}

 void _nextQuestionWithoutLifeLoss() {
  final questions = ref.read(questionsProvider(widget.category)).value;
  if (questions != null && currentQuestionIndex < questions.length - 1) {
    setState(() {
      currentQuestionIndex++;
    });
  } else {
    // No hay más preguntas disponibles, muestra el diálogo de fin.
    _showFinishedDialog();
  }
} 

  void checkForWinner() {
    final playersWithLives =
        ref.watch(playerProvider).where((player) => player.lives > 0).toList();

    if (playersWithLives.length == 1) {
      // Solo queda un jugador con vidas, es el ganador
      _showWinnerDialog(playersWithLives.first);
    }
  }

void handleLifeLoss() {
  if (selectedPlayerForLifeLoss != null) {
    // Llama a removeLife en el notifier para restar una vida al jugador seleccionado.
    ref.read(playerProvider.notifier).removeLife(selectedPlayerForLifeLoss!);

    // No es necesario llamar a un método separado para eliminar al jugador aquí,
    // asumiendo que `removeLife` ya maneja la eliminación de jugadores sin vidas.

    // Verifica si hay un ganador después de la posible eliminación.
    checkForWinner();

    // Reinicia el estado de selectedPlayerForLifeLoss a null.
    setState(() {
      selectedPlayerForLifeLoss = null;
    });
  }
}





  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionsProvider(widget
        .category)); // Esto asegura que la UI se actualice con los cambios

    final gameMode = ref.watch(gameModeProvider.state).state;
    final players = ref.watch(playerProvider);
    Player? currentPlayer = gameMode == GameMode.custom && players.isNotEmpty
        ? players[currentPlayerIndex]
        : null;
    // Esta comprobación asegura que solo se acceda a currentPlayer si estamos en un modo de juego que utiliza jugadores.

    final questionsAsyncValue = ref.watch(questionsProvider(widget.category));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 23),
              onPressed: () async {
                if (await _onWillPop()) {
                      // Obtén el valor inicial de las vidas desde el provider
                  final initialLives = ref.read(initialLivesProvider);
                  // Restablece las vidas de todos los jugadores
                  ref.read(playerProvider.notifier).resetPlayersLives(initialLives);

                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        body: questionsAsyncValue.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (questions) {
            // Verifica que hay preguntas disponibles y que el índice es válido.
            if (questions.isNotEmpty && currentQuestionIndex < questions.length) {
              // Obtiene la pregunta actual basada en el índice.
              final currentQuestion = questions[currentQuestionIndex];
              
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Cultura Chupistica',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 3, 30, 3),
                      child: Text(
                        widget.category,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  // Aquí continuarás con el resto del contenido...
                  Expanded(
                    child: questions.isEmpty
                        ? Center(
                            child: Text(
                            'No me quedan más preguntas. 🥲',
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white),
                          ))
                        : GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity! > 0) {
                                changeQuestion();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 40),
                                    child: Text(
                                      currentQuestion.content,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (gameMode == GameMode.custom) ...[
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                currentPlayer?.avatar ??
                                                    'assets/images/avatars/avatar1.png'),
                                            radius: 25,
                                          ),
                                          SizedBox(width: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                                currentPlayer?.name ??
                                                    'Sin jugadores',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Lexend',
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Comienza ${currentPlayer?.name} y después el jugador a su derecha.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Jugadores',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: ListView.builder(
                                          itemCount: players.length,
                                          itemBuilder: (context, index) {
                                            final player = players[index];

                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage:
                                                    AssetImage(player.avatar),
                                              ),
                                              title: Text(player.name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Lexend',
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              subtitle: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(
                                                  player.lives,
                                                  (_) => Text('❤️',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              trailing: player.lives >
                                                      0 // Solo mostramos la "X" si el jugador tiene vidas
                                                  ? IconButton(
                                                      icon: Icon(
                                                        selectedPlayerForLifeLoss == player.name ? Icons.close : Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          // Si el jugador ya estaba seleccionado, deselecciona.
                                                          if (selectedPlayerForLifeLoss == player.name) {
                                                            selectedPlayerForLifeLoss = null;
                                                          } else {
                                                            // Selecciona el nuevo jugador y deselecciona cualquier otro previamente seleccionado.
                                                            selectedPlayerForLifeLoss = player.name;
                                                          }
                                                        });
                                                      },
                                                    )
                                                  : null, // Si no tiene vidas, no mostramos ningún botón
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (gameMode == GameMode.custom) ...[
                        // Botón para "Pasar" solo visible en GameMode.custom
                        ElevatedButton.icon(
                          onPressed: nextQuestion, // Esta función maneja el cambio de pregunta sin afectar las vidas
                          icon: Icon(Icons.skip_next, color: Colors.black),
                          label: Text(
                            'Pasar',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lexend',
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          )
                        ),
                      ],
                      // Botón para "Siguiente pregunta" visible en ambos modos, pero su acción depende del modo
                      ElevatedButton.icon(
                        onPressed: () {
                          if (gameMode == GameMode.quick) {
                            // En GameMode.quick simplemente cambia a la siguiente pregunta
                            _nextQuestionWithoutLifeLoss();
                          } else {
                            // En GameMode.custom maneja la lógica de vidas y selección de jugadores
                            changeQuestion();
                          }
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.black),
                        label: Text(
                          questions.isEmpty ? 'Reiniciar Juego' : 'Siguiente pregunta',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lexend',
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),

                ],

              );
            
  }
            }

        // Ubicación del botón
      ),
      )
    );
  }
}
