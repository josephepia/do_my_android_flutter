import 'package:do_my/Pedido/ui/screens/detalle_pedido_screen.dart';
import 'package:do_my/widgets/card_pedido_widget.dart';
import 'package:do_my/widgets/home_screen.dart';
import 'package:flutter/material.dart';

class Pedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PedidoPendiente(),
    );
  }
}
class PedidoIndividual extends StatelessWidget {

  String imagen;
  String titulo;
  String descripcion;


  PedidoIndividual({this.imagen,this.titulo,this.descripcion});
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
              MaterialPageRoute(builder: (context) => DetallePedido()),
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
                          image: AssetImage(this.imagen),
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

class PedidoPendiente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 66,right: 16,left: 16),
      children: [
        Center(
          child: Text(
            "No tienes pedidos pendientes",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black26
            ),
          ),
        )
//        Column(
//          children: [
//            PedidoIndividual(imagen: "images/taxi.png", titulo: "Calle 1 # 1 - 2",descripcion: "llevo una maleta",),
//            PedidoIndividual(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
//            PedidoIndividual(imagen: "images/especial.png", titulo: "Servicios públicos",descripcion: "1. factura de electricaribe, 2 facturas gases del caribe, 1 factura de emdupar",),
//          ],
//        )
      ],
    );
  }
}

