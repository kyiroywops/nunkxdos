import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nunkxdos/presentation/providers/gamemode_provider.dart';
import 'package:video_player/video_player.dart';


class InicialHomeScreen extends ConsumerStatefulWidget {
  @override
  _InicialHomeScreenState createState() => _InicialHomeScreenState();
}

class _InicialHomeScreenState extends ConsumerState<InicialHomeScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/videos/video.mp4') // Ruta de tu video
      ..initialize().then((_) {
        _controller!.play();
        _controller!.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Video de fondo
          _controller?.value.isInitialized ?? false
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.size?.width ?? 0,
                    height: _controller!.value.size?.height ?? 0,
                    child: VideoPlayer(_controller!),
                  ),
                )
              : Container(color: Theme.of(context).colorScheme.onBackground),
          // Contenido de la aplicación
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Padding(
              padding: EdgeInsets.fromLTRB(46, 46, 46, 140),
              child: Text(
                'Nunca Nunca',
                style: TextStyle(
                  fontSize: 32.0, // Tamaño de la fuente
                  color: Colors.white, // Color de la fuente
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Lexend' // Negrita
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Partida rápida
            Padding(
               padding: const EdgeInsets.all(50.0),
               child: ElevatedButton(
                onPressed: () {
                  // Navegar a la pantalla de reglas
                  ref.read(gameModeProvider.state).state = GameMode.quick;
                  GoRouter.of(context).push('/games');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Partida normal',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600
                      ), // Letra blanca
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF46383b).withOpacity(0.85), // Fondo negro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 44, vertical: 10), // Padding interior del botón
                ),
                           ),
             ),
          
            // Partida personalizada
             Padding(
               padding: const EdgeInsets.all(50.0),
               child: ElevatedButton(
                onPressed: () {
                  // Navegar a la pantalla de reglas
                  ref.read(gameModeProvider.state).state = GameMode.custom;
                  GoRouter.of(context).push('/playerselection');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Partida personalizada',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600
                      ), // Letra blanca
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF46383b).withOpacity(0.85), // Fondo negro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 44, vertical: 10), // Padding interior del botón
                ),
                           ),
             ),
          
           Padding(
               padding: const EdgeInsets.all(100.0),
               child: ElevatedButton(
                onPressed: () {
                  // Navegar a la pantalla de reglas
                  ref.read(gameModeProvider.state).state = GameMode.custom;
                  GoRouter.of(context).push('/instructions');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'como jugar',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500
                      ), // Letra blanca
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.90), // Fondo negro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 44, vertical: 10), // Padding interior del botón
                ),
                           ),
             ), 
          
                // Tus widgets como el Text, ElevatedButton, etc.
                // ...
              ],
            ),
          ),
        ],
      ),
     
    );
  }
}
