import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instrucciones')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Aquí van las instrucciones del juego...',
          // Estilo y contenido de tus instrucciones
        ),
      ),
    );
  }
}
