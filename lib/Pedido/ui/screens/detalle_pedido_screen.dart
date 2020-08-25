import 'package:do_my/Pedido/ui/widgets/detalle_conductor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetallePedido extends StatefulWidget {
  @override
  _DetallePedido createState() => _DetallePedido();
}

class _DetallePedido extends State<DetallePedido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(

            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/mapa.png",
                  
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Stack(
                  alignment: Alignment(0.0,1.5),
                  children: [
                    DetalleConductor(),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0,7.0),
                                blurRadius: 20.0
                            )
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 20
                            ),
                            child: FloatingActionButton(
                              child: Icon(
                                Icons.call,

                              ),
                              backgroundColor: Colors.green,
                              mini: true,

                            ),
                          ),

                          Text("Llamar",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                              fontSize: 16
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (context,scrollController){
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(
                  right: 16,
                  left: 16
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30) ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                          color: Colors.black12,
                          offset: Offset(0.0, 0.7)

                      )
                    ]
                ),
                child: ListView(
                  controller: scrollController,
                  children: [

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Precio",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(9, 46, 135, 1.0)
                              ),
                            ),
                            Text(
                              "\$5000",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 24,
                                  color: Color.fromRGBO(9, 46, 135, 1.0)
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comentario",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(9, 46, 135, 1.0)
                              ),
                            ),
                            Text(
                              "Llevo una maleta grande",
                              style: TextStyle(
                                  fontFamily: "Poppins",

                                  color: Color.fromRGBO(9, 46, 135, 1.0)
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Container(

                          padding: EdgeInsets.only(left: 20,top: 10.0),
                          child: Column(
                            children: [
                              TimelineTile(

                                alignment: TimelineAlign.left,
                                isFirst: true,
                                topLineStyle: LineStyle(
                                    width: 2,
                                    color: Color.fromRGBO(58, 207, 227, 1.0)
                                ),
                                indicatorStyle: IndicatorStyle(
                                  width: 30,
                                  color: Color.fromRGBO(9, 46, 135, 1.0),
                                  padding: const EdgeInsets.all(8),
                                  iconStyle: IconStyle(
                                    color: Colors.white,
                                    iconData: Icons.info_outline,
                                  ),
                                ),
                                rightChild: Container(
                                  padding: EdgeInsets.only(top: 25),
                                  constraints: const BoxConstraints(
                                    minHeight: 80,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Servicio aceptado",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color.fromRGBO(9, 46, 135, 1.0),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text("Recibimos tu pedido",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color.fromRGBO(112, 112, 112, 1.0),
                                            fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TimelineTile(

                                alignment: TimelineAlign.left,
                                isFirst: false,
                                topLineStyle: LineStyle(
                                    width: 2,
                                    color: Color.fromRGBO(58, 207, 227, 1.0)
                                ),
                                indicatorStyle: IndicatorStyle(
                                  width: 30,
                                  color: Color.fromRGBO(9, 46, 135, 1.0),
                                  padding: const EdgeInsets.all(8),
                                  iconStyle: IconStyle(
                                    color: Colors.white,
                                    iconData: Icons.info_outline,
                                  ),
                                ),
                                rightChild: Container(
                                  padding: EdgeInsets.only(top: 25),
                                  constraints: const BoxConstraints(
                                    minHeight: 80,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Conductor en camino",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color.fromRGBO(9, 46, 135, 1.0),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text("En breve llegará el conductor",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color.fromRGBO(112, 112, 112, 1.0),
                                            fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TimelineTile(

                                alignment: TimelineAlign.left,
                                isLast: true,
                                topLineStyle: LineStyle(
                                    width: 2,
                                    color: Color.fromRGBO(58, 207, 227, 1.0)
                                ),
                                indicatorStyle: IndicatorStyle(
                                  width: 30,
                                  color: Color.fromRGBO(9, 46, 135, 1.0),
                                  padding: const EdgeInsets.all(8),
                                  iconStyle: IconStyle(
                                    color: Colors.white,
                                    iconData: Icons.info_outline,
                                  ),
                                ),
                                rightChild: Container(
                                  padding: EdgeInsets.only(top: 25),
                                  constraints: const BoxConstraints(
                                    minHeight: 80,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Llegó el conductor",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color.fromRGBO(9, 46, 135, 1.0),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text("El coductor espera por usted",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color.fromRGBO(112, 112, 112, 1.0),
                                            fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )

                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(231, 76, 60, 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                  const Text('Cancelar', style: TextStyle(fontSize: 20)),
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ],
                ),


              );
            },
          )
        ],
      ),
    );
  }
}
