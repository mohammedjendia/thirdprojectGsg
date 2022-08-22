
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gskfirebase1/data/storage_helper.dart';
import 'package:gskfirebase1/provider/auth_provider.dart';
import 'package:gskfirebase1/provider/firestore_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewProduct extends StatelessWidget {
String catId ;
NewProduct(this.catId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Provider.of<AuthProvider>(context, listen: false).signOut();
            }, icon:const Icon(Icons.logout)),
          ],
        ),
        body: Consumer<FirestoreProvider>(
            builder: (context , provider ,x) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          provider.selectImage();
                        },
                        child:
                        provider.selectedImage==null?
                        Container(
                          child: Text('Load image'),



                        ) :
                        Container(
                          width: 150,
                          height: 150,
                          child: Image(image:
                          FileImage(provider.selectedImage!),
                          ),
                        ),
                      ),

                      const  SizedBox(height: 20,),
                      TextField(controller: provider.productNameController,),
                      const SizedBox(height: 10,),
                      TextField(controller: provider.productDescController,),
                      const SizedBox(height: 10,),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: provider.productPriceController,),
                      const SizedBox(height: 10,),
                        TextField(
                        keyboardType: TextInputType.number,
                        controller: provider.productQuantityController,),

                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        provider.addNewProduct(catId);
                      }, child:Text('Add New Product')),
                    ],
                  ),
                ),
              );
            }
        )


      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //        Text('Home Screen'),
      //        ElevatedButton(onPressed: (){
      //          Provider.of<FirestoreProvider>(context , listen: false).insertNewCategory();
      //        }, child:Text('Add New Category')),
      //       SizedBox(height: 20,),
      //       ElevatedButton(onPressed: ()async{
      //         XFile? xfile = await  ImagePicker().pickImage(source: ImageSource.gallery);
      //       String url = await  StorageHelper.storageHelper.uploadImage(File(xfile!.path));
      //       log(url);
      //       }, child:Text('Add New photo')),
      //     ],
      //   ),
      // ),
    );
  }
}
