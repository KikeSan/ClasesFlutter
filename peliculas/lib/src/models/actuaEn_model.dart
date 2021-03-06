import 'package:peliculas/src/models/pelicula_model.dart';

class ActuaEnPeli {
  List<ActuaEn> actuaEn = new List();
  ActuaEnPeli.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = ActuaEn.fromJsonMap(item);
      actuaEn.add(actor);
    });
  }
}

class ActuaEn extends Pelicula {
  String uniqueId; //creado para evitar conflicto en hero
  String character;
  String creditId;
  String posterPath;
  int id;
  bool video;
  int voteCount;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  double popularity;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;
  String department;
  String job;

  ActuaEn({
    this.character,
    this.creditId,
    this.posterPath,
    this.id,
    this.video,
    this.voteCount,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.department,
    this.job,
  });

  ActuaEn.fromJsonMap(Map<String, dynamic> json) {
    character = json['character'];
    creditId = json['credit_id'];
    posterPath = json['poster_path'];
    id = json['id'];
    video = json['video'];
    voteCount = json['vote_count'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    popularity = json['popularity'] / 1;
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
    department = json['department'];
    job = json['job'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://res.cloudinary.com/kikesan/image/upload/v1578437124/peliculasApp/uywisicoxtk8ruovc8qp.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }
}
