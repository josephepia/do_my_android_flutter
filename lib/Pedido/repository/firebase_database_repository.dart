
import 'package:do_my/Pedido/repository/firebase_database_api.dart';
import 'package:do_my/Pedido/ui/widgets/card_servicio_widget.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/widgets/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

class FirebaseDatabaseRepository {
  final _firebaseAPI = FirebaseDatabaseAPI();

//  updateUserFirebase(User user) => _firebaseAPI.updateUser(user);
//  saveUserFirebase(User user) => _firebaseAPI.saveUser(user);

  List<CardServicio> buildServicios(DataSnapshot dataSnapshot) => _firebaseAPI.buildServicios(dataSnapshot);
  FirebaseAnimatedList sortListServicios(ScrollController scrollController) => _firebaseAPI.sortListServicios(scrollController);
}