import 'package:do_my/Pedido/bloc/bloc_pedido.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/widgets/formulario_pedido_screen.dart';
import 'package:do_my/widgets/logo_mini_one.widget.dart';
import 'package:do_my/widgets/mapbox_full_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:location/location.dart';
class Home extends StatelessWidget {

  PedidoBloc blocPedidos;
  @override
  Widget build(BuildContext context) {
    Future<LocationData> ubicacion = getLocation();
    blocPedidos = BlocProvider.of(context);

    Widget fondo =  Container(

      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/fondoHomeDomy.png",

            )
        ),
      ),
    );




    return Stack(
      alignment: Alignment.topCenter,
      children: [
        MapFullScreen(),
        LogoMiniOne(),
        StreamBuilder(
            stream: blocPedidos.serviciosStream,
            builder: (BuildContext context, AsyncSnapshot snapshop){
              switch(snapshop.connectionState){
                case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                print("datos de snap done=> ${snapshop.data.snapshot.value.toString()}");

                return Contenido();

                case ConnectionState.active:
                print("datos de snap  active=> ${snapshop.data.snapshot.value.toString()}");
                return Contenido();

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
          },
        )
      ],
    );
  }
}



Future<LocationData>  getLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();
}

class Contenido extends StatelessWidget {
  List<Servicio> listServicios;
  Contenido();

  UserBloc userBloc;
  PedidoBloc pedidoBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = UserBloc();
    pedidoBloc = PedidoBloc();
    return

//       StreamBuilder(
//        stream: userBloc.serviciosStream,
//        builder: (BuildContext context, AsyncSnapshot snapshop){
//          switch(snapshop.connectionState){
//            case ConnectionState.waiting:
//            return Center(child: CircularProgressIndicator());
//            case ConnectionState.none:
//            return Center(child: CircularProgressIndicator());
//            case ConnectionState.done:
//            print("datos de snap done=> ${snapshop.data.snapshot.value.toString()}");
//
//            firedart.DataSnapshot dataSna = snapshop.data.snapshot;
//            return Contenido(blocPedidos.buildServicios(snapshop.data.snapshot));
//
//            case ConnectionState.active:
//            print("datos de snap  active=> ${snapshop.data.snapshot.value.toString()}");
//            return Contenido(blocPedidos.buildServicios(snapshop.data.snapshot));
//
//            default:
//            return null;
//          }
//        },
//      ),


        DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.2,
          maxChildSize: 0.6,
          builder: (context,scrollController){
            return ListView(
              padding: EdgeInsets.all(16),
              controller: scrollController,
              children: [
                pedidoBloc.sortListServicios(scrollController)
//              Container(
//                height: double.infinity,
//                child: pedidoBloc.sortListServicios(),
//              )

//                Column(
//                  children: this.listServicios
////                  [
////                    Servicio(imagen: "images/taxi.png", titulo: "Taxi",descripcion: "Servicio de transporte",),
////                    Servicio(imagen: "images/mensajeria.png", titulo: "Mensajería",descripcion: "Llevamos tus paquetes al lugar de destino",),
////                    Servicio(imagen: "images/compras.png", titulo: "Compras",descripcion: "Dinos que comprar y lo llevamos a la puerta de tu casa",),
////                    Servicio(imagen: "images/servicios.png", titulo: "Servicios públicos",descripcion: "¿tienes recibos pendientes?. Descuida, los pagamos por ti",),
////                    Servicio(imagen: "images/especial.png", titulo: "Especial",descripcion: "¿Deseas un servicio personalizado?. Cuenta con nosotros",),
////
////                  ],
//                ),
              ],
            );



          },
        );

  }
}


class Servicio extends StatelessWidget {

  String imagen;
  String titulo;
  String descripcion;


  Servicio({this.imagen,this.titulo,this.descripcion});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      margin: EdgeInsets.only(bottom: 13.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.0,
                color: Colors.black38,
                offset: Offset(0.0, 0.7)

            )
          ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormularioPedido(this.titulo)),
            );
          },
          child: Container(

            child: Row(

              children: [
                Container(
                  width: 50.0,
                  height: 50.0,

                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(this.imagen),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        this.titulo,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"
                        ),
                      ),
                      Text(
                            this.descripcion,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Poppins",

                            ),

                          ),



                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



