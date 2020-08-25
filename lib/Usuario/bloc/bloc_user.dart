import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
class UserBloc implements Bloc{
  final _auth_repository = AuthRepository();


  //Stream de firebase para la sesion

  Stream<FirebaseUser> streamFirebsae = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebsae;


  Future<FirebaseUser> signInGoogle() {
    return _auth_repository.signInFirebaseGoogle();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}