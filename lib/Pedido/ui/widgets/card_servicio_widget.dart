

import 'package:do_my/Pedido/model/pedido.dart';
import 'package:do_my/Pedido/model/servicio.dart';
import 'package:do_my/Pedido/ui/screens/create_new_pedido_screen.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CardServicio extends StatelessWidget {
//  String imagen;
//  String titulo;
//  String descripcion;

  Servicio servicio;

  UserBloc userBloc;

  VoidCallback createPedido;

  CardServicio({Key key,this.servicio, this.createPedido});
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    print('datos de user bloc ');
//    print(userBloc.cu)
//    userBloc.nuevoPedido(new Pedido(
//      nombreCategoria: this.servicio.nombreCategoria,
//      categoriaId: this.servicio.categoriaId,
//      nombreServicio: this.servicio.nombre,
//      servicioId: this.servicio.id,
//
//    ));
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
                offset: Offset(0.0, 0.7))
          ]),
      child: InkWell(
        onTap: createPedido,
        child: Ink(
          child: Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(this.servicio.imagenUrl), fit: BoxFit.cover)),
              ),
              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      this.servicio.nombre,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      child: Text(
                        this.servicio.descripcion,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}