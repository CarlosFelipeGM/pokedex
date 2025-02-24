import 'package:pokedex_app/models/pokemon.dart';

class ListaPokemones {
  final int offset;
  final int limit;
  final int total;
  final int count;

  final List<Pokemon> results;

  ListaPokemones({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory ListaPokemones.fromMap(Map<String, dynamic> data) {
    return ListaPokemones(
      offset: data['offset'],
      limit: data['limit'],
      total: data['total'],
      count: data['count'],
      results: List.from(
        (data['results'] as List<dynamic>).map((pokemon) {
          return Pokemon.fromMap(pokemon);
        }),
      ),
    );
  }
}
