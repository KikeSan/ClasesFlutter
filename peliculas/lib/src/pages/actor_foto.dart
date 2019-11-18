import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';

class ActorFoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;
    print(actor.name);
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
            SizedBox(height: 5.0),
            Text(
              actor.character,
              style: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
