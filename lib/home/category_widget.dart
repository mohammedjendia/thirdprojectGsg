
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gskfirebase1/home/updateCategory.dart';
import 'package:gskfirebase1/models/category.dart';
import 'package:gskfirebase1/provider/firestore_provider.dart';
import 'package:gskfirebase1/router.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  Category category ;
  CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return


           Consumer<FirestoreProvider>(
             builder: (context, provider , x) {
               return Column(
                 children: [
                   SingleChildScrollView(

                     scrollDirection: Axis.vertical,
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Column(
                         children: [

                           Container(
                               width: double.infinity,
                               height: 150,
                               child: Image(image: NetworkImage(category.imageUrl??''), fit: BoxFit.cover,),
                           ),
                           Text(category.name??'', style:const TextStyle(color: Colors.black ,fontSize: 30 ,  ),),
                           Center(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [

                               ElevatedButton(onPressed: (){
                                 provider.categoryNameController.text = category.name!;
                                 AppRouter.NavigateWithReplacemtnToWidget(UpdateCategory(category));
                               }, child: Text('update')),
                               ElevatedButton(onPressed: (){
                                provider.deleteCategory(category);
                               }, child: Text('delete')),
                             ],),
                           )


    ],
                       ),
                     ),
                   ),
                 ],
               );
             }
           );



  }
}
