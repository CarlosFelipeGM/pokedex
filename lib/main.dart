import 'package:flutter/material.dart';
import 'package:pokedex_app/routes/routes.dart';
import 'package:pokedex_app/screens/pantalla_detalle_pokemon.dart';
import 'package:pokedex_app/screens/pantalla_lista_pokemons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => PantallaListaPokemons(),
        Routes.detallePokemon: (_) => PantallaDetallePokemon(),
      },
    );
  }
}
