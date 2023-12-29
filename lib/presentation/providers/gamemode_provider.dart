import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GameMode { quick, custom }

final gameModeProvider = StateProvider<GameMode>((ref) {
  return GameMode.quick; // Valor por defecto
});