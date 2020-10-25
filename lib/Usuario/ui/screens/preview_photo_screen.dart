import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPhoto extends StatefulWidget {

  String pathOriginStorage;
  String pathDestinationStorage;
  String refDestinationDatabase;
  UserBloc userBloc;
//  User user;
//  String atributo;
  PreviewPhoto({Key key, this.pathDestinationStorage, this.pathOriginStorage, this.refDestinationDatabase, this.userBloc});

  @override
  _PreviewPhotoState createState() => _PreviewPhotoState();
}

class _PreviewPhotoState extends State<PreviewPhoto> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

//              Image.file(File(pathOrigin), fit: BoxFit.cover,),

//                    height: double.infinity,
                         Container(
//                             height: MediaQuery.of(context).size.height,
                             width: MediaQuery.of(context).size.width,
                             child: Image.file(File(widget.pathOriginStorage), fit: BoxFit.cover,)),
              FloatingActionButton(

                  backgroundColor: Colors.blue,
                  child: Icon(Icons.check),
                  onPressed: (){

    widget.userBloc.uploadFile(widget.pathDestinationStorage, File(widget.pathOriginStorage)).then((StorageUploadTask storageUpload){
                          storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
                            snapchot.ref.getDownloadURL().then((urlImage){
                              widget.userBloc.setDatabase(widget.refDestinationDatabase, urlImage.toString()).then((value) {

                                print("path in database update");

                                var count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 2;
                                });
                              });
                            });
                          });
                        }).catchError((onError){
                          print("error al subir iamgen ${onError.toString()}");
                        });


                  })







            ],
          ),
        )

    );
  }
}
