import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _crearImagen(),
          _crearTitulo(),
          _crearAcciones(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
        ],
      ),
    ));
  }

  Widget _crearImagen() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage(
            'https://images.pexels.com/photos/247478/pexels-photo-247478.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
        height: 250.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      // prevee el espacio a la izquierda de algunos dispositivos que tienen notch
      child: Container(
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
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(Icons.call, 'CALL'),
        _accion(Icons.near_me, 'ROUTE'),
        _accion(Icons.share, 'SHARE'),
      ],
    );
  }

  Widget _accion(IconData icon, String texto) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
          size: 40.0,
        ),
        SizedBox(height: 5.0),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }

  Widget _crearTexto() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
          'Est adipisicing irure ex nulla sit mollit. Mollit ex ullamco nisi tempor ex eu. Commodo esse deserunt fugiat non minim dolor pariatur. Exercitation id aliquip nisi nisi ipsum. Est adipisicing irure ex nulla sit mollit. Mollit ex ullamco nisi tempor ex eu. Commodo esse deserunt fugiat non minim dolor pariatur. Exercitation id aliquip nisi nisi ipsum.',
          textAlign: TextAlign.justify),
    );
  }
}
