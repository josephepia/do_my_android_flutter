import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/repository/firebase_database_api.dart';
import 'package:do_my/Usuario/repository/firebase_database_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
class UserBloc implements Bloc{
  final _auth_repository = AuthRepository();
  final _database_repository = FirebaseDatabaseRepository();



  //Stream de firebase para la sesion

  Stream<FirebaseUser> streamFirebsae = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebsae;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  Stream myProfileDataOnline(String uid) => FirebaseDatabaseAPI().userRef.child(uid).onValue;

  Future<User> getUser(String uid) => _database_repository.getUser(uid);
  Future<User> myProfileOnce(String uid) => _database_repository.myProfileOnce(uid);
  Stream myProfileOnce2(String uid) => _database_repository.myProfileOnce2(uid);
//  Stream streamUser = _database_repository.streamUser

  User buildUser(DataSnapshot snapShot) => _database_repository.buildUser(snapShot);

  Future<AuthResult> signIn({Key key,@required ProviderAuth providerAuth, String codeSms}) {
    return _auth_repository.signInFirebase(providerAuth: providerAuth,codeSms: codeSms);
  }




//  Future<User> getUser() async{
//    var dataUser = await FirebaseAuth.instance.currentUser();
//
//    return await FirebaseDatabaseAPI().userRef.orderByKey().equalTo(dataUser.uid).limitToFirst(1).once().then((value) {
//        print("datos de user -> ${value.value}");
//    });
//  }

  Future<User> getUser2(uid) async{


    return await FirebaseDatabaseAPI().userRef.orderByKey().equalTo(uid).limitToFirst(1).once().then((value) {
      print("datos de user -> ${value.value}");
    });
  }

  getStatus() async{
    var status = await FacebookLogin().isLoggedIn;

    print('estatus de login facebook -> ${status}');
  }

  signOut() async{
    await _auth_repository.singOut();
  }

  saveUser(User user) => _database_repository.saveUserFirebase(user);

  Future updateUser({User user, bool checkConductor}) => _database_repository.updateUserFirebase(user: user,checkConductor: checkConductor);
  lastLoginUser(User user) => _database_repository.lastLoginUserFirebase(user);
  Future sendVerificarionPhone(String phoneNumber) => _auth_repository.sendVerificarionPhone(phoneNumber);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}