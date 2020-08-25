import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/widgets/boton_inicio_facebook.dart';
import 'package:do_my/widgets/boton_inicio_telefono.dart';
import 'package:do_my/widgets/gradiente.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:do_my/widgets/boton_inicio_google.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login();
  }

}

class _Login extends State<Login>{

  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of(context);

    // TODO: implement build
    return login();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError){
          return login();
        }else{
          return null;
        }
      },
    );
  }

  Widget login(){
    return Scaffold(

      body: Stack(
        alignment: Alignment.center,
        children: [
          Gradiente(
              colorPrimario: Color.fromRGBO(58, 207, 227, 1.0),
              colorSecundario: Color.fromRGBO(9, 46, 135, 1.0)
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("images/logoBlanco.svg",
              height: 80,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Inicia sesión o registrate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
              BotonInicioTelefono(
                  onPressed: (){},
                  alto: 40,ancho: 248,
                  text: "Telefono",

              ),
              BotonInicioGoogle(
                  onPressed: (){
                    userBloc.signInGoogle().then((FirebaseUser user) {
                      print("el usuario es ${user.displayName}");
                    });
                  },
                  alto: 40,ancho: 248
                  ,text: "Google",
              ),
              BotonInicioFacebook(
                  onPressed: (){},
                  alto: 40,ancho: 248,
                  text: "Facebook",
              ),

            ],
          )
        ],
      ),
    );
  }
  
}