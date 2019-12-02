import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/actor_foto.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';
import 'package:peliculas/src/pages/serie_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle(),
        'detalleSerie': (BuildContext context) => SerieDetalle(),
        'detalleFoto': (BuildContext context) => ActorFoto(),
      },
    );
  }
}
