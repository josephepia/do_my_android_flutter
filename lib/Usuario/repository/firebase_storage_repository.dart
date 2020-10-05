
import 'dart:io';

import 'package:do_my/Pedido/repository/firebase_database_api.dart';
import 'package:do_my/Usuario/repository/firebase_storage_api.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseSorageRepository{
  final _firebaseStorageAPI = FirebaseStorageAPI();

  Future<StorageUploadTask> uploadFile(String path, File file) => _firebaseStorageAPI.uploadFile(path, file);
}