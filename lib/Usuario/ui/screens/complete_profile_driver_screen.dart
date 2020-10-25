import 'dart:io';

import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDriver extends StatefulWidget {
  User user;
  CompleteProfileDriver({Key key, this.user});
  @override
  _CompleteProfileDriverState createState() => _CompleteProfileDriverState();
}

class _CompleteProfileDriverState extends State<CompleteProfileDriver> {
  TextEditingController inputIdentificacion = TextEditingController();
  TextEditingController inputMatrcula= TextEditingController();
  TextEditingController inputColorVehiculo= TextEditingController();
  TextEditingController inputMarcaVehiculo= TextEditingController();
//  final piker = ImagePicker();
  Color colorPrimary = Color.fromRGBO(9, 46, 135, 1.0);

  GlobalKey formKey = GlobalKey<FormState>();

  File imagenPerfil;
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
//    user = ModalRoute.of(context).settings.arguments;
    print("iniciando completar perfil");
    print('datos del usuario que llega por parametro');
    print(widget.user.nombre);
    print("uid -> ");
    print(widget.user.uid);
    print(widget.user.telefono);
    print(widget.user.photoUrl);
    inputIdentificacion.text = widget.user.identificacion ?? "";
    inputMatrcula.text = widget.user.matriculaVehiculo ?? "";
    inputMarcaVehiculo.text = widget.user.marcaVehiculo ?? "";

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: StreamBuilder<Object>(
                        stream: userBloc.myProfileDataOnline(widget.user.uid),
                        builder: (context, AsyncSnapshot snapshot2) {

                          switch(snapshot2.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());

                              break;
                            case ConnectionState.none:
                              return Center(child: CircularProgressIndicator());

                              break;
                            case ConnectionState.active:
                              return Column(
                                children: [
                                  Container(
                                    width: 100.0,
                                    height: 100.0,

                                    margin: EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot2.data.snapshot.value["photoUrl"]),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        IconButton(onPressed: () async {

                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/perfil.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.photoUrl = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });


//                                  _seleccionarImagen(ImageSource.gallery);

//                                  piker.getImage(source: ImageSource.camera).then((value){
//                                    print("foto tomada");
//                                    print("datos de la foto");
//                                    print(value.toString());
//                                    print("-------");
//                                    print(value.path);
//                                  });


                                        },
                                          color: Color.fromRGBO(9, 46, 135, 1.0),
//                                  mini: true,



                                          icon: Icon(Icons.photo_camera, color: Colors.white,),

                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextFormField(
                                    controller: inputIdentificacion,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    onSaved: (value){
                                      widget.user.identificacion = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                        border: InputBorder.none,
                                        hintText: "Identificación",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: inputMatrcula,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
//                          inputFormatters: [
//                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
//                          ],
                                    onSaved: (value){
                                      widget.user.matriculaVehiculo = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                        border: InputBorder.none,
                                        hintText: "No matricula vehículo",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: inputMarcaVehiculo,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                                    ],
                                    onSaved: (value){
                                      widget.user.marcaVehiculo = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                        border: InputBorder.none,
                                        hintText: "Marca vehículo",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: inputColorVehiculo,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                                    ],
                                    onSaved: (value){
                                      widget.user.marcaVehiculo = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: colorPrimary),
                                        border: InputBorder.none,
                                        hintText: "Color vehículo",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Soportes",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimary
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Identificación",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("documentos/${userTemp.uid}/identifiacionA.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.identificacionUrlA = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                            image: widget.user.identificacionUrlA == null ?  null : DecorationImage(
                                              image: NetworkImage(widget.user.identificacionUrlA),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/identifiacionB.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.identificacionUrlB = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,
                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.identificacionUrlB == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.identificacionUrlB),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Licencia de tránsito",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                      var userTemp = await userBloc.currentUser;

                                      final _picker = ImagePicker();

                                      final pickedFile = await _picker.getImage(
                                      source: ImageSource.gallery,
                                      );



                                      if(pickedFile != null){
                                      imagenPerfil = File(pickedFile.path);
                                      }

                                      print("foto seleccionada");

                                      var exten= imagenPerfil.path.split(".").last;

                                      userBloc.uploadFile("imagenes/${userTemp.uid}/licenciaTransitoA.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                      storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                      snapchot.ref.getDownloadURL().then((urlImage){
                                      widget.user.licenciaTransitoUrlA = urlImage;
                                      userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                      });
                                      });
                                      }).catchError((onError){
                                      print("error al subir iamgen ${onError.toString()}");
                                      });
                                      },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.licenciaTransitoUrlA == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.licenciaTransitoUrlA),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/licenciaTransitoB.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.licenciaTransitoUrlB = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,
                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.licenciaTransitoUrlB == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.licenciaTransitoUrlB),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Foto de su vehículo",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/vehiculo.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.photoUrlCar = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.photoUrlCar == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.photoUrlCar),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Licencia de conducir",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/licenciaA.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.licenciaConducirUrlA = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.licenciaConducirUrlA == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.licenciaConducirUrlA),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/licenciaB.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.licenciaConducirUrlB = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,
                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.licenciaConducirUrlB == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.licenciaConducirUrlB),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "SOAT",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var userTemp = await userBloc.currentUser;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/soat.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                widget.user.SOATUrlA = urlImage;
                                                userBloc.updateUser(user: widget.user);

//                                                setState(() {
//
//                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });
                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ],
                                              image: widget.user.SOATUrlA == null ?  null : DecorationImage(
                                                  image: NetworkImage(widget.user.SOATUrlA),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),


                                ],
                              );
                              break;
                            case ConnectionState.done:
                              return Column(
                                children: [
                                  Container(
                                    width: 100.0,
                                    height: 100.0,

                                    margin: EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(widget.user.photoUrl),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        IconButton(onPressed: () async {

                                          var userTemp = await userBloc.currentUser;
//                                  File file;

                                          final _picker = ImagePicker();

                                          final pickedFile = await _picker.getImage(
                                            source: ImageSource.gallery,
                                          );



                                          if(pickedFile != null){
                                            imagenPerfil = File(pickedFile.path);
                                          }

                                          print("foto seleccionada");

                                          var exten= imagenPerfil.path.split(".").last;

                                          userBloc.uploadFile("imagenes/${userTemp.uid}/perfil.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                                            storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                                              snapchot.ref.getDownloadURL().then((urlImage){
                                                userBloc.updateUser(user: User(
                                                    uid: userTemp.uid,
                                                    photoUrl: urlImage
                                                ));

                                                setState(() {

                                                });
                                              });
                                            });
                                          }).catchError((onError){
                                            print("error al subir iamgen ${onError.toString()}");
                                          });


//                                  _seleccionarImagen(ImageSource.gallery);

//                                  piker.getImage(source: ImageSource.camera).then((value){
//                                    print("foto tomada");
//                                    print("datos de la foto");
//                                    print(value.toString());
//                                    print("-------");
//                                    print(value.path);
//                                  });


                                        },
                                          color: Color.fromRGBO(9, 46, 135, 1.0),
//                                  mini: true,



                                          icon: Icon(Icons.photo_camera, color: Colors.white,),

                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextFormField(
                                    controller: inputIdentificacion,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    onSaved: (value){
                                      widget.user.identificacion = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                        border: InputBorder.none,
                                        hintText: "Identificación",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: inputMatrcula,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
//                          inputFormatters: [
//                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
//                          ],
                                    onSaved: (value){
                                      widget.user.matriculaVehiculo = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                        border: InputBorder.none,
                                        hintText: "No matricula vehículo",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: inputMarcaVehiculo,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                                    ],
                                    onSaved: (value){
                                      widget.user.marcaVehiculo = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                                        border: InputBorder.none,
                                        hintText: "Marca vehículo",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: inputColorVehiculo,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                                    ],
                                    onSaved: (value){
                                      widget.user.marcaVehiculo = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty || value == "") {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                                        labelStyle:
                                        TextStyle(color: colorPrimary),
                                        border: InputBorder.none,
                                        hintText: "Color vehículo",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffF6F6F6)),
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Soportes",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimary
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Identificación",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,
                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Licencia de tránsito",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,
                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Foto de su vehículo",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Licencia de conducir",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,
                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "SOAT",
                                    style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Ink(
                                          height: 100.0,

                                          width: MediaQuery.of(context).size.width/2.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 20.0
                                                )
                                              ]
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),


                                ],
                              );
                              break;
                            default:
                              return null;
                          }


                        }
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
      )
    );
  }

  _seleccionarImagen(ImageSource origin, UserBloc userBloc) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: origin,
    );



    if(pickedFile != null){
      imagenPerfil = File(pickedFile.path);
    }

    print("foto seleccionada");

    setState(() {


    });
  }

  _guardarImagen(){

  }
}
