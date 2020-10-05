import 'package:do_my/Pedido/model/pedido.dart';
import 'package:do_my/Usuario/ui/widgets/button_price_edit_widget.dart';
import 'package:do_my/Usuario/ui/widgets/fab_widget.dart';
import 'package:do_my/Usuario/ui/widgets/map_create_pedido_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailServiceStandby extends StatelessWidget {
  Color colorSecondary = Color.fromRGBO(58, 207, 227, 1.0);
  Color colorPrimary = Color.fromRGBO(9, 46, 135, 1.0);

  Pedido pedido;
  @override
  Widget build(BuildContext context) {
    pedido = Pedido(
        descripcion: "llevo una maleta grade",
      origen: "calle 13 # 34 - barrio san agustin origen",
      destino: "calle 13 # 34 - barrio san agustin destino",
      precio: 5000.0,
      origenLat: 10.478553,
      origenLong: -73.271032,
      destinoLat: 10.478200,
      destinoLong: -73.254000,

    );
    return Scaffold(
      body: Stack(
        children: [
          MapCreatePedido(
//            destino: "valledupar",
//            origen: "Valledupar",
//            destinoLocation: LatLng(pedido.destinoLat, pedido.destinoLong),
//            origenLocation: LatLng(pedido.origenLat, pedido.origenLong),
//            userLocation: LatLng(10.461439, -73.253489),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
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
                              "Categoria",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
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
                                        Text(
                                          "calle 12 # 45 - 45 la popa",
                                          style: TextStyle(fontFamily: "Poppins"),
                                        )
                                      ],
                                    ),
                                  ),
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
                                        Text(
                                          "calle 12 # 45 - 45 la popa",
                                          style: TextStyle(fontFamily: "Poppins"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.attach_money,
                                          size: 40.0,
                                          color: colorPrimary,
                                        ),
                                      ),
                                      Text(
                                        "5000",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 40.0,
                                          color: colorPrimary
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text("llevo una maleta grande",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0,),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Ajustar precio",
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
                            ButtonPrice(
                                textColor: Colors.white,
                                backColor: Colors.deepOrange,
                                text: "-\$1000",
                                onPress: () {}),
                            ButtonPrice(
                                textColor: Colors.white,
                                backColor: Colors.green,
                                text: "+\$1000",
                                onPress: () {})
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FAB(
                          icon: Icons.delete,
                          text: "Cancelar",
                          backColor: Colors.deepOrange,
                          isMini: true,
                          textColor: colorPrimary,
                          onPress: () {},
                        ),
                        FAB(
                            icon: Icons.restore,
                            text: "Reenviar",
                            backColor: Colors.green,
                            isMini: false,
                            textColor: colorPrimary,
                            onPress: () {}),
                        FAB(
                            icon: Icons.edit,
                            text: "Editar",
                            backColor: Colors.blue,
                            isMini: true,
                            textColor: colorPrimary,
                            onPress: () {}),
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
