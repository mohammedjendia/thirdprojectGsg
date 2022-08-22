
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gskfirebase1/app_user.dart';
import 'package:gskfirebase1/models/category.dart';
import 'package:gskfirebase1/product_screen/product.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final String categoryCollectionName = 'categories';
  final String categoryCollectionNameUser = 'users';

  //
  // insertDummyDataInFirestore()async{
  //   firestoreInstance.collection(categoryCollectionName).add({
  //     'nameAr':'طعام',
  //     'nameEn':'Food',
  //     'imageUrl':"http://image.jpg",
  //   });
  // }
 Future<Category> addNewCategory(Category category)async{
   DocumentReference<Map<String, dynamic>> documentReference =  await firestoreInstance.collection(categoryCollectionName).add(category.toMap());
    category.catId=documentReference.id;
    return category;
  }
  Future<List<Category>>  getAllCategory()async{
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestoreInstance.collection(categoryCollectionName).get();

  // List<String> ids = querySnapshot.docs.map((e) {
//
//   return e.id;
//
// }).toList();
// log(ids.last.toString());
  List<Category> categories = querySnapshot.docs.map((e) {
    Category category =  Category.fromMap(e.data());
    category.catId =e.id;
    return category;

  }).toList();
    log(categories.length.toString());
  return categories ;
  }


  deleteCategory(Category category)async{
    await firestoreInstance.collection(categoryCollectionName).doc(category.catId).delete();

  }
  updateCategory(Category category)async{
    await firestoreInstance.collection(categoryCollectionName).doc(category.catId).update(category.toMap());

  }


//   addUserToFirebase(String userName , String email , String id , String phone)async{
//     firestoreInstance.collection(categoryCollectionNameUser).add({
//       'userName': userName,
//       'email':email,
//       'id':id,
//       'phone':phone,
//     });
//   }
//
//   getUserFromFirestore(String id)async{
//     DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//     await firestoreInstance.collection(categoryCollectionNameUser).doc(id).get();
//     Map<String, dynamic>? dataMap=  documentSnapshot.data();
//   }

  addUserToFirebase(AppUser appUser)async{
    await firestoreInstance.collection(categoryCollectionNameUser).doc(appUser.id).set(appUser.toMap());
  }

 Future<AppUser> getUserFromFirestore(String id)async{
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await firestoreInstance.collection(categoryCollectionNameUser).doc(id).get();
    Map<String, dynamic>? dataMap=  documentSnapshot.data();
return  AppUser.fromMap(documentSnapshot.data()!);
  }

 Future<Product> addNewProduct(Product product , String catId)async{
    DocumentReference<Map<String, dynamic>> documentReference =
    await  FirebaseFirestore.instance.collection(categoryCollectionName).doc(catId).collection('products')
        .add(product.toMap());
    product.id = documentReference.id;
    return product;
  }
  Future<List<Product>> getAllProduct(String catId)async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection(categoryCollectionName).doc(catId).collection('products').get();
 List<Product> products =  querySnapshot.docs.map((e) {
   Map<String , dynamic> data= e.data();
   data['id']= e.id;
   Product product = Product.fromMap(data);
   return product ;
 }).toList();
    return products;
 }
  updateProduct(Product product,String catId)async{
    await  FirebaseFirestore.instance.collection(categoryCollectionName).
    doc(catId).collection('products').doc(product.id).update(product.toMap());
  }
  deleteProduct(Product product,String catId)async{
    await FirebaseFirestore.instance.collection(categoryCollectionName).
    doc(catId).collection('products').doc(product.id).delete();
  }
}
