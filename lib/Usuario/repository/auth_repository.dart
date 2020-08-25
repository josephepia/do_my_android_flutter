import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_my/Usuario/repository/firebase_auth_repository.dart';

class AuthRepository{
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebaseGoogle() => _firebaseAuthAPI.signInGoogle();

}