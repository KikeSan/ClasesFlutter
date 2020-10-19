import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaFoto extends StatelessWidget {
  final Pelicula pelicula;
  final peliculasProvider = new PeliculasProvider();

  PeliculaFoto({this.pelicula});

  @override
  Widget build(BuildContext context) {
    final Pelicula peli = ModalRoute.of(context).settings.arguments;
    //final peliProvider = new PeliculasProvider();
    print('Foto Peli> $peli');
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Hero(
                  tag: peli.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage(
                      image: NetworkImage(peli.getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      height: 560.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(peli.title,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[100])),
                SizedBox(height: 20.0),
                /* Text(
                actor.character,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
              ), */
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.2),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(39, 82, 205, 1.0),
            Color.fromRGBO(11, 13, 73, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        height: 460.0,
        width: 460.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(90, 120, 160, 0.7),
              Color.fromRGBO(49, 175, 255, 0.7),
            ])),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -60.0,
          left: -130.0,
          child: cajaRosa,
        ),
      ],
    );
  }
}
