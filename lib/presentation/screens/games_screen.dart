import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Game {
  final Color color;
  final String route;
  final String name;
  final String subtitle;
  final String emoji;

  Game(
      {required this.color,
      required this.route,
      required this.name,
      required this.subtitle,
      required this.emoji});
}

class GamesScreen extends ConsumerWidget {
  final List<Game> games = [
    // Añade tus juegos aquí
    Game(
        color: Color(0xFF875946),
        route: '/game1',
        name: 'normal',
        subtitle: 'Divertido y emocionante',
        emoji: '😜'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'sexual',
        subtitle: 'Desafiante y estratégico',
        emoji: '🤫'),

      
    // Más juegos...
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Selecciona un Juego'),
      ),
      body: 
      GridView.builder(
        padding: const EdgeInsets.all(16), // Padding exterior aumentado
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20, // Espacio horizontal aumentado
          mainAxisSpacing: 20, // Espacio vertical aumentado
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          var game = games[index];
          return GestureDetector(
            onTap: () => GoRouter.of(context).go(game.route),
            child: Container(
              padding: const EdgeInsets.all(16), // Padding interior aumentado
              decoration: BoxDecoration(
                color: game.color,
                borderRadius:
                    BorderRadius.circular(30), // Bordes más redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de sombra
                    spreadRadius: 0,
                    blurRadius: 10, // Nivel de desenfoque de la sombra
                    offset: Offset(0, 4), // Posición de la sombra
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(game.emoji, style: TextStyle(fontSize: 44)),
                  SizedBox(height: 8), // Espacio entre elementos
                  Text(game.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w900)),
                  SizedBox(height: 4),
                  Text(game.subtitle,
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
