
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/repository/firebase_database_api.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseRepository {
  final _firebaseAPI = FirebaseDatabaseAPI();

  Future updateUserFirebase({User user,bool checkConductor}) => _firebaseAPI.updateUser(user: user, checkConductor: checkConductor);
  saveUserFirebase(User user) => _firebaseAPI.saveUser(user);
  lastLoginUserFirebase(User user) => _firebaseAPI.lastLoginUser(user);
  Future<User> getUser(String uid) => _firebaseAPI.getUser(uid);
  Future<User> myProfileOnce(String uid) => _firebaseAPI.myProfileOnce(uid);
  Stream myProfileOnce2(String uid) => _firebaseAPI.myProfileOnce2(uid);

  User buildUser(DataSnapshot snapShot) => _firebaseAPI.buildUser(snapShot);

  Future updateDatabaseMap(String ref, Map<String, dynamic> datos) => _firebaseAPI.updateDatabaseMap(ref, datos);
  Future updateDatabaseMapRoot(Map<String, dynamic> datos) => _firebaseAPI.updateDatabaseMapRoot(datos);
  Future setDatabase(String ref, dynamic datos) => _firebaseAPI.setDatabase(ref, datos);
}