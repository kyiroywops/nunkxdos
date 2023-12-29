import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nunkxdos/infrastructure/models/game_models.dart';
import 'package:nunkxdos/presentation/providers/gamemode_provider.dart';
import 'package:nunkxdos/presentation/widgets/boton_atras.dart';
import 'package:url_launcher/url_launcher.dart';

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
        category: 'normal',
        name: 'normal',
        subtitle: 'confesiones casuales para romper el hielo',
        emoji: '😜'),
    Game(
        color: Color(0xFFF56A79),
        category: 'sexual',
        name: 'sexual',
        subtitle: 'descubre secretos con un toque picante',
        emoji: '🤫'),
    Game(
        color: Color(0xFFFF414D),
        category: 'ilegal',
        name: 'ilegal',
        subtitle: 'revelaciones atrevidas y al borde de la ley',
        emoji: '🚔'),
    Game(
        color: Color(0xFF1AA6B7),
        category: 'ebrios',
        name: 'ebrios',
        subtitle: 'verdades desternillantes entre tragos y risas',
        emoji: '🍺'),
    Game(
        color: Color(0xFFFFB15C),
        category: 'locuras',
        name: 'locuras',
        subtitle: 'anécdotas locas y momentos de pura insensatez',
        emoji: '🐵'),
    Game(
        color: Color(0xFF8C8EB8),
        category: 'infancia',
        name: 'infancia',
        subtitle: 'recuerdos inocentes de los días de juventud',
        emoji: '🪁'),
    Game(
        color: Color(0xFF1D152D),
        category: 'navidad',
        name: 'navidad',
        subtitle: 'confesiones envueltas en espíritu festivo',
        emoji: '🎁'),
    Game(
        color: Color(0xFFDA2864),
        category: 'noches',
        name: 'noches',
        subtitle: 'historias inolvidables de noches para recordar',
        emoji: '🎊'),
    Game(
        color: Color(0xFF9AE1E2),
        category: 'autos',
        name: 'autos',
        subtitle: 'aventuras y travesuras sobre ruedas',
        emoji: '🚗'),
    Game(
        color: Color(0xFF16A5A3),
        category: 'exs',
        name: 'ex parejas',
        subtitle: 'anécdotas de romances que quedaron en la historia',
        emoji: '💔'),
    Game(
        color: Color(0xFF46383b),
        category: 'computador',
        name: 'juegos de computador',
        subtitle: 'secretos de sesiones de juego y misiones nocturnas',
        emoji: '🎮'),
    Game(
        color: Color(0xFF9F9BBC),
        category: 'futbol',
        name: 'futbol',
        subtitle: 'pasiones y faltas dentro y fuera del campo',
        emoji: '⚽'),

    // Más juegos...
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameMode = ref.watch(gameModeProvider.state).state;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          leading: BotonAtras(),
          title: Text('Selecciona un Juego'),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8), // Espacio entre el contenedor y el botón de Discord
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                gameMode == GameMode.custom ? 'Personalizada' : 'Rápida',
                style: TextStyle(color: Colors.white, fontFamily: 'Lexend'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(Icons.discord, color: Colors.white),
                onPressed: () => _launchDiscord(context),
              ),
            ),
          ],
        ),
      body: GridView.builder(
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
            onTap: () {
              // Aquí pasamos la categoría seleccionada a la ruta. 
              // Por ejemplo, si tuvieras una ruta '/questions', podrías pasar la categoría como un parámetro.
              GoRouter.of(context).push('/questions', extra: game.category);
            },
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
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
