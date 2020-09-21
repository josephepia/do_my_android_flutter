import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapCreatePedido extends StatefulWidget {

  final String origen;
  final String destino;
  final LatLng origenLocation;
  final LatLng destinoLocation;
  final LatLng userLocation;


  MapCreatePedido({Key key,this.origen, this.destino, this.origenLocation, this.destinoLocation, this.userLocation});

  @override
  _MapCreatePedidoState createState() => _MapCreatePedidoState();
}

class _MapCreatePedidoState extends State<MapCreatePedido> {


  MapboxMapController mapController;

  LatLng center= LatLng(0.0,0.0);


  @override
  void initState() {
    center = widget.userLocation;
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;

    mapController.addSymbol(SymbolOptions(
      draggable: false,
      geometry: widget.origenLocation,
      iconImage: 'car-15',
      iconSize: 2.5
//      iconColor: "#092E87"
    ));
    mapController.addSymbol(SymbolOptions(
        draggable: false,
        geometry: widget.destinoLocation,
        iconImage: 'car-15',
        iconSize: 2.5
//      iconColor: "#092E87"
    ));




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
                target: widget.userLocation,
                zoom: 14.0

            ),
          )
      ),
    );
  }
}
