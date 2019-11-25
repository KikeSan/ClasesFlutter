import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 80.0, right: 80.0, left: 80.0),
            //margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
            ),
            child: Table(
              children: [
                TableRow(children: [
                  _crearBotonRedondeado(context, Colors.blue, Icons.border_all,
                      'Básico', 'basico'),
                ]),
                TableRow(children: [
                  _crearBotonRedondeado(context, Colors.pinkAccent, Icons.shop,
                      'Scroll', 'scroll'),
                ]),
                TableRow(children: [
                  _crearBotonRedondeado(context, Colors.green,
                      Icons.movie_filter, 'Botones', 'botones'),
                ]),
              ],
            )));
  }

  Widget _crearBotonRedondeado(BuildContext context, Color color,
      IconData icono, String texto, String ruta) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 180.0,
        width: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(16.0)),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, ruta),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(icono, color: Colors.white, size: 28.0),
              ),
              Text(
                texto,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5.0)
            ],
          ),
        ),
      ),
    );
  }
}
