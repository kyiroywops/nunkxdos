class Player {
  final String name;
  final String avatar;
  int lives;

  Player({required this.name, required this.avatar, required this.lives});

  Player copyWith({String? name, String? avatar, int? lives}) {
    return Player(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      lives: lives ?? this.lives,
    );
  }
}