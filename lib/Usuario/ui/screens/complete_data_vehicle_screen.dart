import 'package:camera/camera.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/camera_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompleteDataVehicle extends StatefulWidget {
  User user;
  GlobalKey formKey = GlobalKey<FormState>();

  CameraController cameraController ;
  CompleteDataVehicle({Key key, this.user, this.formKey, this.cameraController });

  @override
  _CompleteDataVehicleState createState() =>
      _CompleteDataVehicleState();
}

class _CompleteDataVehicleState extends State<CompleteDataVehicle> {
  TextEditingController inputIdentificacion = TextEditingController();
  TextEditingController inputMatrcula= TextEditingController();
  TextEditingController inputColorVehiculo= TextEditingController();
  TextEditingController inputMarcaVehiculo= TextEditingController();
//  final piker = ImagePicker();
  Color colorPrimary = Color.fromRGBO(9, 46, 135, 1.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: widget.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Datos del vehiculo",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                            ),
                          ),
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget.user.photoUrlCar == null ) ? AssetImage('images/taxi.png') : NetworkImage(widget.user.photoUrlCar),
                                  
//
                                  fit: BoxFit.cover)
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              FloatingActionButton(
                                  mini: true,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Color.fromRGBO(9, 46, 135, 1.0),
                                  onPressed: (){
                                    print("clic en cambiar  foto ");
                                    final pathDestinationStorage = "imagenes/${widget.user.uid}/vehiculo/vehiculo.jpg";
                                    final refDestinationDatabase = "usuarios/${widget.user.uid}/photoUrlCar";
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                    );

                                  }),

                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Row(

                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text("Tipo", style: TextStyle(
                                  fontFamily: "Poppins"
                              ),
                              textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        DropdownButtonFormField(
                          value: widget.user.tipoVehiculo,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF6F6F6),
//                labelText: "Tipo",
//                          labelText: "Tipo",
//                              hintText: "tipo",
//                          helperText: "tipo",
//                              helperStyle: TextStyle(),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0)),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.circular(10),
                              )),

                          items: [
                            DropdownMenuItem(value: null, child: Text("Seleccione", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "automovil", child: Text("Automovil", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "motocicleta", child: Text("Motocicleta", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "bicicleta", child: Text("Bicicleta", style: TextStyle(fontFamily: "Poppins", ),)),

                          ],
                          onChanged: (String newValue) {
                            setState(() {
//                          dropdownValue = newValue;
                              FocusScope.of(context).requestFocus(new FocusNode());
                              widget.user.tipoVehiculo = newValue;
                            });
                          },
                          onSaved: (value) {
                            widget.user.tipoVehiculo = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value == "" ) {
                              return 'Seleccione una opcion';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: inputMatrcula,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
                          onSaved: (value) {
                            widget.user.matriculaVehiculo = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == "") {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                          style: TextStyle(fontFamily: "Poppins"),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0)),
                              border: InputBorder.none,
                              hintText: "Matricula",
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
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
//                          inputFormatters: [
//                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
//                          ],
                          onSaved: (value) {
                            widget.user.marcaVehiculo = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == "") {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                          style: TextStyle(fontFamily: "Poppins"),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0)),
                              border: InputBorder.none,
                              hintText: "Marca",
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
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
                          onSaved: (value) {
                            widget.user.colorVehiculo = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == "") {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                          style: TextStyle(fontFamily: "Poppins"),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0)),
                              border: InputBorder.none,
                              hintText: "Color",
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),

//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        TextFormField(
//                          controller: inputMarcaVehiculo,
//                          maxLines: 1,
//                          keyboardType: TextInputType.text,
//                          inputFormatters: [
//                            FilteringTextInputFormatter.allow(
//                                RegExp(r"[a-zA-Z]+|\s"))
//                          ],
//                          onSaved: (value) {
//                            widget.user.marcaVehiculo = value;
//                          },
//                          validator: (value) {
//                            if (value.isEmpty || value == "") {
//                              return 'Este campo es obligatorio';
//                            }
//                            return null;
//                          },
//                          style: TextStyle(fontFamily: "Poppins"),
//                          decoration: InputDecoration(
//                              filled: true,
//                              fillColor: Color(0xffF6F6F6),
////                labelText: "numero telefonico",
//                              labelStyle: TextStyle(
//                                  color: Color.fromRGBO(9, 46, 135, 1.0)),
//                              border: InputBorder.none,
//                              hintText: "Marca vehículo",
//                              enabledBorder: OutlineInputBorder(
//                                borderSide:
//                                BorderSide(color: Color(0xffF6F6F6)),
//                                borderRadius: BorderRadius.circular(10),
//                              ),
//                              focusedBorder: OutlineInputBorder(
//                                borderSide:
//                                BorderSide(color: Color(0xffF6F6F6)),
//                                borderRadius: BorderRadius.circular(10),
//                              )),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        TextFormField(
//                          controller: inputColorVehiculo,
//                          maxLines: 1,
//                          keyboardType: TextInputType.text,
//                          inputFormatters: [
//                            FilteringTextInputFormatter.allow(
//                                RegExp(r"[a-zA-Z]+|\s"))
//                          ],
//                          onSaved: (value) {
//                            widget.user.marcaVehiculo = value;
//                          },
//                          validator: (value) {
//                            if (value.isEmpty || value == "") {
//                              return 'Este campo es obligatorio';
//                            }
//                            return null;
//                          },
//                          style: TextStyle(fontFamily: "Poppins"),
//                          decoration: InputDecoration(
//                              filled: true,
//                              fillColor: Color(0xffF6F6F6),
////                labelText: "numero telefonico",
//                              labelStyle: TextStyle(color: colorPrimary),
//                              border: InputBorder.none,
//                              hintText: "Color vehículo",
//                              enabledBorder: OutlineInputBorder(
//                                borderSide:
//                                BorderSide(color: Color(0xffF6F6F6)),
//                                borderRadius: BorderRadius.circular(10),
//                              ),
//                              focusedBorder: OutlineInputBorder(
//                                borderSide:
//                                BorderSide(color: Color(0xffF6F6F6)),
//                                borderRadius: BorderRadius.circular(10),
//                              )),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          "Soportes",
//                          style: TextStyle(
//                              fontFamily: "Poppins",
//                              fontSize: 20.0,
//                              fontWeight: FontWeight.bold,
//                              color: colorPrimary),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          "Identificación",
//                          style: TextStyle(fontFamily: "Poppins"),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Row(
//                          children: [
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "documentos/${userTemp.uid}/identifiacionA.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.identificacionUrlA =
////                                          urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image:
//                                    widget.user.identificacionUrlA ==
//                                        null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(widget
//                                            .user
//                                            .identificacionUrlA),
//                                        fit: BoxFit.cover)),
//                              ),
//                            ),
//                            Spacer(),
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/identifiacionB.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.identificacionUrlB =
////                                          urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image:
//                                    widget.user.identificacionUrlB ==
//                                        null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(widget
//                                            .user
//                                            .identificacionUrlB),
//                                        fit: BoxFit.cover)),
//                              ),
//                            )
//                          ],
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          "Licencia de tránsito",
//                          style: TextStyle(fontFamily: "Poppins"),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Row(
//                          children: [
//                            InkWell(
//                              onTap: () async {
////
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/licenciaTransitoA.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.licenciaTransitoUrlA =
////                                          urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image: widget.user
//                                        .licenciaTransitoUrlA ==
//                                        null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(widget
//                                            .user
//                                            .licenciaTransitoUrlA),
//                                        fit: BoxFit.cover)),
//                              ),
//                            ),
//                            Spacer(),
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/licenciaTransitoB.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.licenciaTransitoUrlB =
////                                          urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image: widget.user
//                                        .licenciaTransitoUrlB ==
//                                        null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(widget
//                                            .user
//                                            .licenciaTransitoUrlB),
//                                        fit: BoxFit.cover)),
//                              ),
//                            )
//                          ],
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          "Foto de su vehículo",
//                          style: TextStyle(fontFamily: "Poppins"),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/vehiculo.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.photoUrlCar = urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image: widget.user.photoUrlCar == null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(
//                                            widget.user.photoUrlCar),
//                                        fit: BoxFit.cover)),
//                              ),
//                            ),
//                          ],
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          "Licencia de conducir",
//                          style: TextStyle(fontFamily: "Poppins"),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Row(
//                          children: [
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/licenciaA.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.licenciaConducirUrlA =
////                                          urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image: widget.user
//                                        .licenciaConducirUrlA ==
//                                        null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(widget
//                                            .user
//                                            .licenciaConducirUrlA),
//                                        fit: BoxFit.cover)),
//                              ),
//                            ),
//                            Spacer(),
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/licenciaB.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.licenciaConducirUrlB =
////                                          urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image: widget.user
//                                        .licenciaConducirUrlB ==
//                                        null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(widget
//                                            .user
//                                            .licenciaConducirUrlB),
//                                        fit: BoxFit.cover)),
//                              ),
//                            )
//                          ],
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          "SOAT",
//                          style: TextStyle(fontFamily: "Poppins"),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            InkWell(
//                              onTap: () async {
////                            var userTemp = await userBloc.currentUser;
////
////                            final _picker = ImagePicker();
////
////                            final pickedFile = await _picker.getImage(
////                              source: ImageSource.gallery,
////                            );
////
////                            if (pickedFile != null) {
////                              imagenPerfil = File(pickedFile.path);
////                            }
////
////                            print("foto seleccionada");
////
////                            var exten =
////                                imagenPerfil.path.split(".").last;
////
////                            userBloc
////                                .uploadFile(
////                                "imagenes/${userTemp.uid}/soat.${exten}",
////                                imagenPerfil)
////                                .then((StorageUploadTask
////                            storageUpload) {
////                              storageUpload.onComplete.then(
////                                      (StorageTaskSnapshot snapchot) {
////                                    snapchot.ref
////                                        .getDownloadURL()
////                                        .then((urlImage) {
////                                      widget.user.SOATUrlA = urlImage;
////                                      userBloc.updateUser(
////                                          user: widget.user);
////
//////                                                setState(() {
//////
//////                                                });
////                                    });
////                                  });
////                            }).catchError((onError) {
////                              print(
////                                  "error al subir iamgen ${onError.toString()}");
////                            });
//                              },
//                              child: Ink(
//                                height: 100.0,
//                                width: MediaQuery.of(context).size.width /
//                                    2.5,
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(10.0),
//                                    color: Colors.white,
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Colors.black12,
//                                          blurRadius: 20.0)
//                                    ],
//                                    image: widget.user.SOATUrlA == null
//                                        ? null
//                                        : DecorationImage(
//                                        image: NetworkImage(
//                                            widget.user.SOATUrlA),
//                                        fit: BoxFit.cover)),
//                              ),
//                            ),
//                          ],
//                        ),
                      ],
                    )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
