

import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseAPI {

  final userRef = FirebaseDatabase.instance.reference().child('usuarios');

  final serviciosRef = FirebaseDatabase.instance.reference().child('servicios');



  Future<User> myProfileOnce(String uid) async{
    return await userRef.child(uid).once().then((snapShot){
      Map<dynamic,dynamic> values = snapShot.value;
//      print("pruebas de impresion por atributo de snapshot.value --------");
//      print(snapShot.value.toString());
//      print(snapShot.value["nombre"]);
//      print("-----------------------------------------------------");
//      print("impresion por atributo del Map");
//      print(values["nombre"]);

//
//      values.forEach((k,v) {
//        print("- key  ${k} -value ${v}");
//
////        servicios.add(Servicio(
////          descripcion: v['descripcion'] ,
////          imagen: v['imagenUrl'],
////          titulo: v['nombre'],
////        ));
//      });

      User user = User(
        nombre: snapShot.value["nombre"],
        correo: snapShot.value["correo"],
        biografia: snapShot.value["biografia"] ?? "Cuentanos mas sobre ti",
        photoUrl: snapShot.value["photoUrl"],
        dateCreate: snapShot.value["dateCreate"],
        dateUpdate: snapShot.value["dateUpdate"],
        identificacion: snapShot.value["identificacion"],
        uid: uid,
        lastLogin: snapShot.value["lasLogin"],
        telefono: snapShot.value["telefono"],
        profileComplete: snapShot.value["profileComplete"]
      );


      return user;

    }).catchError((error){
      print("error al intentar obtener el usuario -> $error");
      return null;
    }).then((usuario) => usuario).catchError((onError)=> null);
  }
  Stream myProfileOnce2(String uid) async*{
    yield userRef.child(uid).onValue;
  }

  User buildUser(DataSnapshot snapShot){
//    Map<dynamic,dynamic> values = snapShot.value;
    User user = User(
        nombre: snapShot.value["nombre"],
        correo: snapShot.value["correo"],
        biografia: snapShot.value["biografia"] ?? "Cuentanos mas sobre ti",
        photoUrl: snapShot.value["photoUrl"],
        dateCreate: snapShot.value["dateCreate"],
        dateUpdate: snapShot.value["dateUpdate"],
        identificacion: snapShot.value["identificacion"],
        uid: snapShot.value["uid"],
        lastLogin: snapShot.value["lasLogin"],
        telefono: snapShot.value["telefono"],
        profileComplete: snapShot.value["profileComplete"],
        profileMinDataComplete: snapShot.value["profileMinDataComplete"],

    );


    return user;
  }

  Future<User> getUser(String uid) async{
    return await userRef.orderByKey().equalTo(uid).limitToFirst(1).once().then((snapShot){
      Map<dynamic,dynamic> values = snapShot.value;

      values.forEach((k,v) {
        print("- key  ${k} -value ${v}");
//        servicios.add(Servicio(
//          descripcion: v['descripcion'] ,
//          imagen: v['imagenUrl'],
//          titulo: v['nombre'],
//        ));
      });
      User user = User(
        nombre: snapShot.value.nombre,
        correo: snapShot.value.correo,
        biografia: snapShot.value.biografia ?? "Cuentanos mas sobre ti",
        photoUrl: snapShot.value.photoUrl,
        dateCreate: snapShot.value.dateCreate,
        dateUpdate: snapShot.value.dateUpdate,
        identificacion: snapShot.value.identificacion,
        uid: uid,
        lastLogin: snapShot.value.lasLogin,
        telefono: snapShot.value.telefono
      );


      return user;

    }).catchError((error){
      print("error al intentar obtener el usuario -> $error");
      return null;
    }).then((usuario) => usuario).catchError((onError)=> null);
  }

  Future updateUser({User user, bool checkConductor}) async{
//    Map<String, dynamic>  userData = user;
    bool profileMinComplete = false;
    if(user.nombre.isNotEmpty && user.telefono.isNotEmpty ){
      profileMinComplete = true;
    }

//    if(user.rol == "conductor"){
//      if(user.)
//    }
//
//    o Matricula
//    Tipo Vehiculo (Que muestre las opciones Moto, Carro, Bicicleta)
//    Marca Vehiculo
//    Color Vehiculo


    return await userRef.child(user.uid).update({
      "uid": user.uid,
      "nombre": user.nombre,
      "correo": user.correo,
      "photoUrl": user.photoUrl,
      'dateUpdate': ServerValue.timestamp,
      'lastLogin': ServerValue.timestamp,
      'telefono': user.telefono,
      "profileMinDataComplete": profileMinComplete,

    }).then((_){
      print("usuario actualizado correctamente}");
    }).catchError((onError){
      print("ocurrio un error al actualizar el usuario ${onError}");
    });
  }

  lastLoginUser(User user){
//    Map<String, dynamic>  userData = user;
    userRef.child(user.uid).update({
      'lastLogin': ServerValue.timestamp
    }).then((_){
      print("usuario actualizado correctamente");
    }).catchError((onError){
      print("ocurrio un error al actualizar el usuario ${onError}");
    });
  }

  saveUser(User user){
    userRef.child(user.uid).set({
      "uid": user.uid,
      "nombre": user.nombre,
      "correo": user.correo,
      "photoUrl": user.photoUrl,
      'dateUpdate': ServerValue.timestamp,
      'dateCreate': ServerValue.timestamp,
      'lastLogin': ServerValue.timestamp,
      'profileMinDataComplete': false,
      'profileComplete': false
    }).then((_){
      print("usuario actualizado correctamente}");
    }).catchError((onError){
      print("ocurrio un error al crear el usuario ${onError}");
    });
  }
}