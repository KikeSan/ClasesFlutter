import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
        /* appBar: AppBar(
          centerTitle: false,
          title: Text('Películas en cines'),
          backgroundColor: Color.fromRGBO(40, 16, 66, 1.0),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ), */
        body: Stack(
      children: <Widget>[
        _fondoApp(),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _header(context),
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 60.0,
        ),
        Text(
          'Películas en cines',
          style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple[100]),
        ),
        SizedBox(width: 60.0),
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.purpleAccent,
          iconSize: 30.0,
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          },
        )
      ],
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
            Color.fromRGBO(40, 16, 66, 1.0),
            Color.fromRGBO(19, 0, 29, 1.0)
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
              Color.fromRGBO(236, 98, 188, 0.2),
              Color.fromRGBO(241, 142, 172, 0.2),
            ])),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -60.0,
          left: -140.0,
          child: cajaRosa,
        ),
      ],
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 280.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
    //return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
            child: Text(
              'Populares',
              style: TextStyle(color: Colors.purpleAccent, fontSize: 26.0),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Container(
                    height: 180.0,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          )
        ],
      ),
    );
  }
}
