
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gskfirebase1/data/storage_helper.dart';
import 'package:gskfirebase1/provider/auth_provider.dart';
import 'package:gskfirebase1/provider/firestore_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      SizedBox(height: 20,),
               TextField(controller: provider.categoryNameController,),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  provider.addNewCategory();
                  }, child:Text('Add New Category')),
                                ],
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
