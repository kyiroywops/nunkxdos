import 'dart:ui';

class Game {
  final Color color;
  final String category; // Usaremos category en lugar de route
  final String name;
  final String subtitle;
  final String emoji;

  Game({
    required this.color,
    required this.category, // Cambio aquí
    required this.name,
    required this.subtitle,
    required this.emoji,
  });
}