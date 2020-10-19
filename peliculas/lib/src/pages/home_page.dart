import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/searchActor_delegate.dart';
import 'package:peliculas/src/search/searchTv_delegate.dart';
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
          'Búsquedas',
          style: TextStyle(
              fontSize: 24.0,
              //fontWeight: FontWeight.bold,
              color: Colors.blue[50]),
        ),
        SizedBox(width: 40.0),
        IconButton(
          icon: Icon(Icons.person),
          color: Colors.blue[100],
          iconSize: 35.0,
          onPressed: () {
            showSearch(context: context, delegate: DataSearchActor());
          },
        ),
        IconButton(
          icon: Icon(Icons.live_tv),
          color: Colors.blue[100],
          iconSize: 32.0,
          onPressed: () {
            showSearch(context: context, delegate: DataSearchTV());
          },
        ),
        IconButton(
          icon: Icon(Icons.movie_filter),
          color: Colors.blue[100],
          iconSize: 35.0,
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
          top: -85.0,
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
              style: TextStyle(color: Colors.blue[200], fontSize: 26.0),
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
