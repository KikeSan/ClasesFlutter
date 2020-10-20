import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';

class NewService with ChangeNotifier {
  List<Article> headlines = [];

  NewService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() {
    print('cargando headlines...');
  }
}
