import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Paginas(),
      bottomNavigationBar: _Navegacion(),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(currentIndex: 0, items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), title: Text('Para ti')),
      BottomNavigationBarItem(
          icon: Icon(Icons.public), title: Text('Encabezados')),
    ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      //physics: BouncingScrollPhysics(), //Esto es para no mostrar una curva al borde cuando ya no hay más tabs
      physics:
          NeverScrollableScrollPhysics(), //Esto es para no navegar entre tabs como slide
      children: <Widget>[
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}
