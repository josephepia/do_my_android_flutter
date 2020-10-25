import 'package:flutter/material.dart';

class User {
   String uid;

  String identificacion;
  String telefono;
  String biografia;
  String tipoSangre;

  String nombre;
  String correo;
  String photoUrl;
  bool verificado;
  bool conductorVerificado;
  bool checkWork;
  String estadoAprobacion;
  bool minDataClientComplete;
  bool minDataDriverComplete;
  bool minDataVehicleComplete;
  bool minDataDocumentComplete;

   int dateCreate;
   int dateUpdate;
   int lastLogin;

  bool profileComplete;
  String rol = "cliente";
  bool profileMinDataComplete;
  bool minDataClient;
  bool minDataDriver;
  bool isNew;

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
  String SOATUrlA;
  String SOATUrlB;

  User({
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
    this.licenciaConducirUrlB,
    this.verificado,
    this.estadoAprobacion,
    this.tipoSangre,
    this.SOATUrlA,
    this.SOATUrlB,
    this.minDataClient,
    this.minDataDriver,
    this.isNew,
    this.conductorVerificado,
    this.checkWork,
    this.minDataClientComplete,
    this.minDataDriverComplete,
    this.minDataVehicleComplete,
    this.minDataDocumentComplete
  });

  User.fromJsonMap(Map<String,dynamic> json){
    print("datos que llegar al json");
    print(json.toString());


    uid                     = json['uid'];
    identificacion          = json['identificacion'];
    telefono                = json['telefono'];
    biografia               = json['biografia'];
    nombre                  = json['nombre'];
    correo                  = json['correo'];
    photoUrl                = json['photoUrl'];
    dateCreate              = json['dateCreate'];
    dateUpdate              = json['dateUpdate'];
    lastLogin               = json['lastLogin'];
    profileComplete         = json['profileComplete'];
    rol                     = json['rol'];
    profileMinDataComplete  = json['profileMinDataComplete'];
    matriculaVehiculo       = json['matriculaVehiculo'];
    tipoVehiculo            = json['tipoVehiculo'];
    idTipoVehiculo          = json['idTipoVehiculo'];
    marcaVehiculo           = json['marcaVehiculo'];
    idMarcaVehiculo         = json['idMarcaVehiculo'];
    colorVehiculo           = json['colorVehiculo'];
    photoUrlCar             = json['photoUrlCar'];
    licenciaTransitoUrlA    = json['licenciaTransitoUrlA'];
    licenciaTransitoUrlB    = json['licenciaTransitoUrlB'];
    identificacionUrlA      = json['identificacionUrlA'];
    identificacionUrlB      = json['identificacionUrlB'];
    licenciaConducirUrlA    = json['licenciaConducirUrlA'];
    licenciaConducirUrlB    = json['licenciaConducirUrlB'];
    verificado              = json['verificado'];
    estadoAprobacion        = json['estadoAprobacion'];
    tipoSangre              = json['tipoSangre'];
    SOATUrlA                = json['SOATUrlA'];
    SOATUrlB                = json['SOATUrlB'];
    minDataClient           = json['minDataClient'] ?? false;
    minDataDriver           = json['minDataDriver'] ?? false;
    isNew                   = json['isNew'] ?? false;
    conductorVerificado     = json['conductorVerificado'] ?? true;
    checkWork               = json['checkWork'] ?? false;
    minDataClientComplete   = json['minDataClientComplete'] ?? false;
    minDataDriverComplete   = json['minDataDriverComplete'] ?? false;
    minDataVehicleComplete  = json['minDataVehicleComplete'] ?? false;
    minDataDocumentComplete  = json['minDataDocumentComplete'] ?? false;
  }


   Map<String, dynamic> toJson() =>
       {
         'uid':   uid,
         'identificacion':    identificacion,
         'telefono':    telefono,
         'biografia':   biografia,
         'nombre':    nombre,
         'correo':    correo,
         'photoUrl':    photoUrl,
         'dateCreate':    dateCreate,
         'dateUpdate':    dateUpdate,
         'lastLogin':   lastLogin,
         'profileComplete':   profileComplete,
         'rol':   rol,
         'profileMinDataComplete':    profileMinDataComplete,
         'matriculaVehiculo':   matriculaVehiculo,
         'tipoVehiculo':    tipoVehiculo,
         'idTipoVehiculo':    idTipoVehiculo,
         'marcaVehiculo':   marcaVehiculo,
         'idMarcaVehiculo':   idMarcaVehiculo,
         'colorVehiculo':   colorVehiculo,
         'photoUrlCar':   photoUrlCar,
         'licenciaTransitoUrlA':    licenciaTransitoUrlA,
         'licenciaTransitoUrlB':    licenciaTransitoUrlB,
         'identificacionUrlA':    identificacionUrlA,
         'identificacionUrlB':    identificacionUrlB,
         'licenciaConducirUrlA':    licenciaConducirUrlA,
         'licenciaConducirUrlB':    licenciaConducirUrlB,
         'verificado':    verificado,
         'estadoAprobacion':    estadoAprobacion,
         'tipoSangre':    tipoSangre,
         'SOATUrlA':    SOATUrlA,
         'SOATUrlB':    SOATUrlB,
         'minDataClient': minDataClient,
         'minDataDriver': minDataDriver,
         'isNew':         isNew,
         'conductorVerificado': conductorVerificado,
         'checkWork': checkWork,
         'minDataClientComplete': minDataClientComplete,
         'minDataDriverComplete': minDataDriverComplete,
         'minDataVehicleComplete': minDataVehicleComplete,
         'minDataDocumentComplete': minDataDocumentComplete,
};

  //  o Matricula
//    Tipo Vehiculo (Que muestre las opciones Moto, Carro, Bicicleta)
//    Marca Vehiculo
//    Color Vehiculo

}
