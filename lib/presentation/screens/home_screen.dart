// lib/presentation/screens/player_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nunkxdos/infrastructure/models/player_models.dart';
import 'package:nunkxdos/presentation/providers/gamemode_provider.dart';
import 'package:nunkxdos/presentation/providers/player_provider.dart';
import 'package:nunkxdos/presentation/providers/vidas_iniciales_provider.dart';

class PlayerSelectionScreen extends ConsumerStatefulWidget {
  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends ConsumerState<PlayerSelectionScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedAvatar =
      'assets/images/avatars/avatar1.png'; // Ruta al avatar por defecto

    bool _showAddedMessage = false; // Atributo para controlar la visualización del mensaje
    String _addedPlayerName = ''; // Nombre del jugador agregado
    bool _isButtonPressed = false;



  @override
  Widget build(BuildContext context) {
    List<Player> players = ref.watch(playerProvider);
    final gameMode = ref.watch(gameModeProvider.state).state;
    int _selectedLives = ref.watch(initialLivesProvider.state).state;

    // estado de vidas
   void _handleLifeSelection(int numLives) {
      setState(() {
        _selectedLives = numLives;
      });
      ref.read(initialLivesProvider.state).state = numLives; // Aquí actualizamos el provider
    }


    void _addPlayer() {
  final String name = _nameController.text.trim();

  // Verifica si el nombre ya está en uso
  bool nameExists = players.any((player) => player.name.toLowerCase() == name.toLowerCase());

  if (nameExists) {
    _showNameExistsAlert(context);
    return;
  }

  int maxPlayers = gameMode == GameMode.custom ? 30 : 10;
  if (players.length >= maxPlayers) {
    _showMaxPlayersAlert(context, gameMode);
    return;
  }

  if (name.isNotEmpty && _selectedAvatar.isNotEmpty) {
    ref.read(playerProvider.notifier).addPlayer(
      Player(name: name, avatar: _selectedAvatar, lives: _selectedLives),
    );
    _nameController.clear();
    _selectedAvatar = 'assets/images/avatars/avatar1.png';

    // Oculta el mensaje después de unos segundos
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) { // Verifica si el State está montado antes de llamar a setState
        setState(() {
          _showAddedMessage = false;
        });
      }
    });

    // Inmediatamente después de agregar el jugador y aún dentro de la condición de éxito, muestra el mensaje
    setState(() {
      _showAddedMessage = true;
      _addedPlayerName = name;
    });
  }
}

    void _removePlayer(int index) {
      ref.read(playerProvider.notifier).removePlayer(index);
    }

    final Size screenSize = MediaQuery.of(context).size;
    final bool isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        onPressed: () {
          GoRouter.of(context).go('/');
          

          },
          padding: EdgeInsets.only(
              left: 16), // Agrega padding a la izquierda del icono
        ), // Esto cambiará el color del botón de retroceso a blanco
        title: Text(
          'Arma tu grupo',
          style: TextStyle(
            fontWeight: FontWeight.w800, fontFamily: 'Lexend',
            color: Theme.of(context).colorScheme.background,

            // Aplica negrita al texto
            // Puedes añadir más estilos si lo deseas, como el tamaño de la fuente o el color
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  40, screenSize.height * 0.02, 40, screenSize.height * 0.1),
              child: Column(
                children: [
            //        Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Text('Vida de todos los jugadores', style: TextStyle(color: Colors.white,
            //   fontFamily: 'Lexend',
            //   fontWeight: FontWeight.w700
              
            //   )),
            // ), 
        
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(4, (index) {
            //     int numLives = index + 1;
            //     bool isSelected = numLives == _selectedLives;
            //     return Padding(
            //       padding: const EdgeInsets.all(4.0),
            //       child: ElevatedButton(
                    
            //         style: ElevatedButton.styleFrom(
                      
            //           primary: isSelected ? Colors.orange : Color(0xFF46383b), // Cambia el color si está seleccionado
            //           onPrimary: Colors.white,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30),
            //           ),
            //           elevation: isSelected ? 10 : 5, // Elevación más pronunciada si está seleccionado
            //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //           side: isSelected
            //               ? BorderSide(color: Colors.orangeAccent, width: 2) // Borde si está seleccionado
            //               : null,
            //         ),
            //          onPressed: () => _handleLifeSelection(numLives),
            // // ...
            //         child: Text(
            //           '$numLives ❤️',
            //           style: TextStyle(
            //             fontFamily: 'Lexend',
            //             fontWeight: FontWeight.w600,
            //             color: isSelected ? Colors.white : Colors.grey[200], // Cambia el color del texto si está seleccionado
            //           ),
            //         ),
            //       ),
            //     );
            //   }),
            // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
                    child: Container(
                      height: screenSize.height *
                          0.2, // Ajusta esta altura según tus necesidades
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                            BorderRadius.circular(20), // Bordes redondeados
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7, // Ajusta según el diseño de tu UI
                            crossAxisSpacing: 5, // Espaciado horizontal
                            mainAxisSpacing: 12, // Espaciado vertical
                          ),
                          itemCount: 21, // Asume que tienes 20 avatares
                          itemBuilder: (context, index) {
                            String avatarAsset = 'assets/images/avatars/avatar${index + 1}.png';
                            bool isSelected = _selectedAvatar == avatarAsset;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAvatar = avatarAsset; // Actualiza el avatar seleccionado
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: isSelected ? 100 : 80, // Ajusta estos tamaños según necesites
                                height: isSelected ? 100 : 80, // Ajusta estos tamaños según necesites
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: isSelected ? Border.all(color: Colors.green, width: 3) : null,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    avatarAsset,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // Fondo gris para el container
              borderRadius: BorderRadius.circular(20), // Bordes redondeados para el container
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.green, // Color del borde cuando está enfocado
                ),
              ),
              child: TextField(
                 inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
                
                controller: _nameController,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ), // Aplica el mismo estilo que el hintStyle
                cursorColor: Colors.green, // Color del cursor a verde
                decoration: InputDecoration(
                  hintText: 'Nombre del jugador',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent, width: 0), // Sin borde visible cuando no está enfocado
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent, width: 0), // Sin borde visible cuando no está enfocado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.green, width: 2.0), // Borde verde cuando está enfocado
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30, // Aumenta el padding horizontal
                    vertical: 15, // Aumenta el padding vertical
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add_circle_rounded, color: Colors.black),
                    onPressed: players.length >= 20 ? null : _addPlayer,
                  ),
                ),
              ),
            ),
          ),
        ),
                  _showAddedMessage 
                    ? 
                          Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300, // Color de fondo del contenedor
            borderRadius: BorderRadius.circular(15.0),
            border: Border(
              left: BorderSide(
                color: Colors.green, // Color del borde izquierdo
                width: 5.0, // Ancho del borde izquierdo
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'El jugador $_addedPlayerName se ha agregado con éxito.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
                    : SizedBox.shrink(),
                  SizedBox(height: screenSize.height * 0.03),
                  Center(
                    child: Text(
                       'Listado de Jugadores (${players.length})',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight
                            .w700, // Si deseas que el texto esté en negrita
                        fontSize:
                            24, // Puedes ajustar el tamaño según tus necesidades
                        // Otros estilos si son necesarios
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Container(
                    height: screenSize.height * 0.4,
                    child: ListView.builder(
                      itemCount: players
                          .length, // Usar la longitud de la lista obtenida del provider
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage(players[index].avatar),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    players[index].name,
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                // Icono para eliminar jugadores
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Color(0xffFF414D)),
                                  onPressed: () {
                                    // Llama a la función para eliminar este jugador específico
                                    _removePlayer(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          isKeyboardVisible
              ? SizedBox.shrink()
              : Positioned(
                  right: screenSize.width * 0.05,
                  bottom: screenSize.height * 0.05,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (players.length < 2) {
                        _showNoPlayersAlert(context);
                      } else {
                        // Opcional: Imprimir la información de los jugadores
                        final updatedPlayers = ref.read(playerProvider);
                        for (var player in updatedPlayers) {
                          print('Jugador: ${player.name}');
                        }

                        
                           
                      GoRouter.of(context).go('/games');
                      }
                    },
                    icon: Icon(Icons.play_arrow, color: Colors.white),
                    label: Text('Jugar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width *
                            0.05, // 5% del ancho de la pantalla
                        vertical: screenSize.height *
                            0.01, // 1% del alto de la pantalla
                      ),
                      textStyle: TextStyle(
                          fontFamily: 'Lexend', fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

void _showPlayerAddedAlert(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade300, // Fondo del AlertDialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.green, width: 2), // Borde verde
        ),
        title: Icon(
          Icons.check_circle_outline, // Ícono de verificación
          color: Colors.green, // Color del ícono a verde
          size: 68.0,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Jugador agregado',
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
              'El jugador ha sido agregado correctamente.',
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
                color: Colors.green,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showMaxPlayersAlert(BuildContext context, GameMode gameMode) {
  String alertMessage = gameMode == GameMode.custom
      ? 'No se pueden agregar más de 30 jugadores.'
      : 'No se pueden agregar más de 10 jugadores.';

  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.red, width: 2),
        ),
        title: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 68.0,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Límite alcanzado',
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
              alertMessage,
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
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showNameExistsAlert(BuildContext context) {
  showDialog<void>(
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
                'Nombre en uso',
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
              'Ya existe un jugador con este nombre. Por favor, elige otro nombre.',
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
}

void _showNoPlayersAlert(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 68.0,
        ),
        content: Text(
          'Debe haber al menos dos jugadores para comenzar el juego.',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
