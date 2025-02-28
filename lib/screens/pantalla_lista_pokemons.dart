import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';
import 'package:pokedex_app/routes/routes.dart';

class PantallaListaPokemons extends StatefulWidget {
  const PantallaListaPokemons({super.key});

  @override
  State<PantallaListaPokemons> createState() => _PantallaListaPokemonsState();
}

class _PantallaListaPokemonsState extends State<PantallaListaPokemons> {
  final pokemonRepository = PokemonRepository();
  var estaCargando = false;
  final _pagingController = PagingController<int, Pokemon>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _obtenerPokemones(pageKey);
    });
    super.initState();
  }

  void _obtenerPokemones(int pageKey) async {
    final limit = 15;
    final offset = (pageKey - 1) * limit;
    final pokemonesResultado =
        await pokemonRepository.obtenerPokemones(limit: limit, offset: offset);
    pokemonesResultado.fold((falla) {
      _pagingController.error = falla;
    }, (listaPokemones) {
      final esPaginaFinal = listaPokemones.results.length < limit;
      if (esPaginaFinal) {
        _pagingController.appendLastPage(listaPokemones.results);
      } else {
        _pagingController.appendPage(listaPokemones.results, pageKey + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pokemones')),
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: PagedListView<int, Pokemon>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            animateTransitions: true,
            firstPageProgressIndicatorBuilder: (context) {
              return SpinKitDualRing(color: Colors.red);
            },
            newPageProgressIndicatorBuilder: (context) {
              return SpinKitDualRing(color: Colors.red);
            },
            itemBuilder: (_, pokemon, indice) {
              final numeroDeOrden = indice + 1;
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.detallePokemon,
                    arguments: pokemon.id,
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      pokemon.thumbnail.rutaCompleta),
                ),
                title: Text('#$numeroDeOrden ${pokemon.name}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
