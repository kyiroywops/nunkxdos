
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nunkxdos/infrastructure/models/player_models.dart';

final currentPlayerIndexProvider = StateProvider<int>((ref) => 0);

final playerProvider = StateProvider<List<Player>>((ref) => []);
