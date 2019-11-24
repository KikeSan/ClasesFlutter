import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/fotosActor_model.dart';

class FotosSwiper extends StatelessWidget {
  final List<Fotos> fotos;

  FotosSwiper({@required this.fotos});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final tarjeta = Container(
      //padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.9, //60% del ancho
        itemHeight: _screenSize.height * 0.69,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle',
                    arguments: fotos[index]),
                child: FadeInImage(
                  image: NetworkImage(fotos[index].getFoto()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ));
        },
        itemCount: fotos.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );

    return GestureDetector(
      child: tarjeta,
      /* onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: fotos);
      }, */
    );
  }
}
