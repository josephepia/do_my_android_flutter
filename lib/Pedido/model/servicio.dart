import 'package:flutter/material.dart';

class Servicio {
   String nombre;
   String descripcion;
   String imagenUrl;

   String id;
   String categoriaId;
   String nombreCategoria;

  Servicio({Key key, @required this.nombre,@required this.descripcion, @required this.imagenUrl,this.id,this.categoriaId,this.nombreCategoria});

}