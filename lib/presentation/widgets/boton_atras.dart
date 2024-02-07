import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BotonAtras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => _showExitConfirmation(context),
    );
  }

  Future<void> _showExitConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade300, // Fondo del AlertDialog
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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
            Center(child: Text('¿Deseas salir?', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800, fontSize: 20))),
            SizedBox(height: 8),
            Text('Si presionas "Salir", irás a la pantalla inicial y se reiniciará la partida.', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w400)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
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
    );

    if (result == true) {
      // Reiniciar los datos si es necesario
      // ...

      // Navegar a la página de inicio
      GoRouter.of(context).go('/');
    }
  }
}
