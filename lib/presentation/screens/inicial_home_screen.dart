import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nunkxdos/presentation/providers/gamemode_provider.dart';
import 'package:nunkxdos/presentation/widgets/boton_discord.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class InicialHomeScreen extends ConsumerStatefulWidget {
  @override
  _InicialHomeScreenState createState() => _InicialHomeScreenState();
}

class _InicialHomeScreenState extends ConsumerState<InicialHomeScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/videos/video.mp4')
      ..initialize().then((_) {
        _controller!.play();
        _controller!.setLooping(true);
        setState(() {});
      });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Video de fondo
          _controller?.value.isInitialized ?? false
              ? FittedBox(
                  fit: BoxFit
                      .cover, // Esto asegura que el video cubra el espacio disponible
                  child: SizedBox(
                    width: _controller!.value.size?.width ?? 0,
                    height: _controller!.value.size?.height ?? 0,
                    child: VideoPlayer(_controller!),
                  ),
                )
              : Container(color: Theme.of(context).colorScheme.onBackground),
          // Contenido de la aplicación
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.1),
                          child: Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: screenSize.width * 0.4,
                              height: screenSize.height * 0.3,
                              fit: BoxFit.contain,
                            ),
                          )),
                      _buildButton(context, 'Partida rápida', GameMode.quick,
                          screenSize),
                      _buildButton(context, 'Partida personalizada',
                          GameMode.custom, screenSize),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.2,
                          vertical: screenSize.height * 0.02,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push('/instructions');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Cómo jugar',
                              style: TextStyle(
                                color: Colors.black, // Color del texto
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w800,
                                fontSize: screenSize.width * 0.035,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.90), // Color de fondo del botón
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Bordes redondeados
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centrar los íconos en el Row
                        children: <Widget>[
                          IconButton(
                            icon: Icon(FontAwesomeIcons.instagram,
                                color: Colors.white),
                            onPressed: () => _launchURL(
                                'https://www.instagram.com/culturachupisticaapp'),
                          ),
                          SizedBox(width: 20), // Espacio entre los íconos
                          IconButton(
                            icon: Icon(
                              Icons.discord,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DiscordDialog(
                                      discordUrl:
                                          'https://discord.gg/EHqWWN59'); // Coloca aquí tu URL de Discord
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 20), // Espacio entre los íconos y el texto
                      Text(
                        'Recuerda beber con moderación.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '© Derechos reservados Tryagain.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w200,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    GameMode mode,
    Size screenSize, {
    bool isBlack = true,
    Color textColor = Colors.white,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.2,
        vertical: screenSize.height * 0.02,
      ),
      child: ElevatedButton(
        onPressed: () {
          // Establece el modo de juego usando gameModeProvider
          ref.read(gameModeProvider.state).state = mode;
          // Navega a la ruta correspondiente basada en el modo de juego seleccionado
          if (mode == GameMode.quick) {
            // Navega a '/games' para la partida rápida
            GoRouter.of(context).go('/games');
          } else if (mode == GameMode.custom) {
            // Navega a '/playerselection' para la partida personalizada
            GoRouter.of(context).go('/playerselection');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w800,
              fontSize: screenSize.width * 0.035,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isBlack
              ? Colors.black.withOpacity(0.85)
              : Colors.white.withOpacity(0.90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
