import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapCreatePedido extends StatefulWidget {


  MapCreatePedido(
      {Key key});

  @override
  _MapCreatePedidoState createState() => _MapCreatePedidoState();
}

class _MapCreatePedidoState extends State<MapCreatePedido> {
  MapboxMapController mapController;

  LatLng center;

  @override
  void initState() {
//    center = widget.userLocation;
  }

  _mapaCargado() async{


    await agregarMarcadores();


  }

  agregarMarcadores() async{
    await mapController.clearSymbols();

    var markerOrigen =  SymbolOptions(
        draggable: false,
        geometry: center,
        iconImage: 'car-15',
        textField: "estoy aqui",
        iconSize: 2.5,
        textColor: "#092E87",
        textOffset: Offset(0, 1.5)
//      iconColor: "#092E87"
    );

    await mapController.addSymbol(markerOrigen);
    if(userBloc.nuevoPedido.origen != null){
      await mapController.addSymbol(SymbolOptions(
          draggable: false,
          geometry: LatLng(userBloc.nuevoPedido.origenLat, userBloc.nuevoPedido.origenLong),
          iconImage: 'car-15',
          textField: "origen",
          iconSize: 2.5
//      iconColor: "#092E87"
      ));
    }

    if(userBloc.nuevoPedido.destino != null){
      await mapController.addSymbol(SymbolOptions(
          draggable: false,
          geometry: LatLng(userBloc.nuevoPedido.destinoLat, userBloc.nuevoPedido.destinoLong),
          iconImage: 'car-15',
          textField: "destino",
          iconSize: 2.5,
          textColor: "#092E87",
          textOffset: Offset(0, 1.5)

//      iconColor: "#092E87"
      ));
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;


//    mapController.addSymbol(SymbolOptions(
//        draggable: false,
//        geometry: widget.destinoLocation,
//        iconImage: 'car-15',
//        iconSize: 2.5
////      iconColor: "#092E87"
//    ));
  }

  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Container(
          child: StreamBuilder(
        stream: userBloc.geoStream,
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              center = LatLng(snapshot.data.latitude, snapshot.data.longitude);

              return MapboxMap(
//          accessToken: MapsDemo.ACCESS_TOKEN,
                styleString:
                "mapbox://styles/josephepia/ckep9yjg04y7q19k2f0giyetj",
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _mapaCargado,
                trackCameraPosition: true,
                initialCameraPosition: CameraPosition(
                    target:
                    center,
                    zoom: 14.0),
              );
            case ConnectionState.active:
              print("activate snap mapa create service");
              print("-----------------------------------");
              print("latitud ${snapshot.data.latitude} longitud ${snapshot.data.longitude}");
              center = LatLng(snapshot.data.latitude, snapshot.data.longitude);
              return MapboxMap(
//          accessToken: MapsDemo.ACCESS_TOKEN,
                styleString:
                    "mapbox://styles/josephepia/ckep9yjg04y7q19k2f0giyetj",
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _mapaCargado,
                trackCameraPosition: true,
                initialCameraPosition: CameraPosition(
                    target:
                        center,
                    zoom: 14.0),
              );
            default:
              return null;
          }
        },
      )),
    );
  }


}
