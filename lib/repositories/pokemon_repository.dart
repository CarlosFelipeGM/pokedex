import 'package:pokedex_app/core/exceptions/error_desconocido.dart';
import 'package:pokedex_app/core/exceptions/error_parametros.dart';
import 'package:pokedex_app/core/exceptions/error_servidor.dart';
import 'package:pokedex_app/core/exceptions/error_sin_autorizacion.dart';
import 'package:pokedex_app/core/exceptions/error_sin_conexion.dart';
import 'package:pokedex_app/core/failures/failures.dart';
import 'package:pokedex_app/data_sources/pokemon_api_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokedex_app/models/lista_pokemones.dart';

class PokemonRepository {
  late PokemonApiDataSource pokemonApiDataSource;
  final String _path = '/sprites';

  PokemonRepository() {
    pokemonApiDataSource = PokemonApiDataSource();
  }

  Future<Either<Failure, ListaPokemones>> obtenerPokemones({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final resultado = await pokemonApiDataSource.peticionGet(
        path: _path,
        parametros: {'offset': offset, 'limit': limit},
      );

      return Either.right(ListaPokemones.fromMap(resultado));
    } on ErrorDesconocido {
      return Either.left(FallaDesconocida());
    } on ErrorParametros {
      return Either.left(FallaParametros());
    } on ErrorServidor {
      return Either.left(FallaServidor());
    } on ErrorSinAutorizacion {
      return Either.left(FallaDeAutorizacion());
    } on ErrorSinConexion {
      return Either.left(FallaEnLaConeccion());
    }
  }
}
