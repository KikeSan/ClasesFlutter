// Generated by https://quicktype.io

class FotosActor {
  List<Fotos> fotos = new List();
  FotosActor.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final foto = Fotos.fromJsonMap(item);
      fotos.add(foto);
    });
  }
}

class Fotos {
  dynamic iso6391;
  int width;
  int height;
  int voteCount;
  double voteAverage;
  String filePath;
  double aspectRatio;

  Fotos({
    this.iso6391,
    this.width,
    this.height,
    this.voteCount,
    this.voteAverage,
    this.filePath,
    this.aspectRatio,
  });

  Fotos.fromJsonMap(Map<String, dynamic> json) {
    iso6391 = json['iso6391'];
    width = json['width'];
    height = json['height'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'] / 1;
    filePath = json['file_path'];
    aspectRatio = json['aspect_ratio'];
  }

  getFoto() {
    if (filePath == null) {
      return 'https://res.cloudinary.com/kikesan/image/upload/v1578437124/peliculasApp/uywisicoxtk8ruovc8qp.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$filePath';
    }
  }
}
