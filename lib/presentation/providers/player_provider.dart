
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/player_models.dart';
import 'package:nunkxdos/presentation/providers/player_list_notifier.dart';

final currentPlayerIndexProvider = StateProvider<int>((ref) => 0);

final playerProvider = StateNotifierProvider<PlayerListNotifier, List<Player>>((ref) {
  return PlayerListNotifier();
});
