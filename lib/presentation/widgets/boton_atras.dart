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
        title: Text('Confirmación', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
        content: Text('¿Quieres volver a la página de inicio y reiniciar los datos?', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w400)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sí', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
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
