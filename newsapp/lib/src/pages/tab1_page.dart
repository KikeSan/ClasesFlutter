import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);

    return Scaffold(
      body: Center(
        child: Text('Hola mundo'),
      ),
    );
  }
}
