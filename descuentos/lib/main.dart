import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          _fondoApp(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_header(), _calculador()],
            ),
          )
        ],
      )),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.1),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(181, 221, 164, 1.0),
            Color.fromRGBO(77, 170, 87, 1.0),
          ])),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        height: 800.0,
        width: 800.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(400.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(249, 236, 204, 0.1),
              Color.fromRGBO(199, 186, 154, 0.6),
            ])),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -580.0,
          left: -250.0,
          child: cajaRosa,
        ),
      ],
    );
  }

  Widget _header() {
    return Text('Calculador de Descuentos');
  }

  Widget _calculador() {
    return Column(
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Monto',
            labelText: 'Ingrese Monto',
          ),
          onChanged: _calcular,
        ),
        Table(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TableRow(children: [
              _crearBoton('60%'),
              _crearBoton('50%'),
              _crearBoton('40%'),
            ]),
            TableRow(children: [
              _crearBoton('30%'),
              _crearBoton('20%'),
              _crearBoton('10%'),
            ])
          ],
        ),
      ],
    );
  }

  Widget _crearBoton(String texto) {
    return ClipRect(
      child: Container(
        height: 70.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(117, 70, 104, 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            Text(
              texto,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }

  _calcular(String valor) {}
}
