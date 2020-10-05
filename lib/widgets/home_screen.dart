import 'package:do_my/Pedido/bloc/bloc_pedido.dart';
import 'package:do_my/Pedido/model/pedido.dart';
import 'package:do_my/Pedido/model/servicio.dart';
import 'package:do_my/Pedido/ui/screens/create_new_pedido_screen.dart';
import 'package:do_my/Pedido/ui/widgets/card_servicio_widget.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/ui/widgets/map_create_pedido_widget.dart';
import 'package:do_my/widgets/formulario_pedido_screen.dart';
import 'package:do_my/widgets/logo_mini_one.widget.dart';
import 'package:do_my/widgets/map_home.dart';
import 'package:do_my/widgets/mapbox_full_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PedidoBloc blocPedidos;

  @override
  Widget build(BuildContext context) {
//    Future<LocationData> ubicacion = getLocation();
    blocPedidos = BlocProvider.of(context);

    Widget fondo = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "images/fondoHomeDomy.png",
            )),
      ),
    );

    return Stack(
      alignment: Alignment.topCenter,
      children: [
//        MapFullScreen(),
        MapCreatePedido(),
        LogoMiniOne(),
        StreamBuilder(
          stream: blocPedidos.serviciosStream,
          builder: (BuildContext context, AsyncSnapshot snapshop) {
            switch (snapshop.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                print(
                    "datos de snap done=> ${snapshop.data.snapshot.value.toString()}");

                return Contenido(context);

              case ConnectionState.active:
                print(
                    "datos de snap  active=> ${snapshop.data.snapshot.value.toString()}");
                return Contenido(context);

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



//  @override
//  void dispose() {
//    print("dispose home screen");
////    blocPedidos.serviciosStream = null;
//    super.dispose();
//  }
}

Future<LocationData> getLocation() async {
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
  Contenido(BuildContext context);

  UserBloc userBloc;
  PedidoBloc pedidoBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    pedidoBloc = BlocProvider.of<PedidoBloc>(context);

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
      builder: (context, scrollController) {
        return FirebaseAnimatedList(
          padding: EdgeInsets.all(16.0),
          query: pedidoBloc.serviciosRefSort,
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map servicios = snapshot.value;

            //          Servicio(titulo: ,)
            print("datos de servicio ${servicios.toString()}");

            return CardServicio(servicio: Servicio(
              descripcion: servicios['descripcion'],
              imagenUrl: servicios['imagenUrl'],
              nombre: servicios['nombre'],
              nombreCategoria: servicios['nombreCategoria'],
              categoriaId: servicios['categoria']
            ),
            createPedido: (){

              userBloc.nuevoPedido = Pedido(
                nombreCategoria: servicios['nombreCategoria'],
                categoriaId: servicios['categoria'],
                nombreServicio: servicios['nombre'],
                servicioId: snapshot.key,

              );

              print("nuevo pedido antes de cambiar de pantalla");

              print(userBloc.nuevoPedido);

              Navigator.of(context).pushNamed('createPedido');

//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => CreateNewPedido()),
//              );


            },
            );
          },
        );

//          ListView(
//          padding: EdgeInsets.all(16),
//          controller: scrollController,
//          children: [
////            pedidoBloc.sortListServicios(scrollController),
////              Container(
////                height: double.infinity,
////                child: pedidoBloc.sortListServicios(),
////              )
//
////                Column(
////                  children: this.listServicios
//////                  [
//////                    Servicio(imagen: "images/taxi.png", titulo: "Taxi",descripcion: "Servicio de transporte",),
//////                    Servicio(imagen: "images/mensajeria.png", titulo: "Mensajería",descripcion: "Llevamos tus paquetes al lugar de destino",),
//////                    Servicio(imagen: "images/compras.png", titulo: "Compras",descripcion: "Dinos que comprar y lo llevamos a la puerta de tu casa",),
//////                    Servicio(imagen: "images/servicios.png", titulo: "Servicios públicos",descripcion: "¿tienes recibos pendientes?. Descuida, los pagamos por ti",),
//////                    Servicio(imagen: "images/especial.png", titulo: "Especial",descripcion: "¿Deseas un servicio personalizado?. Cuenta con nosotros",),
//////
//////                  ],
////                ),
//          ],
//        );
      },
    );
  }
}

//class Servicio extends StatelessWidget {
//  String imagen;
//  String titulo;
//  String descripcion;
//
//  Servicio({this.imagen, this.titulo, this.descripcion});
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 85.0,
//      margin: EdgeInsets.only(bottom: 13.0),
//      decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.all(Radius.circular(10)),
//          boxShadow: [
//            BoxShadow(
//                blurRadius: 20.0,
//                color: Colors.black38,
//                offset: Offset(0.0, 0.7))
//          ]),
//      child: InkWell(
//        onTap: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => CreateNewPedido(titulo: this.titulo)),
//          );
//        },
//        child: Ink(
//          child: Row(
//            children: [
//              Container(
//                width: 50.0,
//                height: 50.0,
//                margin: EdgeInsets.all(15.0),
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: DecorationImage(
//                        image: NetworkImage(this.imagen), fit: BoxFit.cover)),
//              ),
//              Expanded(
//
//                child: Column(
//
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Text(
//                      this.titulo,
//                      style: TextStyle(
//                          fontSize: 16.0,
//                          fontWeight: FontWeight.bold,
//                          fontFamily: "Poppins"),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(right: 15.0),
//                      child: Text(
//                        this.descripcion,
//                        overflow: TextOverflow.ellipsis,
//                        maxLines: 2,
//                        style: TextStyle(
//                          fontSize: 12.0,
//                          fontWeight: FontWeight.normal,
//                          fontFamily: "Poppins",
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
