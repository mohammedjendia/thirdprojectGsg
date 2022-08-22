import 'package:flutter/material.dart';
import 'package:gskfirebase1/home/category_widget.dart';
import 'package:gskfirebase1/product_screen/add_product_screen.dart';
import 'package:gskfirebase1/product_screen/product_widget.dart';
import 'package:gskfirebase1/router.dart';
import 'package:provider/provider.dart';

import '../provider/firestore_provider.dart';

class ProductsScreen extends StatelessWidget {
  String catId;
  ProductsScreen(this.catId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FirestoreProvider>(
          builder: (context, provider , x) {
            return
              provider.products.isEmpty?
              const Center(child : CircularProgressIndicator()):
              ListView.builder(

                itemCount:provider.products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: (){

                      },
                      child: ProductWidget(provider.products[index], catId));

                },);


          }
      ),
    );

  }
}
