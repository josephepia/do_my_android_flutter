import 'dart:io';

import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';

class UploadIdentificacion extends StatelessWidget {
  UserBloc userBloc ;
  User user;
  File imagenPerfil;


  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
     user = ModalRoute.of(context).settings.arguments;
    print('datos del usuario que llega por parametro');
    print(user.nombre);
    print("uid -> ");
    print(user.uid);
    print(user.telefono);
    print(user.photoUrl);
    return Scaffold(

      body: Center(
        child:  StreamBuilder(
          stream: userBloc.myProfileDataOnline(user.uid),
          builder: (context, AsyncSnapshot snapshot2) {

          switch(snapshot2.connectionState) {
          case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

          break;
          case ConnectionState.none:
          return Center(child: CircularProgressIndicator());

          break;
          case ConnectionState.active:
            return Row(
              children: [
                InkWell(
                  onTap: () async {
                    var userTemp = await userBloc.currentUser;

                    final _picker = ImagePicker();

                    final pickedFile = await _picker.getImage(
                      source: ImageSource.gallery,
                    );



                    if(pickedFile != null){
                      imagenPerfil = File(pickedFile.path);
                    }

                    print("foto seleccionada");

                    var exten= imagenPerfil.path.split(".").last;

                    userBloc.uploadFile("documentos/${userTemp.uid}/identifiacionA.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
                      storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                        snapchot.ref.getDownloadURL().then((urlImage){
                          user.identificacionUrlA = urlImage;
                          userBloc.updateUser(user: user);

//                                                setState(() {
//
//                                                });
                        });
                      });
                    }).catchError((onError){
                      print("error al subir iamgen ${onError.toString()}");
                    });
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
                        ],
                        image: user.identificacionUrlA == null ?  null : DecorationImage(
                            image: NetworkImage(user.identificacionUrlA),
                            fit: BoxFit.cover
                        )
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
            );
          break;
            default:

        return null;
        break;
          }

    },

        ),
      ),
    );
  }
}
