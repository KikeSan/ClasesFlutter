import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final center = LatLng(-12.075128, -77.053708);
  final streetStyle = 'mapbox://styles/kikesan/ckgtbuwr72k0f19lk9p05izt7';
  final darkStyle = 'mapbox://styles/kikesan/ckgtbsfpt2jvq19mex71n2u9j';
  String selectedStyle = 'mapbox://styles/kikesan/ckgtbsfpt2jvq19mex71n2u9j';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //Simbolos
        FloatingActionButton(
            child: Icon(Icons.pin_drop),
            onPressed: () {
              //mapController.animateCamera(CameraUpdate.tiltTo(60));
              mapController.addSymbol(
                SymbolOptions(
                    geometry: center,
                    textField: 'Montaña creada aqui',
                    //textColor: '#0000ff'
                    iconImage: 'assetImage',
                    //iconImage: 'bicycle-15',
                    //iconSize: 3,
                    textOffset: Offset(0, 2)),
              );
            }),
        SizedBox(
          height: 5,
        ),
        FloatingActionButton(
            child: Icon(Icons.zoom_in),
            onPressed: () {
              //mapController.animateCamera(CameraUpdate.tiltTo(60));
              mapController.animateCamera(CameraUpdate.zoomIn());
            }),
        SizedBox(
          height: 5,
        ),
        FloatingActionButton(
            child: Icon(Icons.zoom_out),
            onPressed: () {
              //mapController.animateCamera(CameraUpdate.tiltTo(60));
              mapController.animateCamera(CameraUpdate.zoomOut());
            }),
        SizedBox(
          height: 5,
        ),
        //cambiar estilo
        FloatingActionButton(
            child: Icon(Icons.map),
            onPressed: () {
              selectedStyle == darkStyle
                  ? selectedStyle = streetStyle
                  : selectedStyle = darkStyle;

              _onStyleLoaded();
              setState(() {});
            })
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: center, zoom: 14),
    );
  }
}
