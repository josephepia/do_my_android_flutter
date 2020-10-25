import 'dart:convert';
import 'dart:developer';

import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/complete_profile_driver_screen.dart';
import 'package:do_my/Usuario/ui/screens/complete_profile_client_screen.dart';
import 'package:do_my/Usuario/ui/screens/login.dart';
import 'package:do_my/Usuario/ui/screens/page_view_data_driver_screen.dart';
import 'package:do_my/Usuario/ui/screens/work_wth_us.dart';
import 'package:do_my/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/widgets/page_error.dart';

class Handler extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);


    return Scaffold(
      body: _comprobarSesion(userBloc, context),
    );


  }

  Widget _circularIndicator() => Center(child: CircularProgressIndicator());

  Widget _comprobarSesion(UserBloc userBloc, BuildContext context) {
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _circularIndicator();
                break;
              case ConnectionState.waiting:
                return _circularIndicator();
                break;
              case ConnectionState.active:

                if (snapshot.hasError) {

                  return PageError();
                }
                if(!snapshot.hasData){
                  return  Login();
                }else{
                  return _userDataRealTime(userBloc, context, snapshot.data);
                }

                break;
              case ConnectionState.done:
                if (snapshot.hasError) PageError();
                if(!snapshot.hasData){
                  return  Login();
                }else{
                  return _userDataRealTime(userBloc, context, snapshot.data);
                }

            }


          return null; // unreachable}
        });
  }

  Widget _userDataRealTime(
    UserBloc userBloc,
    BuildContext context,
      FirebaseUser user
  ) {
    return StreamBuilder(
        stream: userBloc.myProfileDataOnline(user.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _circularIndicator();
              break;
            case ConnectionState.waiting:
              return _circularIndicator();
              break;
            case ConnectionState.active:

              if (snapshot.hasError) {

                return PageError();
              }
              if(!snapshot.hasData){
                return  Login();
              }else{
                print("data snap ${jsonEncode(snapshot.data.snapshot.value)})");
                if(snapshot.data.snapshot.value != null){
                  Map<String,dynamic> datos  = Map<String,dynamic>.from(snapshot.data.snapshot.value);
                  final User user=User.fromJsonMap(datos);
                  return _comprobarRol(user);

                }else{
                  return PageError();
                }

              }

              break;
            case ConnectionState.done:
              if (snapshot.hasError) PageError();
              if(!snapshot.hasData){
                return  Login();
              }else{
                if(snapshot.data.snapshot.value != null){
                  Map<String,dynamic> datos  = Map<String,dynamic>.from(snapshot.data.snapshot.value);
                  final User user=User.fromJsonMap(datos);
                  return _comprobarRol(user);

                }else{
                  return PageError();
                }
              }

          }
          return Container();
        });
  }

  Widget _comprobarRol(User user){

    if(user.isNew){// loica para usuario nuevo
      print("soy usuario nuevo");
      if(user.checkWork ?? false){ // si ya ha respondido a la pregunta de trabaja con nosotros

        //ahora preguntamos que respondio la primera vez
        print("ya respondi si quiero trabajar con domy");

        if(user.rol == "conductor"){ //si hacarmado el check de trabaja con nosotros
          print("decidi ser conductor");

//          return CompleteProfileDriver(user: user);

        return PageViewDataDriver(user: user,);
        }else{ // decidio ser cliente
          print("decidi ser cliente ");

          //debemos preguntar si ya ha llenado este formulario de datos minimos

          if(user.minDataClientComplete?? false){// si ya ha completado los datos minimos se envia al home
            print("ya he completadd mi perfil como cliente");

            return NavigationBar();

          }else{ //si no ha completado los datos minimos como cliente se debe enviar a rellenarlo
            print("no he completado mi perfil como cliente");

            return CompleteProfileClient(user: user);

          }
        }

      }else{//nunca ha respondido a la pregunta de trabaja con nosotros
        print("aun no he respondido si quiero trabaajar con domy");

        return WorkWithUs(user: user);
      }

    }else{ // logica para usuario antiguo
      print("soy un usuario antiguo asi que estoy logueando el lugar de registrarme");
      return NavigationBar();
    }



  }
}
