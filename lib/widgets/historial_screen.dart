import 'package:do_my/widgets/card_pedido_widget.dart';
import 'package:do_my/widgets/home_screen.dart';
import 'package:flutter/material.dart';

class Historial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:HistorialPedidos()
    );
  }
}

class HistorialPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 66,right: 16,left: 16),
      children: [
        Column(
          children: [
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/taxi.png", titulo: "Calle 1 # 1 - 2",descripcion: "llevo una maleta",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/especial.png", titulo: "Servicios públicos",descripcion: "1. factura de electricaribe, 2 facturas gases del caribe, 1 factura de emdupar",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/taxi.png", titulo: "Calle 1 # 1 - 2",descripcion: "llevo una maleta",),
            CardPedido(imagen: "images/compras.png", titulo: "Exito de las flores",descripcion: "1 libra de arroz, 1 litro de aceite, 1 libra de queso, 4 manzanas",),
            CardPedido(imagen: "images/especial.png", titulo: "Servicios públicos",descripcion: "1. factura de electricaribe, 2 facturas gases del caribe, 1 factura de emdupar",),

          ],
        )
      ],
    );
  }
}