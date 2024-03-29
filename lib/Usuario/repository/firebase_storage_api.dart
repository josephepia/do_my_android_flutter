


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageAPI {
  final StorageReference _storageReference = FirebaseStorage.instance.ref();


  Future<StorageUploadTask> uploadFile(String path, File file) async{

   return  _storageReference.child(path).putFile(file);
  }
}