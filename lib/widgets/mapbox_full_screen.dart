import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapFullScreen extends StatefulWidget {
    double latitud = 10.468370;
    double longitud = -73.254821;

    MapFullScreen({Key key, this.latitud, this.longitud});

  @override
  _MapFullScreenState createState() => _MapFullScreenState();
}

class _MapFullScreenState extends State<MapFullScreen> {
  MapboxMapController mapController;
  final center = LatLng(10.468370, -73.254821);

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          child: MapboxMap(
//          accessToken: MapsDemo.ACCESS_TOKEN,
            styleString: "mapbox://styles/josephepia/ckep9yjg04y7q19k2f0giyetj",
            onMapCreated: _onMapCreated,
            initialCameraPosition:
              CameraPosition(
                target: center,
                zoom: 14.0

            ),
          )
      ),
    );
  }
}