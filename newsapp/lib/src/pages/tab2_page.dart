import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[Expanded(child: _ListaCategorias())],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewService>(context).categories;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final cName = categories[index].name;
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _CategoryButton(categories[index]),
              SizedBox(height: 5),
              //Para poner la primera letra en mayus
              Text('${cName[0].toUpperCase()}${cName.substring(1)}')
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    //aquí no se pone listen:false porque si se va a redibujar
    final newService = Provider.of<NewService>(context);

    return GestureDetector(
      onTap: () {
        //print('Hola ${categoria.name}');
        // Cuando el Provider se usa en un Tap o un evento se pone listen:false sino bota error porque va a tratar de redibujarlo
        final newService = Provider.of<NewService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (newService.selectedCategory == this.categoria.name)
                ? miTema.accentColor
                : Colors.white),
        child: Icon(
          categoria.icon,
          color: (newService.selectedCategory == this.categoria.name)
              ? Colors.white
              : Colors.black54,
        ),
      ),
    );
  }
}
