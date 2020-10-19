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
  double primerDescuento = 0;
  String stringDescuentoUno = '';
  String stringDescuentoDos = '';
  String titleDescuentos = '';

  final montoPrincipal = TextEditingController();
  final dsctoEspecial = TextEditingController();
  final dsctoAdicional = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(41, 138, 205, 1.0),
          hintColor: Color.fromRGBO(41, 138, 205,
              1.0)), //38, 132, 178 Color.fromRGBO(225, 99, 53, 1.0)),
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20.0, top: 80.0, right: 20.0),
              //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[_header(), _calculador()],
              ),
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
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(65, 68, 75, 1.0),
            Color.fromRGBO(36, 36, 47, 1.0), //43, 46, 53, 1.0
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
              Color.fromRGBO(108, 106, 127, 0.3),
              Color.fromRGBO(108, 106, 127, 1.0), //199, 186, 154, 0.6
            ])),
      ),
    );

    final cajaGris = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        height: 800.0,
        width: 800.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(400.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(108, 106, 127, 0.05),
              Color.fromRGBO(108, 106, 127, 0.2), //199, 186, 154, 0.6
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
        Positioned(
          top: 620.0,
          left: -100.0,
          child: cajaGris,
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
          padding:
              EdgeInsets.only(left: 10.0, top: 50.0, right: 10.0, bottom: 40.0),
          child: Row(
            children: <Widget>[
              Flexible(
                  child: new TextField(
                controller: montoPrincipal,
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
              )),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                height: 64.0,
                width: 98.0,
                child: FlatButton(
                    color: Color.fromRGBO(255, 44, 93, 0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(7.0),
                        side: BorderSide(
                          color: Color.fromRGBO(191, 6, 40,
                              1.0), //Color.fromRGBO(255, 185, 13, 1.0)
                        )),
                    padding: EdgeInsets.all(14.0),
                    splashColor: Color.fromRGBO(43, 46, 53, 1.0),
                    onPressed: _limpiarCampos,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 32.0,
                        )
                      ],
                    )),
              )
            ],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Adicional',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            _crearBotonAdicional(5),
            _crearBotonAdicional(10),
            _crearBotonAdicional(15),
          ],
        ),
        SizedBox(height: 30.0),
        Container(
          width: 330.0,
          height: 90.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          margin: EdgeInsets.only(bottom: 30.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(61, 99, 70, 0.7), //80, 80, 80, 1.0
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(30, 30, 30, 1.0),
                    blurRadius: 9.0,
                    spreadRadius: 3.0,
                    offset: Offset(3, 5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(titleDescuentos,
                      style: TextStyle(
                        color: Color.fromRGBO(160, 242, 119, 1.0),
                      )),
                  SizedBox(height: 5.0),
                  Text(
                    stringDescuentoUno + stringDescuentoDos,
                    style: TextStyle(
                        color: Color.fromRGBO(160, 242, 119, 1.0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                total.toStringAsFixed(2),
                textAlign: TextAlign.right,
                style: TextStyle(
                    color:
                        Color.fromRGBO(160, 242, 119, 1.0), //255, 185, 13, 1.0
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
        child: FlatButton(
          color: Color.fromRGBO(38, 132, 178, 0.5),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
              side: BorderSide(color: Color.fromRGBO(68, 223, 244, 1.0))),
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

  Widget _crearBotonAdicional(double texto) {
    return ClipRect(
      child: Container(
        width: 64.0,
        height: 48.0,
        margin: EdgeInsets.all(10.0),
        child: FlatButton(
          color: Color.fromRGBO(129, 65, 235, 0.4),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
              side: BorderSide(color: Color.fromRGBO(153, 114, 255, 1.0))),
          textColor: Colors.white,
          disabledColor: Colors.red,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Color.fromRGBO(43, 46, 53, 1.0),
          onPressed: () => _calcularAdicional(texto),
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
        controller: dsctoEspecial,
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
    setState(() {
      stringDescuentoUno = '';
      stringDescuentoDos = '';
    });
  }

  _calcular(double percent) {
    print('Porcentaje: ' + percent.toString());
    primerDescuento = percent;
    stringDescuentoUno = percent.toStringAsFixed(0) + '%';
    titleDescuentos = 'Dsctos aplicados:';
    stringDescuentoDos = '';
    setState(() {
      total = valorInput - (valorInput * (percent / 100));
    });
  }

  _calcularAdicional(double valor) {
    stringDescuentoDos = ' + ' + valor.toStringAsFixed(0) + '%';
    final temp = valorInput - (valorInput * (primerDescuento / 100));
    setState(() {
      total = temp - (temp * (valor / 100));
    });
  }

  _limpiarCampos() {
    setState(() {
      total = 0;
      valorInput = 0;
      primerDescuento = 0;
      stringDescuentoUno = '';
      stringDescuentoDos = '';
      montoPrincipal.text = '';
      dsctoEspecial.text = '';
      titleDescuentos = '';
    });
  }
}
