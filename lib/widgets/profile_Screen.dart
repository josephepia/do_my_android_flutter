import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/widgets/card_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Profile extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {

    Size widthMedia = MediaQuery.of(context).size;
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    _fondoTop(context),
                    FutureBuilder(
                      future: userBloc.currentUser,
                      builder: (BuildContext contex,
                          AsyncSnapshot<FirebaseUser> snapshot) {
                        if (!snapshot.hasData || snapshot.hasError) {
                          print("haserror");
                          print(snapshot.error.toString());
                          return Center(
                            child: Text("error al cargar datos del usuario"),
                          );
                        } else {
                          return StreamBuilder(
                              stream:
                                  userBloc.myProfileDataOnline(snapshot.data.uid),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshop2) {
                                switch (snapshop2.connectionState) {
                                  case ConnectionState.waiting:
                                    return CircularProgressIndicator();
                                  case ConnectionState.none:
                                    return CircularProgressIndicator();
                                  case ConnectionState.done:
                                    var usuario = User(
                                        correo: snapshop2
                                                .data.snapshot.value['correo'] ??
                                            "completa este campo",
                                        nombre: snapshop2
                                            .data.snapshot.value['nombre'],
                                        photoUrl: snapshop2.data.snapshot
                                                .value['photoUrl'] ??
                                            '');
//
                                    return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 66.0,
                                          ),
                                          _avatar(usuario),
                                          SizedBox(
                                            height: 50.0,
                                          ),
                                          Flexible(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.all(16.0),
                                              child: Datos(usuario),
                                            ),
                                          ),
                                        ]);

                                  case ConnectionState.active:
                                    print("datos de user");
                                    print(snapshop2.data.snapshot.value['nombre']);
                                    print(snapshop2.data.snapshot.value['rol']);
//                        userBloc.getUser2(snapshop.data.uid).then((value) {});
                                    var usuario = User(
                                        correo: snapshop2.data.snapshot.value['correo'] ?? "completa este campo",
                                        nombre: snapshop2.data.snapshot.value['nombre'],
                                        photoUrl: snapshop2.data.snapshot.value['photoUrl'] ?? '',
                                        rol: snapshop2.data.snapshot.value['rol'] ?? '',
                                        uid: snapshot.data.uid,
                                        identificacion: snapshop2.data.snapshot.value['identificacion'],
                                        telefono: snapshop2.data.snapshot.value['telefono'],
                                        tipoSangre: snapshop2.data.snapshot.value['tipoSangre'],
                                        colorVehiculo: snapshop2.data.snapshot.value['colorVehiculo'],
                                        marcaVehiculo: snapshop2.data.snapshot.value['marcaVehiculo'],
                                        tipoVehiculo: snapshop2.data.snapshot.value['tipoVehiculo'],
                                        matriculaVehiculo: snapshop2.data.snapshot.value['matriculaVehiculo']


                                    );

//                                    var usuario = User.fromJsonMap(
//                                        snapshop2.data.snapshot.value()
//
//                                    );

                                    return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 200.0,
                                          ),
//                                          _avatar(usuario),

                                          CardProfile(height: 50,imageUrl: usuario.photoUrl, width: 100, usuario: usuario),
                                          SizedBox(
                                            height: 50.0,
                                          ),

                                          _vehiculo(context, usuario),
//                                          Row(
//                                            children: [
//                                              Padding(
//                                                padding:
//                                                    const EdgeInsets.all(10.0),
//                                                child: Chip(
//                                                  avatar: CircleAvatar(
//                                                    backgroundColor:
//                                                        Colors.grey.shade800,
//                                                    child: Text('AB'),
//                                                  ),
//                                                  label: Text('Aaron Burr'),
//                                                ),
//                                              )
//                                            ],
//                                          ),
//                                          SizedBox(height: 10.0,),
//                                          _datosPersonales(context,usuario),
//                                          Divider(),
//                                          _documentos(context,usuario),
//                                          Flexible(
//                                            child: Container(
//                                              width: MediaQuery.of(context)
//                                                  .size
//                                                  .width,
//                                              margin: EdgeInsets.symmetric(
//                                                  vertical: 10.0),
//                                              padding: EdgeInsets.all(16.0),
//                                              child: Datos(usuario),
//                                            ),
//                                          ),
                                        ]);
                                  default:
                                    return null;
                                }
                              });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            _buttonBack(context),
          ],
        )
//            ListView(
//              shrinkWrap: true,
//              children: [
//                Stack(
//                    children: [
//
//
//
//
//                      StreamBuilder(
//                          stream: userBloc.authStatus,
//
//                          builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshop){
//                            switch(snapshop.connectionState){
//                              case ConnectionState.waiting:
//                                return CircularProgressIndicator();
//                              case ConnectionState.none:
//                                return CircularProgressIndicator();
//                              case ConnectionState.done:
//
//                                var usuario = User(correo: snapshop.data.email ?? "Completa este campo",nombre: snapshop.data.displayName ?? "", photoUrl: snapshop.data.photoUrl ?? '');
//
//                                return Column(
//                                  mainAxisSize: MainAxisSize.min,
//                                    children: [
//                                      SizedBox(height: 100.0,),
//
//                                      Avatar(usuario: usuario),
//                                      SizedBox(height: 50.0,),
//
//                                      Flexible(
//                                        child: Container(
//                                          width: MediaQuery.of(context).size.width,
//                                          padding: EdgeInsets.all(16.0),
//                                          child: Datos(usuario),
//                                        ),
//                                      ),
//
//                                    ]
//
//                                );
//
//                              case ConnectionState.active:
//                               userBloc.getUser2(snapshop.data.uid).then((value){
//
//
//                               });
//                                var usuario = User(correo: snapshop.data.email ?? "completa este campo",nombre: snapshop.data.displayName, photoUrl: snapshop.data.photoUrl ?? '');
//
//                                userBloc.getUser2(snapshop.data.uid).then((value){
//                                  print('datos del usuario -> ${value}');
//
//                                });
//                                return Column(
//                                  mainAxisSize: MainAxisSize.min,
//                                    children: [
//                                      SizedBox(height: 100.0,),
//
//                                      Avatar(usuario: usuario),
//                                      SizedBox(height: 50.0,),
//                                      Flexible(
//                                        child: Container(
//                                          width: MediaQuery.of(context).size.width,
//                                          padding: EdgeInsets.all(16.0),
//                                          child: Datos(usuario),
//                                        ),
//                                      ),
//                                    ]
//
//                                );
//                              default:
//                                return null;
//                            }
//                          }
//
//                      ),
//
//
//
//                    ],
//                  ),
//              ],
//            )

        );
  }

  Widget _avatar(User usuario) {
    return Container(
      child: Column(
        children: [

          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(usuario.photoUrl), fit: BoxFit.cover)),
          ),
          Text(
            "${usuario.nombre}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buttonBack(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(top: 25.0, left: 5.0, right: 50.0, bottom: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0)),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(9, 46, 135, 1.0),
              Color.fromRGBO(58, 207, 227, 1.0),
            ], begin: Alignment(-2.0, 0.5), end: Alignment.centerRight)),
        child: SizedBox(
          width: 45.0,
          height: 45.0,
          child: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            color: Colors.white,
            onPressed: () {
              print("le di clic al boton  atras");
              Navigator.pop(context);
            },
          ),
        ));
  }

  Widget _fondoTop(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Color.fromRGBO(58, 207, 227, 1.0),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(size.width * 0.5),
              bottomLeft: Radius.circular(0))),
      child: Stack(
        alignment: Alignment(0, -1),
        children: [
          Container(
            height: 250.0,
            decoration: BoxDecoration(
                color: Color.fromRGBO(9, 46, 135, 1.0),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(size.width * 0.5),
                    bottomLeft: Radius.circular(size.width * 0.5))),
          ),
        ],
      ),
    );
  }

  Widget _datosPersonales(BuildContext context, User usuario){



    if(usuario.rol == "conductor"){
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "CC: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.identificacion ?? '')
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Nombre: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.nombre ?? '')
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Telefono: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.telefono ?? '')
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Tipo de sangre: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.tipoSangre ?? '')
                      ]),
                ),
              ],
            ),
            Divider(),

            SizedBox(height: 10.0,),
            Text("Vehiculo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",

            ),
            ),
            SizedBox(height: 10.0,),
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "No matricula: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.tipoSangre ?? '')
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Tipo: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.tipoSangre ?? '')
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(

              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Color: ",
                            style: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: usuario.tipoSangre ?? '')
                      ]),
                ),
              ],
            ),

          ],

        ),
      );
    }else{
      return Container();
    }

  }

  Widget _documentos(BuildContext context,User usuario){
    bool identificacion = false;
    bool fotografiaVehiculo = false;
    bool licencia = false;
    bool SOAT = false;
    bool editable = true;

    if(usuario.identificacionUrlA != null && usuario.identificacionUrlB != null){
      identificacion = true;
    }
    if(usuario.photoUrlCar != null ){
      fotografiaVehiculo = true;
    }
    if(usuario.licenciaConducirUrlA != null && usuario.licenciaConducirUrlB != null){
      licencia = true;
    }

    if(usuario.SOATUrlA != null && usuario.SOATUrlB != null){
      SOAT = true;
    }

    if(usuario.estadoAprobacion == "rechazado" || usuario.estadoAprobacion == "noiniciado" || usuario.SOATUrlA == null || usuario.SOATUrlB == null ){
      editable = true;
    }
    switch(usuario.estadoAprobacion){
      case "pendiente":

        return Column(
          children: [
            Row(
              children: [
                Text("Vehiculo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",

                  )
                )
              ],
            ),
            Row(
              children: [



                Text("Fotografia")
              ],
            )
          ],
        );
    break;
      case "aprobado":
        return Column(
          children: [
            Row(
              children: [
                Text("Vehiculo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",

                  ),
                ),
                Text("Fotografia")
              ],
            )
          ],
        );
        break;
      case "indefinido":
        return Column(
          children: [
            Row(
              children: [
                Text("Vehiculo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",

                  ),
                ),
                Text("Fotografia")
              ],
            )
          ],
        );

        break;
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Estado de la solicitud: ${usuario.estadoAprobacion ?? 'no iniciada'}",
              textAlign: TextAlign.center,

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",

              ),
            ),
            SizedBox(height: 10.0,),
            Text("Documentos cargados",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",

              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Datos personales",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",

                        ),
                      ),
                      ListTile(
                        title: Text("identificacion", style: TextStyle(
                            fontFamily: "Poppins"
                        ),
                        ),
                        trailing: identificacion ? Icon(Icons.check_circle, color: Colors.green,): Icon(Icons.check_circle, color: Colors.grey,),
                        dense: true,
                        onTap: editable ? (){
                            Navigator.pushNamed(context, 'uploadIdentificacion', arguments: usuario);
                        }: null,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Vehiculo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",

                        ),
                      ),
                      ListTile(
                        title: Text("Fotografia", style: TextStyle(
                            fontFamily: "Poppins"
                        ),
                        ),
                        trailing:  fotografiaVehiculo ? Icon(Icons.check_circle, color: Colors.green,): Icon(Icons.check_circle, color: Colors.grey,),
                        dense: true,
                        onTap: editable ? (){

                        }: null,
                      ),
                      ListTile(
                        title: Text("Licencia", style: TextStyle(
                            fontFamily: "Poppins"
                        ),
                        ),
                        trailing:  licencia ? Icon(Icons.check_circle, color: Colors.green,): Icon(Icons.check_circle, color: Colors.grey,),
                        dense: true,
                        onTap: editable ? (){

                        }: null,
                      ),
                      ListTile(
                        title: Text("SOAT", style: TextStyle(
                            fontFamily: "Poppins"
                        ),
                        ),
                        trailing:  SOAT ? Icon(Icons.check_circle, color: Colors.green,): Icon(Icons.check_circle, color: Colors.grey,),
                        dense: true,
                        onTap: editable ? (){

                        }: null,
                      ),
                    ],
                  ),
                ),
              ],
            ),



          ],
        );

        break;

    }
  }

  Widget _vehiculo(BuildContext context, User usuario){


    return Container(
      width: 310,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [BoxShadow(
          blurRadius: 20.0,
          color: Colors.black12,
          offset: Offset(0.0,0.7)
        )]
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
              children: [
                Text(
                    "Vehiculo",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold

                    )
                )
              ]
          ),
          SizedBox(height: 10.0,),
          Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        usuario.matriculaVehiculo ?? '',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold

                        )
                    ),
                    Text(
                        "Matricula",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          color: Colors.grey

                        )
                    ),

                  ]
                )

              ]
          ),
          Row(
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          usuario.marcaVehiculo ?? '',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold

                          )
                      ),
                      Text(
                          "Marca",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.grey

                          )
                      ),

                    ]
                )

              ]
          ),
          Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        usuario.colorVehiculo ?? '',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold

                        )
                    ),
                    Text(
                        "Color",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          color: Colors.grey

                        )
                    ),

                  ]
                )

              ]
          ),
          Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        usuario.tipoVehiculo ?? '',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold

                        )
                    ),
                    Text(
                        "Tipo",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          color: Colors.grey

                        )
                    ),

                  ]
                )

              ]
          ),

        ]
      )

    );


  }

  Widget _inscripcion(BuildContext context, User usuario){



  }
}

class Avatar extends StatelessWidget {
  User usuario;
  Avatar({this.usuario});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Hola, ${usuario.nombre}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(usuario.photoUrl), fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}

class Datos extends StatelessWidget {
  User usuario;

  Datos(this.usuario);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sobre mi",
                    style: TextStyle(
                        fontFamily: "Poppins", fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${usuario.biografia ?? ''}",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Datos personales",
                    style: TextStyle(
                        fontFamily: "Poppins", fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: "Poppins", color: Colors.black),
                        children: [
                          TextSpan(
                              text: "CC: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: usuario.identificacion ?? '')
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: "Poppins", color: Colors.black),
                        children: [
                          TextSpan(
                              text: "Correo: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: usuario.correo ?? 'sin definir')
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: "Poppins", color: Colors.black),
                        children: [
                          TextSpan(
                              text: "Telefono: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(9, 46, 135, 1.0),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: usuario.telefono ?? 'sin definir')
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class Calificacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("images/manPerfil.jpg"),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre del usuario",
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Color.fromRGBO(9, 46, 135, 1.0),
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.yellow,
                ),
              ],
            ),
            Text(
              "Opinion detallada hecha por un cliente",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ],
        )
      ],
    );
  }
}
