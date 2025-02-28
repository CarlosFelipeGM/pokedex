import 'package:pokedex_app/models/pokemon_thumbnail.dart';

class DetallePokemon {
  final String name;
  final PokemonThumbnail thumbnail;
  final String descripcion;

  DetallePokemon({
    required this.name,
    required this.thumbnail,
    required this.descripcion,
  });

  factory DetallePokemon.fromMap(Map<String, dynamic> map) {
    final resultado = (map['results'] as List<dynamic>).first;
    return DetallePokemon(
      name: resultado['name'],
      thumbnail: PokemonThumbnail.fromMap(resultado['thumbnail']),
      descripcion: resultado['description'],
    );
  }
}
