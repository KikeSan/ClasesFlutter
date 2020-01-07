import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double valorInput = 0;

  double total = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          primaryColor: Colors.blueGrey,
          hintColor: Color.fromRGBO(
              255, 185, 13, 1.0)), //Color.fromRGBO(225, 99, 53, 1.0)),
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          _fondoApp(),
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 70.0, right: 20.0),
            //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
            Color.fromRGBO(65, 68, 75, 1.0),
            Color.fromRGBO(43, 46, 53, 1.0),
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
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: new BorderRadius.circular(25.0),
          child: Image(
            image: AssetImage('assets/ic_launcher.png'),
            height: 70.0,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          'Descuentos',
          style: TextStyle(
              color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _calculador() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(7.0),
                  ),
                ),
                hintText: 'Ingrese monto',
                //labelText: 'Ingrese Monto',
                filled: true,
                //border: InputBorder.none,
                prefixIcon: Icon(Icons.attach_money),
                fillColor: Color.fromRGBO(255, 255, 255, 1.0)),
            onChanged: (valor) => _actualizaValor(double.parse(valor)),
          ),
        ),
        Table(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TableRow(children: [
              _crearBoton(60),
              _crearBoton(50),
              _crearBoton(40),
            ]),
            /* TableRow(children: [
              _crearBoton(30),
              _crearBoton(20),
              _crearBoton(10),
            ]) */
          ],
        ),
        Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              _crearBoton(30),
              _crearBoton(20),
              _crearInputEspecial(),
            ]),
        SizedBox(height: 30.0),
        Container(
          width: 330.0,
          height: 90.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(80, 80, 80, 1.0),
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(30, 30, 30, 1.0),
                    blurRadius: 9.0,
                    spreadRadius: 3.0,
                    offset: Offset(3, 5))
              ]),
          child: Text(
            total.toStringAsFixed(2),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(255, 185, 13, 1.0),
                fontSize: 44.0,
                fontWeight: FontWeight.bold),
          ),
          /* child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 30.0),
            readOnly: true,
            decoration: InputDecoration(
                //hintText: '%',
                labelText: total.toStringAsFixed(2),
                filled: true,
                border: InputBorder.none,
                prefixIcon: Icon(Icons.trending_down),
                fillColor: Color.fromRGBO(255, 255, 255, 1.0)),
            //onChanged: _calcular,
          ), */
        ),
      ],
    );
  }

  Widget _crearBoton(double texto) {
    return ClipRect(
      child: Container(
        height: 70.0,
        width: 98.0,
        margin: EdgeInsets.all(10.0),
        /* child: RaisedButton.icon(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.deepPurple[400],
          textColor: Colors.white,
          icon: Icon(Icons.chevron_right),
          label: Text(texto.toStringAsFixed(0)),
          onPressed: () => _calcular(texto),
        ), */
        child: FlatButton(
          color: Color.fromRGBO(83, 85, 91, 1.0),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
              side: BorderSide(color: Color.fromRGBO(255, 185, 13, 1.0))),
          textColor: Colors.white,
          disabledColor: Colors.red,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Color.fromRGBO(43, 46, 53, 1.0),
          onPressed: () => _calcular(texto),
          child: Text(texto.toStringAsFixed(0) + '%',
              style: TextStyle(fontSize: 20.0)),
        ),
      ),
    );
  }

  Widget _crearInputEspecial() {
    return Container(
      width: 96.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 26.0),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.0),
              ),
            ),
            hintText: '__%',
            //labelText: 'Dscto',
            filled: true,
            //border: InputBorder.none,
            //prefixIcon: Icon(Icons.attach_money),
            fillColor: Color.fromRGBO(255, 255, 255, 1.0)),
        onChanged: (valor) => _calcular(double.parse(valor)),
      ),
    );
  }

  _actualizaValor(double valor) {
    print('Valor: ' + valor.toString());
    valorInput = valor;
  }

  _calcular(double percent) {
    print('Porcentaje: ' + percent.toString());
    setState(() {
      total = valorInput - (valorInput * (percent / 100));
    });
  }
}
