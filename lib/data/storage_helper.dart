
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
 static StorageHelper storageHelper =StorageHelper();
 FirebaseStorage firebaseStorage = FirebaseStorage.instance;
 Future<String>uploadImage(File file)async{
  String fileName = file.path.split('/').last;
  Reference reference =  firebaseStorage.ref(fileName);
  TaskSnapshot taskSnapshot = await reference.putFile(file);
 String imageUrl = await reference.getDownloadURL();
 return imageUrl;

 }
}