import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Image(
          image: NetworkImage(
              'https://images.pexels.com/photos/247478/pexels-photo-247478.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                //expande el contenido hacia sus extremos
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Montañas empinadas', style: estiloTitulo),
                    SizedBox(height: 5.0),
                    Text('Un día normal en el ocaso', style: estiloSubtitulo),
                  ],
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.red,
                size: 30.0,
              ),
              Text('41', style: TextStyle(fontSize: 20.0))
            ],
          ),
        )
      ],
    ));
  }
}
