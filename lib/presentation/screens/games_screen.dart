import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // URL de tu comunidad en Discord
  final String discordUrl = 'https://discord.gg/tuComunidad';

  // Método para abrir el enlace de Discord
  void _launchDiscord(BuildContext context) async {
    if (await canLaunch(discordUrl)) {
      await launch(discordUrl);
    } else {
      // Mostrar error o manejar la situación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el enlace de Discord')),
      );
    }
  }

  final List<Game> games = [
    // Añade tus juegos aquí
    Game(
        color: Color(0xFF46383b),
        route: '/game1',
        name: 'normal',
        subtitle: 'confesiones casuales para romper el hielo',
        emoji: '😜'),
    Game(
        color: Color(0xFFF56A79),
        route: '/game2',
        name: 'sexual',
        subtitle: 'descubre secretos con un toque picante',
        emoji: '🤫'),
    Game(
        color: Color(0xFFFF414D),
        route: '/game2',
        name: 'ilegal',
        subtitle: 'revelaciones atrevidas y al borde de la ley',
        emoji: '🚔'),
    Game(
        color: Color(0xFF1AA6B7),
        route: '/game2',
        name: 'ebrios',
        subtitle: 'verdades desternillantes entre tragos y risas',
        emoji: '🍺'),
    Game(
        color: Color(0xFFFFB15C),
        route: '/game2',
        name: 'locuras',
        subtitle: 'anécdotas locas y momentos de pura insensatez',
        emoji: '🐵'),
    Game(
        color: Color(0xFF8C8EB8),
        route: '/game2',
        name: 'infancia',
        subtitle: 'recuerdos inocentes de los días de juventud',
        emoji: '🪁'),
    Game(
        color: Color(0xFF1D152D),
        route: '/game2',
        name: 'navidad',
        subtitle: 'confesiones envueltas en espíritu festivo',
        emoji: '🎁'),
    Game(
        color: Color(0xFFDA2864),
        route: '/game2',
        name: 'noches',
        subtitle: 'historias inolvidables de noches para recordar',
        emoji: '🎊'),
    Game(
        color: Color(0xFF9AE1E2),
        route: '/game2',
        name: 'autos',
        subtitle: 'aventuras y travesuras sobre ruedas',
        emoji: '🚗'),
    Game(
        color: Color(0xFF16A5A3),
        route: '/game2',
        name: 'ex parejas',
        subtitle: 'anécdotas de romances que quedaron en la historia',
        emoji: '💔'),
    Game(
        color: Color(0xFF46383b),
        route: '/game2',
        name: 'juegos de computador',
        subtitle: 'secretos de sesiones de juego y misiones nocturnas',
        emoji: '🎮'),
    Game(
        color: Color(0xFF9F9BBC),
        route: '/game2',
        name: 'futbol',
        subtitle: 'asiones y faltas dentro y fuera del campo',
        emoji: '⚽'),

      
    // Más juegos...
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
       title: Text('Selecciona un Juego'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.discord, color: Colors.white), // Asegúrate de tener este ícono disponible
              onPressed: () => _launchDiscord(context),
            ),
          ),
        ],
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
                color: game.color.withOpacity(0.7),
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
                  SizedBox(height: 4), // Espacio entre elementos
                  Text(game.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w900)),
                  SizedBox(height: 4),
                  Text(game.subtitle,
                      style: TextStyle(
                          fontSize: 11, color: Colors.white.withOpacity(0.9), fontFamily: 'Lexend', fontWeight: FontWeight.w500,)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
