import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:disenos/src/pages/home_page.dart';
import 'package:disenos/src/pages/botones_page.dart';
import 'package:disenos/src/pages/basico_page.dart';
import 'package:disenos/src/pages/scroll_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Este codigo comentado sirve para poner el texto blanco del status bar del iphone, donde sale el indicador de bateria arriba
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'basico': (BuildContext context) => BasicoPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'botones': (BuildContext context) => BotonesPage(),
      },
    );
  }
}
