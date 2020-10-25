import 'dart:io';

import 'package:camera/camera.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/preview_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:path/path.dart' as pat;
import 'package:path_provider/path_provider.dart';

class CameraPreviewDomy extends StatefulWidget {

  CameraController cameraController;
  String filePath;
  User user;
  String pathOriginStorage;
  String pathDestinationStorage;
  String refDestinationDatabase;

  CameraPreviewDomy({Key key, this.cameraController, this.user, this.refDestinationDatabase, this.pathOriginStorage, this.pathDestinationStorage});

  @override
  _CameraPreviewDomyState createState() => _CameraPreviewDomyState();
}

class _CameraPreviewDomyState extends State<CameraPreviewDomy> {
  UserBloc userBloc;


  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);


    return Scaffold(

        body: SafeArea(
          child: _contenido(context,userBloc)
        ));
  }


  Widget _contenido(BuildContext context, UserBloc userBloc){
    if (!widget.cameraController.value.isInitialized) {
      return Container();
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
            aspectRatio:
            widget.cameraController.value.aspectRatio,
            child: CameraPreview(widget.cameraController)),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _captureControlRowWidget(),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      backgroundColor: Color.fromRGBO(9, 46, 135, 1.0),
                      child: Icon(Icons.camera),

                      onPressed: () async {
                        print("clic en tomar foto");
//                  widget.cameraController.takePicture(path)
                      try{
                        final pathOriginStorage = pat.join((await getTemporaryDirectory()).path,'${DateTime.now()}.jpg');

                        print("ruta de la imagen ");
                        print(pathOriginStorage);

                        await widget.cameraController.takePicture(pathOriginStorage);
//                        final File photo = File(pathOriginStorage);


                        Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewPhoto(pathOriginStorage: pathOriginStorage,pathDestinationStorage: widget.pathDestinationStorage, userBloc: userBloc, refDestinationDatabase: widget.refDestinationDatabase,)));
//                        userBloc.uploadFile("imagenes/${userTemp.uid}/licenciaTransitoA.${exten}", imagenPerfil).then((StorageUploadTask storageUpload){
//                          storageUpload.onComplete.then((StorageTaskSnapshot snapchot){
//                            snapchot.ref.getDownloadURL().then((urlImage){
//                              widget.user.licenciaTransitoUrlA = urlImage;
//                              userBloc.updateUser(user: widget.user);
//
////                                                setState(() {
////
////                                                });
//                            });
//                          });
//                        }).catchError((onError){
//                          print("error al subir iamgen ${onError.toString()}");
//                        });

                        print("foto tomada");

                      }catch(error){
                        print("error -> ${error.toString()}");
                      }



                      })
                ],),
            )
          ],
        ),

      ],
    );
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: widget.cameraController != null &&
              widget.cameraController.value.isInitialized &&
              !widget.cameraController.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),


      ],
    );
  }

  void showInSnackBar(String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  //------------
  Future<String> takePicture() async {
    if (widget.cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
//    final Directory extDir = await getApplicationDocumentsDirectory();
//    final String dirPath = '${extDir.path}/Pictures/flutter_test';
//    await Directory(dirPath).create(recursive: true);
    final String filePath = 'domy/foto.jpg';

    if (widget.cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await widget.cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }
  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');


  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          widget.filePath = filePath;
//          videoController?.dispose();
//          videoController = null;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }





  //-------------------

}
