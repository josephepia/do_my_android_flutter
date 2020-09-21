import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Profile extends StatelessWidget {

  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    double widthMedia = MediaQuery.of(context).size.width;
    double heightMedia = MediaQuery.of(context).size.height;
    userBloc = UserBloc();
    return Scaffold(

        body:
            Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(58, 207, 227, 1.0),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(widthMedia/2), bottomLeft: Radius.circular(0))
                    ),
                    child: Stack(
                      alignment: Alignment(0, -1),
                      children: [
                        Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(9, 46, 135, 1.0),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(widthMedia/2), bottomLeft: Radius.circular(widthMedia/2))
                          ),
                        ),

                      ],
                    ),
                  ),



                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child:

                    StreamBuilder(
                        stream: userBloc.authStatus,

                        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshop){
                          switch(snapshop.connectionState){
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            case ConnectionState.none:
                              return CircularProgressIndicator();
                            case ConnectionState.done:

                              var usuario = User(correo: snapshop.data.email ?? "Completa este campo",nombre: snapshop.data.displayName ?? "", photoUrl: snapshop.data.photoUrl ?? '');

                              return Column(
                                  children: [
                                    SizedBox(height: 100.0,),

                                    Avatar(usuario: usuario),
                                    SizedBox(height: 50.0,),

                                    Flexible(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(16.0),
                                        child: Datos(usuario),
                                      ),
                                    ),

                                  ]

                              );

                            case ConnectionState.active:
                             userBloc.getUser2(snapshop.data.uid).then((value){


                             });
                              var usuario = User(correo: snapshop.data.email ?? "completa este campo",nombre: snapshop.data.displayName, photoUrl: snapshop.data.photoUrl ?? '');

                              userBloc.getUser2(snapshop.data.uid).then((value){
                                print('datos del usuario -> ${value}');

                              });
                              return Column(
                                  children: [
                                    SizedBox(height: 100.0,),

                                    Avatar(usuario: usuario),
                                    SizedBox(height: 50.0,),
                                    Flexible(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(16.0),
                                        child: Datos(usuario),
                                      ),
                                    ),
                                  ]

                              );
                            default:
                              return null;
                          }
                        }

                    ),
                  ),

                   Container(
                     padding: EdgeInsets.only(top: 25.0, left: 5.0),
                     child: SizedBox(
                       width: 45.0,
                       height: 45.0,
                       child: IconButton(
                         icon: Icon(Icons.keyboard_backspace),
                         color: Colors.white,
                         onPressed: (){
                           print("le di clic al boton ");
                         },
                       ),
                     )


                    )

                ],
              )

            );


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
          Text("Hola, ${usuario.nombre}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),

          ),
          Container(
            width: 100.0,
            height: 100.0,

            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(usuario.photoUrl),
                    fit: BoxFit.cover
                )
            ),
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
                  Text("Sobre mi", style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700
                  ),),
                  Text("Hola, un gusto poder servirte, espero ofrecerte un buen servicio, para lo que necesite no dudes en contactarme, que tengas un agradable día ", style: TextStyle(
                      fontFamily: "Poppins",
                  ),)
                ],
              ),
            )
          ],
        ),
        Divider(),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Datos personales", style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700
                  ),),
                  SizedBox(height: 4,),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(text:"CC: ", style: TextStyle(
                          color: Color.fromRGBO(9, 46, 135, 1.0),
                          fontWeight: FontWeight.bold
                        )),
                        TextSpan(text: usuario.identificacion ?? 'sin definir')
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black
                        ),
                        children: [
                          TextSpan(text:"Correo: ", style: TextStyle(
                              color: Color.fromRGBO(9, 46, 135, 1.0),
                              fontWeight: FontWeight.bold
                          )),
                          TextSpan(text: usuario.correo ?? 'sin definir')
                        ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black
                        ),
                        children: [
                          TextSpan(text:"Telefono: ", style: TextStyle(
                              color: Color.fromRGBO(9, 46, 135, 1.0),
                              fontWeight: FontWeight.bold
                          )),
                          TextSpan(text: usuario.telefono ?? 'sin definir')
                        ]
                    ),
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
                      fit: BoxFit.cover
                  )
              ),
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
                fontWeight: FontWeight.bold
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.star, size: 18, color: Colors.yellow,),
                Icon(Icons.star, size: 18, color: Colors.yellow,),
                Icon(Icons.star, size: 18, color: Colors.yellow,),
                Icon(Icons.star, size: 18, color: Colors.yellow,),

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

