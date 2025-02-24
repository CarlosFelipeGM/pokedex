import 'package:dio/dio.dart';
import 'package:pokedex_app/core/exceptions/error_desconocido.dart';
import 'package:pokedex_app/core/exceptions/error_no_encontrado.dart';
import 'package:pokedex_app/core/exceptions/error_parametros.dart';
import 'package:pokedex_app/core/exceptions/error_servidor.dart';
import 'package:pokedex_app/core/exceptions/error_sin_autorizacion.dart';
import 'package:pokedex_app/core/exceptions/error_sin_conexion.dart';

class PokemonApiDataSource {
  late Dio _dio;

  PokemonApiDataSource() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/pokemon',
        responseType: ResponseType.json,
      ),
    );
  }

  Future<Map<String, dynamic>> peticionGet({
    required String path,
    Map<String, dynamic> parametros = const {},
  }) async {
    try {
      final resultado = await _dio.get(path, queryParameters: parametros);
      return resultado.data['data'];
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw ErrorSinConexion();
      }

      final respuestaError = e.response;

      final codigoError = respuestaError?.statusCode ?? 500;

      if (codigoError == 401) {
        throw ErrorSinAutorizacion();
      } else if (codigoError == 404) {
        throw ErrorNoEncontrado();
      } else if (codigoError == 409) {
        throw ErrorParametros();
      } else if (codigoError >= 500) {
        throw ErrorServidor();
      } else {
        throw ErrorDesconocido();
      }
    }
  }
}
