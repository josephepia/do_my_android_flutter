import 'package:flutter/material.dart';

class Pedido {

   String id;
   String origen;   //origen en texto
   String destino;  //destino en texto
   String descripcion;
   double precio;
   String estado;   //deberia ser final
   String clienteUid;
  String servicioId;
  String nombreServicio;
  String nombreCategoria;
  String categoriaId;
   String socioUid;
   double origenLat;   //deberia ser final
   double origenLong;  //deberia ser final
   double destinoLat;  //deberia ser final
   double destinoLong; //deberia ser final

  Pedido({
    Key key,
    this.id,
    this.origen,
    this.destino,
    this.descripcion,
    this.precio,
    this.estado,
    this.clienteUid,
    this.socioUid,
    this.origenLat,
    this.origenLong,
    this.destinoLat,
    this.destinoLong,
    this.categoriaId,
    this.servicioId,
    this.nombreCategoria,
    this.nombreServicio
  });
}