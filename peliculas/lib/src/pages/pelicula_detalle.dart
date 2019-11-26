import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    print('peliculaDetalle');
    print(pelicula.title);
    return Scaffold(
        body: Stack(
      children: [
        _fondoApp(),
        CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.0),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _crearCasting(context, pelicula)
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
              Color.fromRGBO(236, 98, 188, 0.1),
              Color.fromRGBO(241, 142, 172, 0.15),
            ])),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: 80.0,
          right: -130.0,
          child: cajaRosa,
        ),
      ],
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
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

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
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
                  pelicula.title,
                  style: TextStyle(color: Colors.purple[100], fontSize: 20.0),
                  //overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: TextStyle(color: Colors.purple[300], fontSize: 16.0),
                  //overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star_border,
                      size: 18.0,
                      color: Colors.lime,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(pelicula.voteAverage.toString(),
                        style: TextStyle(
                            color: Colors.purple[200], fontSize: 16.0)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.movie_filter,
                      size: 18.0,
                      color: Colors.lime,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(pelicula.releaseDate,
                        style: TextStyle(
                            fontSize: 14.0, color: Colors.purple[200])),
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

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding:
          EdgeInsets.only(top: 10.0, right: 20.0, bottom: 40.0, left: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.purple[100]),
      ),
    );
  }

  Widget _crearCasting(BuildContext context, Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
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
            style: TextStyle(fontSize: 13.0, color: Colors.purple[100]),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            actor.character,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.purple[800], fontSize: 12.0),
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
