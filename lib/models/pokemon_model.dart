class PokemonModel {
  final String name;
  final String imageUrl;
  final List<String> types;
  final int hp;
  final String mainMoveName;
  final int mainMovePower;

  PokemonModel({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.hp,
    required this.mainMoveName,
    required this.mainMovePower,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List typeList = json['types'] ?? [];
    List<String> extractedTypes = typeList.map((t) {
      return t['type']['name'] as String;
    }).toList();

    int extractedHp = 0;
    if (json['stats'] != null) {
      for (var statItem in json['stats']) {
        if (statItem['stat']['name'] == 'hp') {
          extractedHp = statItem['base_stat'];
          break;
        }
      }
    }

    String moveName = '';
    int movePower = 0;
    if (json['moves'] != null && (json['moves'] as List).isNotEmpty) {
      final firstMove = json['moves'][0];
      moveName = firstMove['move']['name'] ?? '';
      movePower = 60;
    }

    return PokemonModel(
      name: json['name'] ?? 'Unknown',
      imageUrl: _extractImageUrl(json),
      types: extractedTypes,
      hp: extractedHp,
      mainMoveName: moveName,
      mainMovePower: movePower,
    );
  }

  static String _extractImageUrl(Map<String, dynamic> json) {
    final sprites = json['sprites'];
    if (sprites != null && sprites['front_default'] != null) {
      return sprites['front_default'];
    }
    return '';
  }

}