import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_my/Usuario/repository/firebase_auth_api.dart';
import 'package:flutter/cupertino.dart';


enum ProviderAuth{
  google,
  facebook,
  phone
}
class AuthRepository{


  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<AuthResult> signInFirebaseGoogle() => _firebaseAuthAPI.signInGoogle();
  Future<AuthResult> signInFirebase({@required ProviderAuth providerAuth, String codeSms}){
    switch(providerAuth){

      case ProviderAuth.google:

        return _firebaseAuthAPI.signInGoogle();
        break;
      case ProviderAuth.facebook:
        return _firebaseAuthAPI.signInFacebook();

        break;
      case ProviderAuth.phone:
        return _firebaseAuthAPI.signInPhone(codeSms);

        break;
      default:
        break;

    }
  }

  Future sendVerificarionPhone(String phoneNumber) => _firebaseAuthAPI.sendVerificarionPhone(phoneNumber);


  singOut()async => await _firebaseAuthAPI.signOut();
}