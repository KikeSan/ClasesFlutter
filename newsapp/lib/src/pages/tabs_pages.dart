import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      physics:
          BouncingScrollPhysics(), //Esto es para no mostrar una curva al borde cuando ya no hay más tabs
      children: <Widget>[
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        )
      ],
    ));
  }
}
