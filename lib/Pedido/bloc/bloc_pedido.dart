import 'dart:async';

import 'package:do_my/Pedido/repository/firebase_database_api.dart';
import 'package:do_my/Pedido/repository/firebase_database_repository.dart';
import 'package:do_my/widgets/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class PedidoBloc implements Bloc{

  final _firebaseRepository = FirebaseDatabaseRepository();

  Stream serviciosSubscripcion = FirebaseDatabaseAPI().serviciosRef.orderByChild('prioridad').onValue;

  Stream get serviciosStream => serviciosSubscripcion;

  List<Servicio> buildServicios(DataSnapshot dataSnapshot) => FirebaseDatabaseAPI().buildServicios(dataSnapshot);
  FirebaseAnimatedList sortListServicios(ScrollController scrollController) => _firebaseRepository.sortListServicios(scrollController);
  @override
  void dispose() {

  }
}