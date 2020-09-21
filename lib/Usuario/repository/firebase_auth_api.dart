import 'package:do_my/Usuario/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();
  AuthResult authResult;
  String verificationID;
  AuthCredential _phoneCredential;
  Future<AuthResult> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

     authResult = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken));


    return authResult;

  }

  Future<AuthResult> signInFacebook() async {
    print("login on facebook");
    await facebookLogin.logOut();

    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
         authResult = await _auth.signInWithCredential(
           FacebookAuthProvider.getCredential(accessToken: result.accessToken.token)
         );


        return authResult;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        return null;
        break;
    }

    return authResult;
//    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//    AuthResult authResult = await _auth.signInWithCredential(
//        GoogleAuthProvider.getCredential(accessToken: googleSignInAuthentication.accessToken));
//
//
//    return authResult;
  }

  Future<AuthResult> signInPhone(String codeSms) async {


    _phoneCredential =  PhoneAuthProvider.getCredential(verificationId: verificationID, smsCode: codeSms);
    authResult = await _auth.signInWithCredential(_phoneCredential);
    print("resultado -> ${authResult.toString()}");

    return authResult;
  }

  Future sendVerificarionPhone(String phoneNumber) async{

    print("numero telefonico que llega");
    print(phoneNumber);

    return await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (authCredential){


          print("verificacion completada credencial -> ${authCredential}");
          print("verificacion  credencial to string -> ${authCredential.toString()}");
          print("verificacion  credencial to string hashcode-> ${authCredential.hashCode}");
          print("verificacion  credencial to providerId -> ${authCredential.providerId}");
        },
        verificationFailed: (error){
          print("error al enviar verificacion de telefono -> ${error}");
          },
        codeSent: (String verificationId,[int forceResendingToken]){
              verificationID = verificationId;
              print("verifiaction id original -> $verificationId");
              print("verifiaction id guardado -> $verificationID");

        },
//        codeAutoRetrievalTimeout: codeAuto
    );
  }

  Future<FirebaseUser> signInFacebookold() async {



//
//    AuthResult authResult = await _auth.signInWithCredential(
//        GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken));
//    FirebaseUser user = authResult.user;

//    return user;
  }

   signOut() async {
     authResult = null;

     await facebookLogin.logOut();

     await _auth.signOut().then((value) => print("sesion cerrada"));
     await googleSignIn.signOut();
     await googleSignIn.disconnect();




    print("sesiones de google cerradas");

//    if(await facebookLogin.isLoggedIn){
//      facebookLogin.logOut();
//      print("sesion de facebook cerrada");
//    }else{
//      print("no existian sesiones de facebook biertas");
//    }

  }





}