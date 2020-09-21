import 'package:do_my/Usuario/ui/screens/complete_profile_one_screen.dart';
import 'package:do_my/Usuario/ui/screens/send_number_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
import 'package:do_my/widgets/boton_inicio_facebook.dart';
import 'package:do_my/widgets/boton_inicio_telefono.dart';
import 'package:do_my/widgets/gradiente.dart';
import 'package:do_my/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  TextEditingController phonController;
  @override
  Widget build(BuildContext context) {
    phonController = TextEditingController();
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshotOne)  {
        print("iniciando bloc firebase user login");
//        print()
        if(!snapshotOne.hasData || snapshotOne.hasError){
          print("haserror");
          print(snapshotOne.error.toString());
          return LoginContent();
        }else{
          return StreamBuilder(
            stream: userBloc.myProfileDataOnline(snapshotOne.data.uid),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData || snapshot.hasError){
                print("haserror de myprofileDataonline");
                print(snapshot.error.toString());
                return LoginContent();

              }else{
//                snapshot.data.snapshot.value['profileComplete']
                User user = userBloc.buildUser(snapshot.data.snapshot);

                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                    break;
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());

                    break;
                  case ConnectionState.active:


                    if(user.profileMinDataComplete ?? false){
                      print("usuario con perfil completado ");
                      return NavigationBar();

                    }else{
                      print('usuario con perfil incompleto');
                      return CompleteProfileOne(user: user);
                    }
                    break;
                  case ConnectionState.done:
                    print("datos de snapchot done");
                    print(snapshot.data.snapshot.value.toString());

                    if(user.profileComplete){
                      print("usuario con perfil completado ");
                      return NavigationBar();

                    }else{
                      print('usuario con perfil incompleto');
                      return CompleteProfileOne();
                    }
                    break;
                  default:
                    return Center(child: CircularProgressIndicator());

                    break;
                }

              }
            },
          );
//          return NavigationBar();

         return LoginContent();
        }
      },
    );
  }





  
}
class LoginContent extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc  = BlocProvider.of(context);
    return Scaffold(

      body: Stack(
        alignment: Alignment.center,
        children: [
//          Gradiente(
//              colorPrimario: Color.fromRGBO(58, 207, 227, 1.0),
//              colorSecundario: Color.fromRGBO(9, 46, 135, 1.0)
//          ),
          Container(
            color: Color.fromRGBO(9, 46, 135, 1.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              SvgPicture.asset("images/logoBlanco.png",
//              height: 80,
//              ),

              Container(
                height: 90,
                child: Image.asset("images/LogoBlancoOut.png"),
              ),
//              Container(
//
//                margin: EdgeInsets.all(15.0),
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                        image: AssetImage("images/logoBlanco.png"),
//                        fit: BoxFit.cover
//                    )
//                ),
//              ),
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
              ButtonLoginPhone(),

//              TextField(
//                controller: phonController,
//              ),

//              RaisedButton(
//              child: Text("verificar codigo"),
//                  onPressed: (){
////  print("codigo escrito en el input ${phonController.text}");
////                    userBloc.signIn(providerAuth: ProviderAuth.phone,codeSms: phonController.text).then((authResult) {
////                      print("datos de usuario");
////                      print(authResult.toString());
////                      print("es nuevo usuario -> ${authResult.additionalUserInfo.isNewUser}");
////
////                      var user =  userModel.User(
////                        uid: authResult.user.uid,
////                        nombre: authResult.user.displayName,
////                        correo: authResult.user.email,
////                        photoUrl: authResult.user.photoUrl,
//////                          dateCreate: ServerValue.timestamp
////                      );
////                      if(authResult.additionalUserInfo.isNewUser){
////
////                        userBloc.saveUser(user);
////                      }else{
////                        userBloc.lastLoginUser(user);
////                      }
////                    });
//
//              }),
              BotonInicioGoogle(
                onPressed: () async{
//                   await userBloc.signOut();
                  await userBloc.signIn(providerAuth: ProviderAuth.google).then((authResult) {
                    print("datos de usuario");
                    print(authResult.toString());
                    print("es nuevo usuario -> ${authResult.additionalUserInfo.isNewUser}");

                    print(authResult.user.email);
                    print(authResult.user.displayName);
                    print(authResult.user.photoUrl);
                    print(authResult.user.photoUrl);
                    print(authResult.user.uid);
                    var user =  User(
                      uid: authResult.user.uid,
                      nombre: authResult.user.displayName,
                      correo: authResult.user.email,
                      photoUrl: authResult.user.photoUrl,
//                          dateCreate: ServerValue.timestamp
                    );
                    if(authResult.additionalUserInfo.isNewUser){

                      userBloc.saveUser(user);
                    }else{
                      userBloc.lastLoginUser(user);
                    }
                  });
                },
                height: 40,width: 248
                ,text: "Google",
              ),
              BotonInicioFacebook(
                alto: 40,ancho: 248,
                text: "Facebook",
                onPressed: (){
                    userBloc.signOut();
                  userBloc.signIn(providerAuth: ProviderAuth.facebook).then((authResult) {
                    print("datos de usuario");
                    print(authResult.toString());
                    print("es nuevo usuario -> ${authResult.additionalUserInfo.isNewUser}");
                    var user =  User(
                      uid: authResult.user.uid,
                      nombre: authResult.user.displayName,
                      correo: authResult.user.email,
                      photoUrl: authResult.user.photoUrl,
                      //                          dateCreate: ServerValue.timestamp
                    );
                    if(authResult.additionalUserInfo.isNewUser){

                      userBloc.saveUser(user);
                    }else{
                      userBloc.lastLoginUser(user);

                    }
                  });
                },
              ),

            ],
          )
        ],
      ),
    );;
  }
}

class ButtonLoginPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotonInicioTelefono(
    onPressed: (){
      print("apunto de llamar a la navegacion de pantalla");
//      MaterialPageRoute(builder: (context) => SendNumberPhone());
      Navigator.of(context).pushNamed('/phoneLogin');

      print('se ejecuto el llamado de pantalla');
      },
    alto: 40,ancho: 248,
    text: "Telefono",

    );
  }
}

