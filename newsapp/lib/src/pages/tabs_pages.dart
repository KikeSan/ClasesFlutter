import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //context es un objeto que contiene toda la informacion del widget
    //creamos una instancia del widget principal para acceder a las notificaciones
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (i) => navegacionModel.paginaActual = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('Para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('Encabezados')),
        ]);
  }
}

// API key: edac150847ce4a839f2fa74f76ab1892
// endpoint: https://newsapi.org/v2/top-headlines?country=us&apiKey=edac150847ce4a839f2fa74f76ab1892

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(), //Esto es para no mostrar una curva al borde cuando ya no hay más tabs
      physics:
          NeverScrollableScrollPhysics(), //Esto es para no navegar entre tabs como slide
      children: <Widget>[
        Tab1Page(),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}

//creamos una clase para notificar a los widgets de un cambio en los tabs

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
