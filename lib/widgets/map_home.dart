import 'dart:typed_data';

import 'package:do_my/Usuario/model/location_service.dart';
import 'package:do_my/Usuario/model/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapHome extends StatefulWidget {
   String origen;
   String destino;
   LatLng origenLocation;
   LatLng destinoLocation;
   LatLng userLocation;

  MapHome(
      {Key key,
      this.origen,
      this.destino,
      this.origenLocation,
      this.destinoLocation,
      this.userLocation});

  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  MapboxMapController mapController;

  LatLng center = LatLng(0.0, 0.0);

  @override
  void initState() {
    center = widget.userLocation;
  }

  addMyLocationSymbol()async{
    await _onStyleLoaded();

    await mapController.addSymbol(SymbolOptions(
        draggable: false,
        geometry: userLoc,
        iconImage: 'markerdomytwo',
        iconSize: 1.0,
        textColor: "#092E87",
        textField: "Estoy aqui",
        textOffset: Offset(0, 1.5)
//      iconColor: "#092E87"
    ));
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;

  }

  void _onStyleLoaded() {
    addImageFromAsset("domymarker", "images/domylocation.png");
    addImageFromAsset("markerdomyone", "images/markerdomyone.png");
    addImageFromAsset("markerdomytwo", "images/markerdomytwo.png");
    addImageFromAsset("markerdomythree", "images/markerdomythree.png");
//    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  @override
  void dispose() {
//    mapController?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  LocationService locationService;

   LatLng userLoc;

  @override
  Widget build(BuildContext context) {
    locationService = LocationService();
    return Scaffold(
      body: StreamBuilder(
          stream: locationService.locationStream,
          builder:
              (BuildContext context, AsyncSnapshot<UserLocation> snapshop) {
            switch (snapshop.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
//          print("datos de snap done=> ${snapshop.data.snapshot.value.toString()}");
              userLoc = LatLng(snapshop.data.latitude, snapshop.data.longitude);
              print("snapshot donde ->>>>>>>>>>>>>>>>>>>>>>>>>");
                return Container(
                    child: MapboxMap(
//          accessToken: MapsDemo.ACCESS_TOKEN,
                  styleString:
                      "mapbox://styles/josephepia/ckep9yjg04y7q19k2f0giyetj",
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: widget.userLocation, zoom: 14.0),
                ));

              case ConnectionState.active:
//          print("datos de snap  active=> ${snapshop.data.snapshot.value.toString()}");
                userLoc = LatLng(snapshop.data.latitude, snapshop.data.longitude);
                print("snapshot active ->>>>>>>>>>>>>>>>>>>>>>>>>");

                return Container(
                    child: MapboxMap(
//          accessToken: MapsDemo.ACCESS_TOKEN,
                  styleString:
                      "mapbox://styles/josephepia/ckep9yjg04y7q19k2f0giyetj",
                  onMapCreated: _onMapCreated,
                  onStyleLoadedCallback: addMyLocationSymbol,
                  initialCameraPosition:
                      CameraPosition(target: userLoc, zoom: 14.0),
                ));

              //                  Column(
              //                  children: [
              //
              //
              //
              ////                    Contenido(blocPedidos.buildServicios(snapshop.data.snapshot)),
              //                  ],
              //                );

              default:
                return null;
            }
          }),
    );
  }
}
