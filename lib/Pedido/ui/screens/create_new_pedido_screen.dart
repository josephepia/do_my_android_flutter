import 'package:do_my/Pedido/model/pedido.dart';
import 'package:do_my/Pedido/ui/screens/origen_hero.dart';
import 'package:do_my/Pedido/ui/widgets/search_delegate.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/location_service.dart';
import 'package:do_my/Usuario/model/user_location.dart';
import 'package:do_my/Usuario/ui/widgets/button_price_edit_widget.dart';
import 'package:do_my/Usuario/ui/widgets/fab_widget.dart';
import 'package:do_my/Usuario/ui/widgets/map_create_pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class CreateNewPedido extends StatefulWidget {



//  CreateNewPedido({Key key, this.pedido});

  @override
  _CreateNewPedidoState createState() => _CreateNewPedidoState();
}


class _CreateNewPedidoState extends State<CreateNewPedido> {
  Color colorSecondary = Color.fromRGBO(58, 207, 227, 1.0);
  Color colorPrimary = Color.fromRGBO(9, 46, 135, 1.0);
//  Pedido pedido;
  List<bool> _slections = List.generate(3, (_) => false);
//  LocationService locationService;
//  LatLng userLocation;

//  Pedido nuevoPedido;
  UserBloc userBloc;
  TextEditingController origen = TextEditingController();
  TextEditingController destino = TextEditingController();
  TextEditingController inputCOntrollerOrigen = TextEditingController();


  @override
  void initState() {
//    locationService = LocationService();
//     locationService.getLocation().then((userlocatrionorigin){
//      userLocation = LatLng(userlocatrionorigin.latitude, userlocatrionorigin.longitude);
//
//
//    });



  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
//    userLocation = LatLng( userBloc.myLocation.latitude, userBloc.myLocation.longitude);
    Pedido pedidotem = userBloc.nuevoPedido;
    origen.text = userBloc.nuevoPedido.origen;
    destino.text = userBloc.nuevoPedido.destino;

//    pedidotem.origenLong








//    userLocation = LatLng(userLocationOrigin.)
//    pedido = Pedido(
//      descripcion: "llevo una maleta grade",
//      origen: "calle 13 # 34 - barrio san agustin origen",
//      destino: "calle 13 # 34 - barrio san agustin destino",
//      precio: 5000.0,
//      origenLat: 10.478553,
//      origenLong: -73.271032,
//      destinoLat: 10.478200,
//      destinoLong: -73.254000,
//
//    );




    return Scaffold(
      body: Stack(
        children: [
          MapCreatePedido(
//
//            destino: "valledupar",
//            origen: "Valledupar",
////            destinoLocation: LatLng(pedido.destinoLat, pedido.destinoLong),
////            origenLocation: LatLng(pedido.origenLat, pedido.origenLong),
//            userLocation: userLocation,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 20.0)
                    ]),
                child: ListView(
                  controller: scrollController,
                  padding:
                  EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.all(4.0),
                                width: 50.0,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(4.0)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              userBloc.nuevoPedido.nombreServicio ?? "nombre no encontrado",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Expanded(
//                              child: Column(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//
//                                  Container(
//                                    child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: [
//                                        Container(
//                                            margin: EdgeInsets.all(6.0),
//                                            child: Stack(
//                                              alignment: Alignment.center,
//                                              children: [
//                                                Container(
//                                                  width: 20.0,
//                                                  height: 20.0,
//                                                  decoration: BoxDecoration(
//                                                      shape: BoxShape.circle,
//                                                      color: colorPrimary),
//                                                ),
//                                                Text(
//                                                  "A",
//                                                  style: TextStyle(
//                                                      fontFamily: "Poppins",
//                                                      color: Colors.white),
//                                                )
//                                              ],
//                                            )),
//                                        Expanded(
//                                          child: AddressSearchField(
////                                            controller: inputIdentificacion,
//                                            controller: origen,
//                                            decoration: InputDecoration(
//                                                filled: true,
//                                                fillColor: Color(0xffF6F6F6),
////                labelText: "numero telefonico",
//                                                labelStyle:
//                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
//                                                border: InputBorder.none,
//                                                hintText: "Origen",
//                                                enabledBorder: OutlineInputBorder(
//                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
//                                                  borderRadius: BorderRadius.circular(10),
//                                                ),
//                                                focusedBorder: OutlineInputBorder(
//                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
//                                                  borderRadius: BorderRadius.circular(10),
//                                                )),
//                                            style: TextStyle(
//                                                fontFamily: "Poppins"
//                                            ),
//                                            barrierDismissible: true,
//                                            country: "Colombia",
//                                            city: "Valledupar",
//                                            hintText: "Origen",
//                                            noResultsText: "Sin resultados",
////                                            exceptions: <String>[],
////                                            coordForRef: bool,
//                                            onDone: (BuildContext dialogContext, AddressPoint point) {
//                                              print("cordenandas ${point.toString()}");
//                                              print(point.address);
//                                              print(point.latitude);
//                                              print(point.longitude);
//
//                                              userBloc.nuevoPedido.origen = point.address;
//                                              userBloc.nuevoPedido.origenLat = point.latitude;
//                                              userBloc.nuevoPedido.origenLong = point.longitude;
//                                              Navigator.of(dialogContext).pop();
//
//                                            },
//                                            onCleaned: () {},
//
//
////                                            maxLines: 1,
////                                            keyboardType: TextInputType.text,
//////                                            inputFormatters: [
//////                                              WhitelistingTextInputFormatter.digitsOnly
//////                                            ],
////                                            onSaved: (value){
////                                              userBloc.nuevoPedido.origen = value;
////                                            },
////                                            validator: (value) {
////                                              if (value.isEmpty || value == "") {
////                                                return 'Ingrese una dirección';
////                                              }
////                                              return null;
////                                            },
////                                            style: TextStyle(
////                                                fontFamily: "Poppins"
////                                            ),
////
////                                            decoration: InputDecoration(
////                                                filled: true,
////                                                fillColor: Color(0xffF6F6F6),
//////                labelText: "numero telefonico",
////                                                labelStyle:
////                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
////                                                border: InputBorder.none,
////                                                hintText: "Origen",
////                                                enabledBorder: OutlineInputBorder(
////                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
////                                                  borderRadius: BorderRadius.circular(10),
////                                                ),
////                                                focusedBorder: OutlineInputBorder(
////                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
////                                                  borderRadius: BorderRadius.circular(10),
////                                                )),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(height: 10.0,),
//                                  Container(
//                                    child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: [
//                                        Container(
//                                            margin: EdgeInsets.all(6.0),
//                                            child: Stack(
//                                              alignment: Alignment.center,
//                                              children: [
//                                                Container(
//                                                  width: 20.0,
//                                                  height: 20.0,
//                                                  decoration: BoxDecoration(
//                                                      shape: BoxShape.circle,
//                                                      color: colorPrimary),
//                                                ),
//                                                Text(
//                                                  "B",
//                                                  style: TextStyle(
//                                                      fontFamily: "Poppins",
//                                                      color: Colors.white),
//                                                )
//                                              ],
//                                            )),
//                                        Expanded(
//                                          child: AddressSearchField(
////                                            controller: inputIdentificacion,
//                                            controller: destino,
//                                            decoration: InputDecoration(
//                                                filled: true,
//                                                fillColor: Color(0xffF6F6F6),
////                labelText: "numero telefonico",
//                                                labelStyle:
//                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
//                                                border: InputBorder.none,
//                                                hintText: "Destino",
//                                                enabledBorder: OutlineInputBorder(
//                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
//                                                  borderRadius: BorderRadius.circular(10),
//                                                ),
//                                                focusedBorder: OutlineInputBorder(
//                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
//                                                  borderRadius: BorderRadius.circular(10),
//                                                )),
//                                            style: TextStyle(
//                                                fontFamily: "Poppins"
//                                            ),
//                                            barrierDismissible: true,
//                                            country: "Colombia",
//                                            city: "Valledupar",
//                                            hintText: "Destino",
//                                            noResultsText: "Sin resultados",
////                                            exceptions: <String>[],
////                                            coordForRef: bool,
//                                            onDone: (BuildContext dialogContext, AddressPoint point) {
//                                              print("cordenandas ${point.toString()}");
//                                              print(point.address);
//                                              print(point.latitude);
//                                              print(point.longitude);
//
//                                              userBloc.nuevoPedido.destino = point.address;
//                                              userBloc.nuevoPedido.destinoLat = point.latitude;
//                                              userBloc.nuevoPedido.destinoLong = point.longitude;
//                                              Navigator.of(dialogContext).pop();
//
//                                            },
//                                            onCleaned: () {},
//
//
////                                            maxLines: 1,
////                                            keyboardType: TextInputType.text,
//////                                            inputFormatters: [
//////                                              WhitelistingTextInputFormatter.digitsOnly
//////                                            ],
////                                            onSaved: (value){
////                                              userBloc.nuevoPedido.origen = value;
////                                            },
////                                            validator: (value) {
////                                              if (value.isEmpty || value == "") {
////                                                return 'Ingrese una dirección';
////                                              }
////                                              return null;
////                                            },
////                                            style: TextStyle(
////                                                fontFamily: "Poppins"
////                                            ),
////
////                                            decoration: InputDecoration(
////                                                filled: true,
////                                                fillColor: Color(0xffF6F6F6),
//////                labelText: "numero telefonico",
////                                                labelStyle:
////                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
////                                                border: InputBorder.none,
////                                                hintText: "Origen",
////                                                enabledBorder: OutlineInputBorder(
////                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
////                                                  borderRadius: BorderRadius.circular(10),
////                                                ),
////                                                focusedBorder: OutlineInputBorder(
////                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
////                                                  borderRadius: BorderRadius.circular(10),
////                                                )),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//
//                                ],
//                              ),
//                            ),
//
//                          ],
//                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(6.0),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorPrimary),
                                                ),
                                                Text(
                                                  "A",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),

                                        /// origen inpunt original
                                        Expanded(
                                          child: TextFormField(
                                            controller: inputCOntrollerOrigen,
                                            maxLines: 1,
                                            keyboardType: TextInputType.text,
//                                            inputFormatters: [
//                                              WhitelistingTextInputFormatter.digitsOnly
//                                            ],
                                            onSaved: (value){
                                              userBloc.nuevoPedido.origen = value;
                                            },
                                            validator: (value) {
                                              if (value.isEmpty || value == "") {
                                                return 'Ingrese una dirección';
                                              }
                                              return null;
                                            },
                                            onTap: (){

                                              showSearch(context: context, delegate: DataSearch(inputCOntrollerOrigen));
//                                              Navigator.push(context, MaterialPageRoute(
//                                                  builder: (BuildContext context) => OrigenHero()
//                                              )
//                                              );
                                            },
                                            style: TextStyle(
                                                fontFamily: "Poppins"
                                            ),

                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                                labelStyle:
                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                                border: InputBorder.none,
                                                hintText: "Origen",
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                                  borderRadius: BorderRadius.circular(10),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(6.0),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorPrimary),
                                                ),
                                                Text(
                                                  "B",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),
                                        Expanded(
                                          child: TextFormField(
//                                            controller: inputIdentificacion,
                                            maxLines: 1,
                                            keyboardType: TextInputType.text,
//                                            inputFormatters: [
//                                              WhitelistingTextInputFormatter.digitsOnly
//                                            ],
                                            onSaved: (value){
                                              userBloc.nuevoPedido.destino = value;
                                            },
                                            validator: (value) {
                                              if (value.isEmpty || value == "") {
                                                return 'Ingrese una dirección';
                                              }
                                              return null;
                                            },
                                            style: TextStyle(
                                                fontFamily: "Poppins"
                                            ),

                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                                labelStyle:
                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                                border: InputBorder.none,
                                                hintText: "Destino",
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                                  borderRadius: BorderRadius.circular(10),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  SizedBox(height: 10.0,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(6.0),
                                            child:

                                                Icon(Icons.monetization_on,color: colorPrimary,)
                                              ),
                                        Expanded(
                                          child: TextFormField(
//                                            controller: inputIdentificacion,
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                            onSaved: (value){
                                              userBloc.nuevoPedido.precio = double.parse(value);
                                            },
                                            validator: (value) {
                                              if (value.isEmpty || value == "") {
                                                return 'Ingrese una dirección';
                                              }
                                              return null;
                                            },
                                            style: TextStyle(
                                                fontFamily: "Poppins"
                                            ),

                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                                labelStyle:
                                                TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                                border: InputBorder.none,
                                                hintText: "Precio",
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                                  borderRadius: BorderRadius.circular(10),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text("Descripción",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(6.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
//                                        decoration: BoxDecoration(
//                                            shape: BoxShape.circle,
//                                            color: colorPrimary),
                                      ),
//                                      Text(
//                                        "A",
//                                        style: TextStyle(
//                                            fontFamily: "Poppins",
//                                            color: Colors.white),
//                                      )
                                    ],
                                  )),
                              Expanded(
                                child: TextFormField(
//                                            controller: inputIdentificacion,
                                  maxLines: 3,
                                  keyboardType: TextInputType.text,
//                                            inputFormatters: [
//                                              WhitelistingTextInputFormatter.digitsOnly
//                                            ],
                                  onSaved: (value){
                                    userBloc.nuevoPedido.descripcion = value;
                                  },
                                  validator: (value) {
//                                    if (value.isEmpty || value == "") {
//                                      return 'Ingrese una descripcion';
//                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      fontFamily: "Poppins"
                                  ),

                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                      labelStyle:
                                      TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                      border: InputBorder.none,
                                      hintText: "Descripcion",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Vehículo de preferencia",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ToggleButtons(

                              isSelected: _slections,
                              borderColor: Colors.redAccent,
                              disabledBorderColor: Colors.transparent,

                              borderWidth: 4.0,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Icon(Icons.directions_car,color: Colors.white,),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Text(
                                          "Carro",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Icon(Icons.motorcycle,color: Colors.white,),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Text(
                                          "Moto",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Icon(Icons.directions_bike,color: Colors.white,),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Text(
                                          "Bici",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Text(
                              "Continuar",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),

              );
            },
          ),
        ],
      ),
    );
  }


}
