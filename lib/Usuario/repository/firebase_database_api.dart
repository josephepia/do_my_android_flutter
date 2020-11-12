

import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseAPI {

  final _databaseInstance = FirebaseDatabase.instance;
  final userRef = FirebaseDatabase.instance.reference().child('usuarios');

  final serviciosRef = FirebaseDatabase.instance.reference().child('servicios');



  Future<User> myProfileOnce(String uid) async{
    return await userRef.child(uid).once().then((snapShot){
      Map<dynamic,dynamic> values = snapShot.value;
      Map<String,dynamic> datos  = Map<String,dynamic>.from(snapShot.value);
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

      User user = User.fromJsonMap(datos);

//      User user = User(
//        nombre: snapShot.value["nombre"],
//        correo: snapShot.value["correo"],
//        biografia: snapShot.value["biografia"] ?? "Cuentanos mas sobre ti",
//        photoUrl: snapShot.value["photoUrl"],
//        dateCreate: snapShot.value["dateCreate"],
//        dateUpdate: snapShot.value["dateUpdate"],
//        identificacion: snapShot.value["identificacion"],
//        uid: uid,
//        lastLogin: snapShot.value["lasLogin"],
//        telefono: snapShot.value["telefono"],
//        profileComplete: snapShot.value["profileComplete"]
//      );


      return user;

    }).catchError((error){
      print("error al intentar obtener el usuario -> $error");
      return null;
    }).then((usuario) => usuario).catchError((onError)=> null);
  }
  Stream myProfileOnce2(String uid) async*{
    yield userRef.child(uid).onValue;
  }

  Future updateDatabaseMapRoot(Map<String, dynamic> datos){
    return _databaseInstance.reference().update(datos);
  }

  Future updateDatabaseMap(String ref, Map<String, dynamic> datos) async{
    Map<String,dynamic> finalData = Map<String,dynamic>();

    datos.forEach((k,v) {
      print("key $k valor $v");
      if(v!= null){
        finalData[k] = v;
      }

    });
    return _databaseInstance.reference().child(ref).update(finalData);

  }
  Future setDatabase(String ref, dynamic datos) async{
    return _databaseInstance.reference().child(ref).set(datos);
  }

  User buildUser(DataSnapshot snapShot){
//    Map<dynamic,dynamic> values = snapShot.value;
    Map<String,dynamic> datos  = Map<String,dynamic>.from(snapShot.value);

    User user = User.fromJsonMap(datos);
//    User user = User(
//        nombre: snapShot.value["nombre"],
//        correo: snapShot.value["correo"],
//        biografia: snapShot.value["biografia"] ?? "Cuentanos mas sobre ti",
//        photoUrl: snapShot.value["photoUrl"],
//        dateCreate: snapShot.value["dateCreate"],
//        dateUpdate: snapShot.value["dateUpdate"],
//        identificacion: snapShot.value["identificacion"],
//        uid: snapShot.value["uid"],
//        lastLogin: snapShot.value["lasLogin"],
//        telefono: snapShot.value["telefono"],
//        profileComplete: snapShot.value["profileComplete"],
//        profileMinDataComplete: snapShot.value["profileMinDataComplete"],
//
//    );


    return user;
  }

  Future<User> getUser(String uid) async{
    return await userRef.orderByKey().equalTo(uid).limitToFirst(1).once().then((snapShot){
      Map<dynamic,dynamic> values = snapShot.value;
      Map<String,dynamic> datos  = Map<String,dynamic>.from(snapShot.value);

          User user = User.fromJsonMap(datos);
//      values.forEach((k,v) {
//        print("- key  ${k} -value ${v}");
////        servicios.add(Servicio(
////          descripcion: v['descripcion'] ,
////          imagen: v['imagenUrl'],
////          titulo: v['nombre'],
////        ));
//      });
//
//      User user = User(
//        nombre: snapShot.value.nombre,
//        correo: snapShot.value.correo,
//        biografia: snapShot.value.biografia ?? "Cuentanos mas sobre ti",
//        photoUrl: snapShot.value.photoUrl,
//        dateCreate: snapShot.value.dateCreate,
//        dateUpdate: snapShot.value.dateUpdate,
//        identificacion: snapShot.value.identificacion,
//        uid: uid,
//        lastLogin: snapShot.value.lasLogin,
//        telefono: snapShot.value.telefono
//      );


      return user;

    }).catchError((error){
      print("error al intentar obtener el usuario -> $error");
      return null;
    }).then((usuario) => usuario).catchError((onError)=> null);
  }

  Future updateUser({User user, bool checkConductor}) async{
//    Map<String, dynamic>  userData = user;
    bool profileMinComplete = false;
    if(user.nombre !=null && user.telefono !=null ){
      profileMinComplete = true;
      user.minDataClient = true;
    }
//    user.isNew = false;

//    if(user.rol == "conductor"){
//      if(user.)
//    }
//
//    o Matricula
//    Tipo Vehiculo (Que muestre las opciones Moto, Carro, Bicicleta)
//    Marca Vehiculo
//    Color Vehiculo

     Map<String, dynamic>  userData = Map<String, dynamic>();

    user.toJson().forEach((k,v) {
    print("key $k valor $v");
      if(v!= null){
        userData[k] = v;
      }

    });

    userData['dateUpdate'] = ServerValue.timestamp;
    userData["profileMinDataComplete"]= profileMinComplete;

    return await userRef.child(user.uid).update(userData).then((_){
      print("usuario actualizado correctamente}");
    }).catchError((onError){
      print("ocurrio un error al actualizar el usuario ${onError}");
    });

//    return await userRef.child(user.uid).update({
//      "uid": user.uid,
//      "nombre": user.nombre,
//      "correo": user.correo,
//      "photoUrl": user.photoUrl,
//      'dateUpdate': ServerValue.timestamp,
//      'lastLogin': ServerValue.timestamp,
//      'telefono': user.telefono,
//      "profileMinDataComplete": profileMinComplete,
//      "tipoVehiculo": user.tipoVehiculo,
//      "colorVehiculo": user.colorVehiculo,
//      "marcaVehiculo": user.marcaVehiculo,
//      "matriculaVehiculo": user.matriculaVehiculo,
//      "tipoVehiculo": user.tipoVehiculo,
//      "licenciaTransitoUrlB": user.licenciaTransitoUrlB,
//      "licenciaTransitoUrlA": user.licenciaTransitoUrlA,
//      "licenciaConducirUrlB": user.licenciaConducirUrlB,
//      "licenciaConducirUrlA": user.licenciaConducirUrlA,
//      "identificacionUrlA": user.identificacionUrlA,
//      "identificacionUrlB": user.identificacionUrlB,
//      "photoUrlCar": user.photoUrlCar,
//      "SOATUrlA": user.SOATUrlA,
//      "SOATUrlB": user.SOATUrlB,
//
//
//    }).then((_){
//      print("usuario actualizado correctamente}");
//    }).catchError((onError){
//      print("ocurrio un error al actualizar el usuario ${onError}");
//    });
  }

  lastLoginUser(User user){
//    Map<String, dynamic>  userData = user;
    userRef.child(user.uid).update({
      'isNew': false,
      'lastLogin': ServerValue.timestamp
    }).then((_){
      print("usuario actualizado correctamente");
    }).catchError((onError){
      print("ocurrio un error al actualizar el usuario ${onError}");
    });
  }

  saveUser(User user) async{
//    Map<String,dynamic> userData = Map<String,dynamic>();
  print('inicio del metodo saveUser');
    user.isNew = true;
    var userData= user.toJson();

    userData['dateUpdate'] = ServerValue.timestamp;
    userData['dateCreate'] = ServerValue.timestamp;
    userData['lastLogin']  = ServerValue.timestamp;
  print('inicio de guardar usuario en base de datos');

  await userRef.child(user.uid).set(userData).then((_){
      print("usuario actualizado correctamente}");
    }).catchError((onError){
      print("ocurrio un error al crear el usuario ${onError}");
    });

    await _databaseInstance.reference().child("solicitudess").child(user.uid).update(
      {
        "estado": "pendiente",
        "usuario": {
          "nombre": user.nombre,
          "identificacion": user.identificacion,
          "photoUrl": user.photoUrl
        },
        "documentos": {
          "licencia": {
            "nombre": "Licencia",
            "estado": "pendiente"
          },
          "soat": {
            "nombre": "SOAT",
            "estado": "pendiente"
          },
          "identificacion": {
            "nombre": "Identificacion",
            "estado": "pendiente"
          },
          "fotoVehiculo": {
            "nombre": "Foto del vehiculo",
            "estado": "pendiente"
          },
        },

      }
    );
    
    

//    userRef.child(user.uid).set({
//      "uid": user.uid,
//      "nombre": user.nombre,
//      "correo": user.correo,
//      "photoUrl": user.photoUrl,
//      'dateUpdate': ServerValue.timestamp,
//      'dateCreate': ServerValue.timestamp,
//      'lastLogin': ServerValue.timestamp,
//      'profileMinDataComplete': false,
//      'profileComplete': false
//    }).then((_){
//      print("usuario actualizado correctamente}");
//    }).catchError((onError){
//      print("ocurrio un error al crear el usuario ${onError}");
//    });
  }
}