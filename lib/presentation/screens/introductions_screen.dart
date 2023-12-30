import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 23),
          onPressed: () => Navigator.of(context).pop(),
          padding: EdgeInsets.only(left: 16.0), // Agrega padding a la izquierda
        ),
        
        backgroundColor: Colors.primaries[1],
        title: Text('Instrucciones', style: TextStyle(fontFamily: 'Lexend', color: Colors.white, fontWeight: FontWeight.w700))
        ),
      backgroundColor: Colors.primaries[1],
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
