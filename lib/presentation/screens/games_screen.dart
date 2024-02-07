import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nunkxdos/infrastructure/models/game_models.dart';
import 'package:nunkxdos/presentation/providers/gamemode_provider.dart';
import 'package:nunkxdos/presentation/widgets/boton_atras.dart';
import 'package:nunkxdos/presentation/widgets/boton_discord.dart';

class GamesScreen extends ConsumerWidget {
  // URL de tu comunidad en Discord
  



  final List<Game> games = [
    // Añade tus juegos aquí
    Game(
        color: Color(0xFF46383b),
        category: 'normal',
        name: 'normal',
        subtitle: 'Juego estándar de Cultura Chupística con preguntas generales y retos divertidos.',
        emoji: '😜'),
    Game(
        color: Color(0xFFF56A79),
        category: 'marcas',
        name: 'marcas',
        subtitle: 'Nombra diferentes marcas en cada ronda. Quien repita o no sepa, ¡bebe!',

        emoji: '🏷️'),
    Game(
        color: Color(0xFF16A5A3),
        category: 'series',
        name: 'series',
        subtitle: 'Duelo de conocimientos sobre series televisivas populares.',
        emoji: '📺'),
    Game(
        color: Color(0xFFFF414D),
        category: 'peliculas',
        name: 'películas',
        subtitle: 'Competencia cinéfila: comparte y descubre películas icónicas.',
        emoji: '🎬'),
    Game(
        color: Color(0xFF1AA6B7),
        category: 'actores',
        name: 'actores',
        subtitle: '¿Quién sabe más? Un desafío sobre estrellas de la pantalla grande.',
        emoji: '🌟'),
    Game(
        color: Color(0xFFFFB15C),
        category: 'deportes',
        name: 'deportes',
        subtitle: 'Desafío para los amantes del deporte, desde fútbol hasta tenis.',
        emoji: '🏅'),
    Game(
        color: Color(0xFF8C8EB8),
        category: 'musica',
        name: 'música',
        subtitle: 'Batalla de bandas y solistas: un juego para melómanos.',
        emoji: '🎵'),
    Game(
        color: Color(0xFF1D152D),
        category: 'historia',
        name: 'historia',
        subtitle: 'Viaja en el tiempo con preguntas sobre eventos históricos.',
        emoji: '🏰'),
    Game(
        color: Color(0xFFDA2864),
        category: 'geografia',
        name: 'geografía',
        subtitle: 'Explora el mundo con desafíos sobre países y ciudades.',
        emoji: '🌍'),
    Game(
        color: Color(0xFF9AE1E2),
        category: 'ciudades',
        name: 'ciudades',
        subtitle: 'Un tour por las ciudades más icónicas del mundo.',
        emoji: '🏙️'),
    Game(
    color: Color(0xFFA4C639), // Un color que evoque la temática de la película
    category: 'senor_anillos',
    name: 'El Señor de los Anillos',
    subtitle: 'Desafíos y trivia sobre la épica saga de El Señor de los Anillos.',
    emoji: '🧝‍♂️'),
    // colocar un anillo como emoji
    

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
              icon: Icon(Icons.discord, color: Colors.white,),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DiscordDialog(discordUrl: 'https://discord.gg/EHqWWN59'); // Coloca aquí tu URL de Discord
                  },
                );
              },
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
          if (game.isPremium) {
            _showUnlockDialog(context, game);
          } else {
            GoRouter.of(context).push('/questions', extra: game.category);
          }
        },
        child: Opacity(
          opacity: game.isPremium ? 1.0 : 1.0, // Juegos premium más opacos
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: game.color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center, // Centra los elementos dentro del Stack
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(game.emoji, style: TextStyle(fontSize: 37)),
                    SizedBox(height: 4),
                    Text(game.name, style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Lexend', fontWeight: FontWeight.w900)),
                    SizedBox(height: 4),
                    Text(game.subtitle, style: TextStyle(fontSize: 8, color: Colors.white.withOpacity(0.9), fontFamily: 'Lexend', fontWeight: FontWeight.w500)),
                  ],
                ),
                if (game.isPremium) Align(
                  alignment: Alignment.topRight, // Alinea el candado en el centro del Stack

                  child: Icon(Icons.lock, size: 30, color: Colors.white),
 
                ),
              ],
            ),
          ),
        ),
      );
        },
      ),
    );
  }
}

void _showUnlockDialog(BuildContext context, Game game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Desbloquear Juego'),
        content: Text('Este juego está bloqueado. Paga \$2 mensuales o \$8 para desbloquearlo para siempre.'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Pagar'),
            onPressed: () {
              // Lógica para manejar el pago
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }