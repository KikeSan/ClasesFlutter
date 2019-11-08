import 'package:contador/src/pages/contador_page.dart';
import 'package:flutter/material.dart';
import 'package:contador/src/pages/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //quita el banner de debug
      home: Center(
        //child: HomePage()
        child: ContadorPage(),
      ),
    );
  }
}
