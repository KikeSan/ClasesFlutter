import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              child: Icon(Icons.map),
              onPressed: () {
                selectedStyle == darkStyle
                    ? selectedStyle = streetStyle
                    : selectedStyle = darkStyle;

                setState(() {});
              })
        ],
      ),
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
