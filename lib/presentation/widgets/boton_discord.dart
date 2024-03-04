import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscordDialog extends StatelessWidget {
  final String discordUrl;

  DiscordDialog({required this.discordUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Icon(
          Icons.discord, // Aquí puedes usar el icono de Discord
          color: Colors.black,
          size: 68.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Únete a nuestra comunidad de Discord',
              style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Para feedback, por favor ingresa al link de nuestra comunidad de Discord.',
            style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w400),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('No', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800)),
        ),
        ElevatedButton(
          onPressed: () async {
            if (await canLaunch(discordUrl)) {
              await launch(discordUrl);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No se pudo abrir el enlace de Discord')),
              );
            }
          },
          child: Text('Abrir Discord', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
