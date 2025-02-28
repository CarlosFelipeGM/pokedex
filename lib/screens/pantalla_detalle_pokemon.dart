import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';
import 'package:pokedex_app/ui/mostrar_falla.dart';

class PantallaDetallePokemon extends StatelessWidget {
  final PokemonRepository _pokemonRepository;
  PantallaDetallePokemon({super.key})
      : _pokemonRepository = PokemonRepository();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int?;

    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalles'),
        ),
        body: Center(
          child: Text('Error, se necesita un id para cargar los detalles'),
        ),
      );
    }

    return FutureBuilder(
      future: _pokemonRepository.obtenerDetallePokemon(id),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.match((f) {
            return MostrarFalla(falla: f);
          }, (pokemon) {
            return Scaffold(
              appBar: AppBar(title: Text('Detalles')),
              body: ListView(
                children: [
                  CachedNetworkImage(imageUrl: pokemon.thumbnail.rutaCompleta),
                  Text(
                    pokemon.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descripcion:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (pokemon.descripcion.isEmpty) ...[
                          Text('No hay descripcion disponible')
                        ] else ...[
                          Text(pokemon.descripcion),
                        ],
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Cargando'),
          ),
          body: Center(
            child: SpinKitDualRing(color: Colors.red),
          ),
        );
      },
    );
  }
}
