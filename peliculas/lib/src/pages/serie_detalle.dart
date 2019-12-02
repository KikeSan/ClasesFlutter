import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/serie_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class SerieDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Serie serie = ModalRoute.of(context).settings.arguments;
    print('peliculaDetalle');
    print(serie.name);
    return Scaffold(
        body: Stack(
      children: [
        _fondoApp(),
        CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(serie),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.0),
                _posterTitulo(context, serie),
                _descripcion(serie),
                _crearCasting(context, serie)
              ]),
            )
          ],
        )
      ],
    ));
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
              Color.fromRGBO(90, 120, 160, 0.2),
              Color.fromRGBO(49, 175, 255, 0.5),
            ])),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: 80.0,
          right: -135.0,
          child: cajaRosa,
        ),
      ],
    );
  }

  Widget _crearAppBar(Serie pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.transparent,
      expandedHeight: 240.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(''
            /* pelicula.title,
          style: TextStyle(color: Colors.purple[300], fontSize: 16.0), */
            ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          //fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Serie pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.name,
                  style: TextStyle(color: Colors.blue[50], fontSize: 20.0),
                  //overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalName,
                  style: TextStyle(color: Colors.blue[300], fontSize: 16.0),
                  //overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star_border,
                      size: 18.0,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(pelicula.voteAverage.toString(),
                        style:
                            TextStyle(color: Colors.blue[200], fontSize: 16.0)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.movie_filter,
                      size: 18.0,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(pelicula.firstAirDate,
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.blue[200])),
                  ],
                ),
                /* SizedBox(height: 5.0),
                Text(pelicula.releaseDate,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14.0)) */
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Serie pelicula) {
    return Container(
      padding:
          EdgeInsets.only(top: 10.0, right: 20.0, bottom: 40.0, left: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.blue[50]),
      ),
    );
  }

  Widget _crearCasting(BuildContext context, Serie pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCastSeries(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(context, snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(BuildContext context, List<Actor> actores) {
    return SizedBox(
      height: 250.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(context, actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(BuildContext context, Actor actor) {
    final tarjeta = Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: actor.name,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                image: NetworkImage(actor.getFoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            actor.name,
            //overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.0, color: Colors.blue[50]),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            actor.character,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue[100], fontSize: 12.0),
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalleFoto', arguments: actor);
      },
    );
    /* return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            actor.name,
            //overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.0),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            actor.character,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
          )
        ],
      ),
    ); */
  }
}
