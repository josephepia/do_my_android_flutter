import 'dart:convert';
import 'dart:developer';

import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/complete_profile_driver_screen.dart';
import 'package:do_my/Usuario/ui/screens/complete_profile_one_screen.dart';
import 'package:do_my/Usuario/ui/screens/login.dart';
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
                Map<String,dynamic> datos  = Map<String,dynamic>.from(snapshot.data.snapshot.value);
                final User user=User.fromJsonMap(datos);
                return _comprobarRol(user);
              }

              break;
            case ConnectionState.done:
              if (snapshot.hasError) PageError();
              if(!snapshot.hasData){
                return  Login();
              }else{
                Map<String,dynamic> datos  =  Map<String,dynamic>.from(snapshot.data.snapshot.value);
                final User user=User.fromJsonMap(datos);
                return _comprobarRol(user);
              }

          }
          return Container();
        });
  }

  Widget _comprobarRol(User user){

    if(user.isNew){
      return WorkWithUs(user: user);
    }

    if(!user.minDataClient){
      return CompleteProfileOne(user: user);
    }

    if(!user.minDataDriver){
      return CompleteProfileDriver();

    }

    print("datos de usuario construido con json");
    print(user.toJson().toString());
    return NavigationBar();


  }
}
