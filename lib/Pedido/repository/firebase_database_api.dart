

import 'dart:collection';

import 'package:do_my/Pedido/model/servicio.dart' as model;
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/widgets/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/material.dart';

class FirebaseDatabaseAPI {

  final idCatDomicilios = "-MFqC6uHNXx1tSvO2NVK";
  final serviciosRef = FirebaseDatabase.instance.reference().child('servicios');
  final serviciosRefSort = FirebaseDatabase.instance.reference().child("servicios/-MFqC6uHNXx1tSvO2NVK").orderByChild("prioridad");
  FirebaseAnimatedList sortListServicios(ScrollController scrollController){

    return FirebaseAnimatedList(
        query: serviciosRefSort,
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (
            BuildContext,
            DataSnapshot snapshot,
            Animation<double>animation,
            int index
        ){

          Map servicios = snapshot.value;

//          Servicio(titulo: ,)
          return Servicio(
            descripcion: servicios['descripcion'] ,
            imagen: servicios['imagenUrl'],
            titulo: servicios['nombre'],
          );

        },

    );
  }


  List<Servicio> buildServicios(DataSnapshot dataSnapshot){

    print("lo que llega de firebase ");
    print(dataSnapshot.value.toString());
    print("-------------------------");
    List<Servicio> servicios = List<Servicio>();

    LinkedHashMap<dynamic,dynamic>  values2 = dataSnapshot.value;
    Map<dynamic,dynamic> values = dataSnapshot.value;

    values.forEach((k,v) {
      print("- key  ${k} -value ${v}");
//      servicios.add(Servicio(
//        descripcion: v['descripcion'] ,
//        imagen: v['imagenUrl'],
//        titulo: v['nombre'],
//      ));
    });

    values2.forEach((k,v) {
      print("- key2  ${k} -value2 ${v}");
//      servicios.add(Servicio(
//        descripcion: v['descripcion'] ,
//        imagen: v['imagenUrl'],
//        titulo: v['nombre'],
//      ));
    });
//    var serviciosNuevo = values.keys.toList(growable:false)
//      ..sort((k1, k2) => values[k1].compareTo(servicios[k2]));
//    LinkedHashMap sortedMap = new LinkedHashMap
//        .fromIterable(sortedKeys, key: (k) => k, value: (k) => temp[k]);
//    print(sortedMap);

    return servicios;

  }

//  listervicios(User user){
////    Map<String, dynamic>  userData = user;
//    userRef.child(user.uid).update({
//      "uid": user.uid,
//      "nombre": user.nombre,
//      "correo": user.correo,
//      "photoUrl": user.photoUrl,
//      'dateUpdate': ServerValue.timestamp,
//      'lastLogin': ServerValue.timestamp
//    }).then((_){
//      print("usuario actualizado correctamente}");
//    }).catchError((onError){
//      print("ocurrio un error al actualizar el usuario ${onError}");
//    });
//  }


}