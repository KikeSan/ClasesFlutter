import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actorBio_model.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/actuaEn_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '7ee4ac5a82ffbe62669798a4c5e6ff46';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();
  //Con el .broadcast muchos puedes escuchar esste stram
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesaRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _languaje,
    });

    return await _procesaRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _languaje,
      'page': _popularesPage.toString()
    });

    final resp = await _procesaRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  Future<List<ActorBiography>> getBiography(String actorId) async {
    print('Actor id: $actorId');
    final url = Uri.https(_url, '3/person/$actorId', {
      'api_key': _apikey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    print('Datos recolectados: $decodedData');
    final actorBio = new ActorBio.fromJsonList(decodedData);
    return actorBio.actorDetalle;
  }

  Future<List<ActuaEn>> getOtrasPelis(String actorId) async {
    final url = Uri.https(_url, '3/person/$actorId/movie_credits', {
      'api_key': _apikey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final actuaEnPeli = new ActuaEnPeli.fromJsonList(decodedData['cast']);
    return actuaEnPeli.actuaEn;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _languaje, 'query': query});

    return await _procesaRespuesta(url);
  }
}
