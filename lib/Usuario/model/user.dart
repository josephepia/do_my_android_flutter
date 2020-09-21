import 'package:flutter/material.dart';

class User {
  final String uid;

   String identificacion;
   String telefono;
   String biografia;

   String nombre;
   String correo;
   String photoUrl;

  final int dateCreate;
  final int dateUpdate;
  final int lastLogin;

  bool profileComplete;
  String rol;
  bool profileMinDataComplete;

  String matriculaVehiculo;
  String tipoVehiculo;
  String idTipoVehiculo;
  String marcaVehiculo;
  String idMarcaVehiculo;
  String colorVehiculo;

  String photoUrlCar;
  String licenciaTransitoUrlA;
  String licenciaTransitoUrlB;
  String identificacionUrlA;
  String identificacionUrlB;

  String licenciaConducirUrlA;
  String licenciaConducirUrlB;


  User(
      {
      Key key,
      this.uid,
      this.identificacion,
      this.telefono,
      this.biografia,
      this.nombre,
      this.correo,
      this.photoUrl,
      this.dateCreate,
      this.dateUpdate,
      this.lastLogin,
      this.profileComplete,
      this.rol,
      this.profileMinDataComplete,
      this.matriculaVehiculo,
      this.tipoVehiculo,
      this.idTipoVehiculo,
      this.marcaVehiculo,
      this.idMarcaVehiculo,
      this.colorVehiculo,
      this.photoUrlCar,
      this.licenciaTransitoUrlA,
      this.licenciaTransitoUrlB,
      this.identificacionUrlA,
      this.identificacionUrlB,
      this.licenciaConducirUrlA,
      this.licenciaConducirUrlB});

  //  o Matricula
//    Tipo Vehiculo (Que muestre las opciones Moto, Carro, Bicicleta)
//    Marca Vehiculo
//    Color Vehiculo




}