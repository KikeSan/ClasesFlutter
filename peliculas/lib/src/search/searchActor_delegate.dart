import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actorBuscado_model.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/serie_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearchActor extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'IronMan',
    'Capitan america'
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan america'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar ejm: limpiar, cancelar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izq del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados q vamos a mostrar
    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.blueAccent,
      child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarActor(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ActorBuscado>> snapshot) {
        if (snapshot.hasData) {
          final series = snapshot.data;
          return ListView(
            children: series.map((serie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(serie.getFoto()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(serie.name),
                subtitle: Text('Rate: ' + serie.popularity.toString()),
                onTap: () {
                  //close(context, null);
                  serie.uniqueId = '';
                  Navigator.pushNamed(context, 'detalleFoto', arguments: serie);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    /* final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    ); */
  }
}
