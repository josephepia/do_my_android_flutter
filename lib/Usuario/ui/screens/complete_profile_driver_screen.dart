import 'dart:io';

import 'package:do_my/Usuario/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDriver extends StatefulWidget {
  @override
  _CompleteProfileDriverState createState() => _CompleteProfileDriverState();
}

class _CompleteProfileDriverState extends State<CompleteProfileDriver> {
  TextEditingController inputIdentificacion;
  TextEditingController inputMatrcula;
  TextEditingController inputColorVehiculo;
  TextEditingController inputMarcaVehiculo;
  final piker = ImagePicker();
  Color colorPrimary = Color.fromRGBO(9, 46, 135, 1.0);
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    print("iniciando completar perfil");
    print('datos del usuario que llega por parametro');
    print(user.nombre);
    print(user.telefono);
    print(user.photoUrl);
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(

                      child: Column(
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,

                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(user.photoUrl),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                FloatingActionButton(onPressed: (){
                                  File file;

                                  piker.getImage(source: ImageSource.camera).then((value){
                                    print("foto tomada");
                                    print("datos de la foto");
                                    print(value.toString());
                                    print("-------");
                                    print(value.path);
                                  });


                                },
                                  mini: true,
                                  backgroundColor: Color.fromRGBO(9, 46, 135, 1.0),

                                  child: IconButton(
                                  icon: Icon(Icons.photo_camera, color: Colors.white,),
                                ),
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
                              user.identificacion = value;
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
                              user.matriculaVehiculo = value;
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
                              user.marcaVehiculo = value;
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
                              user.marcaVehiculo = value;
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
}
