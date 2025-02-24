import 'package:pokedex_app/models/pokemon_thumbnail.dart';

class Pokemon {
  final int id;
  final String name;
  final PokemonThumbnail thumbnail;

  Pokemon({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory Pokemon.fromMap(Map<String, dynamic> data) {
    return Pokemon(
      id: data['id'],
      name: data['name'],
      thumbnail: PokemonThumbnail.fromMap(data['thumbnail']),
    );
  }
}
