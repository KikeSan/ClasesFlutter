import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actorBio_model.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/actuaEn_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class ActorFoto extends StatelessWidget {
  final Pelicula pelicula;

  ActorFoto({this.pelicula});

  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;
    final peliProvider = new PeliculasProvider();
    print('Biography');
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: actor.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: NetworkImage(actor.getFoto()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text(actor.name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 25.0),
            /* FutureBuilder(
              future: peliProvider.getBiography(actor.id.toString()),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return _crearBiografia(context, snapshot.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ), */
            /* Text(
              actor.character,
              style: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
            ), */
            _tambienActuaEn(context, actor)
          ],
        ),
      ),
    );
  }

  Widget _crearBiografia(BuildContext context, List<ActorBiography> actor) {
    print('actor--->$actor.name');
    return Column(
      children: <Widget>[Text(actor.toString())],
    );
  }

  Widget _tambienActuaEn(BuildContext context, Actor actor) {
    final peliProvider = new PeliculasProvider();
    print(actor.id);
    return FutureBuilder(
      future: peliProvider.getOtrasPelis(actor.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearPeliculasPageView(context, snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearPeliculasPageView(BuildContext context, List<ActuaEn> actuaEn) {
    //print('crear pelicula');
    //print(actuaEn);
    return SizedBox(
      height: 150.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.23, initialPage: 1),
        itemCount: actuaEn.length,
        itemBuilder: (context, i) => _peliTarjeta(context, actuaEn[i]),
      ),
    );
  }

  Widget _peliTarjeta(BuildContext context, ActuaEn actuaEn) {
    actuaEn.uniqueId = '${actuaEn.id}-poster';
    final tarjeta = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: actuaEn.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: FadeInImage(
                image: NetworkImage(actuaEn.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            actuaEn.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.0),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: actuaEn);
      },
    );
  }
}
