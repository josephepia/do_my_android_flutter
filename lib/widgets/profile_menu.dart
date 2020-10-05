import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/widgets/profile_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileMenu extends StatelessWidget {
  UserBloc userBloc;
  User usuario;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    bool _switch = false;

    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 50,
          child: Image.asset("images/LogoSecundario.png"),
        ),
        FutureBuilder(
            future: userBloc.currentUser,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshop) {
              switch (snapshop.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()));
                case ConnectionState.none:
                  return Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()));
                case ConnectionState.done:
                  print(
                      "datos de snap => ${snapshop.data.email} con conexion -> ${snapshop.connectionState}");

                  usuario = User(
                      correo: snapshop.data.email ?? "",
                      nombre: snapshop.data.displayName,
                      photoUrl: snapshop.data.photoUrl ?? '');
                  return _profile(userBloc);

                case ConnectionState.active:
                  print(
                      "datos de snap => ${snapshop.data.email} con conexion -> ${snapshop.connectionState}");

                  usuario = User(
                      correo: snapshop.data.email ?? "",
                      nombre: snapshop.data.displayName,
                      photoUrl: snapshop.data.photoUrl ?? '');
                  return _profile(userBloc);
                default:
                  return null;
              }
            }),
        SizedBox(
          height: 10,
        ),
        Container(padding: EdgeInsets.only(left: 16, right: 16), child: Modo()),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50.0,
        ),
        _listMenu(context, userBloc)
      ],
    ));
  }

  Widget _profile(UserBloc userBloc){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(

                  "Hola ${this.usuario.nombre}",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.0,
                      color: Color.fromRGBO(9, 46, 135, 1.0),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
//                    image: AssetImage("images/manPerfil.jpg"),
                    image: NetworkImage(usuario.photoUrl ?? ""),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }

  Widget _listMenu(BuildContext context, UserBloc userBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'Perfil',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.close),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          onTap: () {
            StreamBuilder(
              stream: userBloc.signOut(),
              builder: (context, snapshot) {
                print("clic en cerrar sesion");
              },
            );
          },
        ),
//        ListTile(
//          leading: Icon(Icons.photo_album),
//          title: Text('Album',
//            style: TextStyle(
//                fontFamily: "Poppins"
//            ),),
//        ),
//        ListTile(
//          leading: Icon(Icons.phone),
//          title: Text('Phone',
//            style: TextStyle(
//                fontFamily: "Poppins"
//            ),),
//        ),
        Divider(),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Do-my",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(
            'Contactenos',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text(
            'Compartir',
            style: TextStyle(fontFamily: "Poppins"),
          ),
        ),
        Divider(),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Legal",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ),
        ListTile(
          leading: Icon(Icons.security),
          title: Text(
            'Privacidad',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.gavel),
          title: Text(
            'Terminos y condiciones',
            style: TextStyle(fontFamily: "Poppins"),
          ),
        ),
      ],
    );
  }
}

class Modo extends StatefulWidget {
  bool _switch = false;

  @override
  _Modo createState() => _Modo();
}

class _Modo extends State<Modo> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        "Modo (Conductor)",
        style: TextStyle(fontFamily: "Poppins"),
      ),
      onChanged: (bool value) {
        print("estado ${value}");
        setState(() {
          widget._switch = value;
        });
      },
      value: widget._switch,
    );
  }
}

class ListMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc blocUser = BlocProvider.of(context);
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'Datos Personales',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.close),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          onTap: () {
            StreamBuilder(
              stream: blocUser.signOut(),
              builder: (context, snapshot) {
                print("clic en cerrar sesion");
              },
            );
          },
        ),
//        ListTile(
//          leading: Icon(Icons.photo_album),
//          title: Text('Album',
//            style: TextStyle(
//                fontFamily: "Poppins"
//            ),),
//        ),
//        ListTile(
//          leading: Icon(Icons.phone),
//          title: Text('Phone',
//            style: TextStyle(
//                fontFamily: "Poppins"
//            ),),
//        ),
        Divider(),
        SizedBox(
          height: 8,
        ),
        Text(
          "Do-my",
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(
            'Contactenos',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text(
            'Compartir',
            style: TextStyle(fontFamily: "Poppins"),
          ),
        ),
        Divider(),
        SizedBox(
          height: 8,
        ),
        Text(
          "Legal",
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),
        ),
        ListTile(
          leading: Icon(Icons.security),
          title: Text(
            'Privacidad',
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.gavel),
          title: Text(
            'Terminos y condiciones',
            style: TextStyle(fontFamily: "Poppins"),
          ),
        ),
      ],
    );
    ;
  }
}

class Avatar extends StatelessWidget {
  User usuario;
  Avatar({Key key, @required this.usuario});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Hola, ${this.usuario.nombre}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.0,
                color: Color.fromRGBO(9, 46, 135, 1.0),
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
//                    image: AssetImage("images/manPerfil.jpg"),
                    image: NetworkImage(usuario.photoUrl ?? ""),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
