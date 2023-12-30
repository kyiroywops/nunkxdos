import 'dart:ui';

class Game {
  final String name;
  final String category;
  final String subtitle;
  final String emoji;
  final Color color;
  final bool isPremium; // Nueva propiedad

  Game({
    required this.name,
    required this.category,
    required this.subtitle,
    required this.emoji,
    required this.color,
    this.isPremium = false, // Valor predeterminado falso
  });
}
