
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gskfirebase1/home/updateCategory.dart';
import 'package:gskfirebase1/product_screen/product.dart';
import 'package:gskfirebase1/provider/firestore_provider.dart';
import 'package:gskfirebase1/router.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product ;
  String catId;
  ProductWidget(this.product, this.catId );

  @override
  Widget build(BuildContext context) {
    return


      Consumer<FirestoreProvider>(
          builder: (context, provider , x) {
            return Column(
              children: [
                SingleChildScrollView(

                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [

                      Container(
                        width: double.infinity,
                        height: 150,
                        child: Image(image: NetworkImage(product.image??''), fit: BoxFit.cover,),
                      ),
                      Text(product.name??'', style:const TextStyle(color: Colors.black ,fontSize: 30 ,  ),),
                      Row(children: [
                        ElevatedButton(onPressed: (){
                          // provider.categoryNameController.text = product.name!;
                          // AppRouter.NavigateWithReplacemtnToWidget((product));
                        }, child: Text('update')),
                        ElevatedButton(onPressed: (){
                          provider.deleteProduct(product, catId);
                        }, child: Text('delete')),
                      ],)


                    ],
                  ),
                ),
              ],
            );
          }
      );



  }
}
