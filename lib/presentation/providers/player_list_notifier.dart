// Definición de PlayerListNotifier
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/player_models.dart';

class PlayerListNotifier extends StateNotifier<List<Player>> {
  PlayerListNotifier() : super([]);

  void addPlayer(Player player) {
    state = [...state, player];
  }

  void removePlayer(int index) {
    state = [...state]..removeAt(index);
  }

  void setLivesForAll(int lives) {
    state = state.map((player) => player.copyWith(lives: lives)).toList();
  }
}