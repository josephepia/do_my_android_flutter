import 'package:camera/camera.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/camera_preview_screen.dart';
import 'package:flutter/material.dart';


class CompleteSupportDataDriver extends StatefulWidget {
  User user;
  GlobalKey formKey = GlobalKey<FormState>();

  CameraController cameraController ;
  CompleteSupportDataDriver({Key key, this.user, this.formKey, this.cameraController });

  @override
  _CompleteSupportDataDriverState createState() => _CompleteSupportDataDriverState();
}

class _CompleteSupportDataDriverState extends State<CompleteSupportDataDriver> {

  Color colorPrimary = Colors.blue;
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
                            "Adjuntar documentos",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            ),
                          ),
                        ),
//
                        Text(
                          "Foto de su vehículo",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/documentos/photoUrlCar.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/photoUrlCar";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );
                              },
                              child: Ink(
                                height: 100.0,
                                width: MediaQuery.of(context).size.width /
                                    2.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0)
                                    ],
                                    image: widget.user.photoUrlCar == null
                                        ? null
                                        : DecorationImage(
                                        image: NetworkImage(
                                            widget.user.photoUrlCar),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Identificación",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/documentos/identificacionUrlA.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/identificacionUrlA";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );

                              },
                              child: Ink(
                                height: 100.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0)
                                    ],
                                    image:
                                    widget.user.identificacionUrlA ==
                                        null
                                        ? null
                                        : DecorationImage(
                                        image: NetworkImage(widget
                                            .user
                                            .identificacionUrlA),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/documentos/identificacionUrlB.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/identificacionUrlB";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );

                              },
                              child: Ink(
                                height: 100.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0)
                                    ],
                                    image:
                                    widget.user.identificacionUrlB ==
                                        null
                                        ? null
                                        : DecorationImage(
                                        image: NetworkImage(widget
                                            .user
                                            .identificacionUrlB),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Licencia de conducir",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/documentos/licenciaConducirUrlA.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/licenciaConducirUrlA";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );

                              },
                              child: Ink(
                                height: 100.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0)
                                    ],
                                    image: widget.user
                                        .licenciaConducirUrlA ==
                                        null
                                        ? null
                                        : DecorationImage(
                                        image: NetworkImage(widget
                                            .user
                                            .licenciaConducirUrlA),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/documentos/licenciaConducirUrlB.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/licenciaConducirUrlB";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );

                              },
                              child: Ink(
                                height: 100.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0)
                                    ],
                                    image: widget.user
                                        .licenciaConducirUrlB ==
                                        null
                                        ? null
                                        : DecorationImage(
                                        image: NetworkImage(widget
                                            .user
                                            .licenciaConducirUrlB),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        SizedBox(
                          height: 10.0,
                        ),


                        Text(
                          "SOAT",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/documentos/SOATUrlA.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/SOATUrlA";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );

                              },
                              child: Ink(
                                height: 100.0,
                                width: MediaQuery.of(context).size.width /
                                    2.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0)
                                    ],
                                    image: widget.user.SOATUrlA == null
                                        ? null
                                        : DecorationImage(
                                        image: NetworkImage(
                                            widget.user.SOATUrlA),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ],
                        ),
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
