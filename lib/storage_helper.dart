import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class StorageHelper {
  StorageHelper._();
  static StorageHelper storageHelper = StorageHelper._();
  FirebaseStorage firebaseStorge = FirebaseStorage.instance;
  Future<String>uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref = firebaseStorge.ref('images/$fileName');
    TaskSnapshot taskSnapshot = await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}
