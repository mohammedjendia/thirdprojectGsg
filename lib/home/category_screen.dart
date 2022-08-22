import 'package:flutter/material.dart';
import 'package:gskfirebase1/home/category_widget.dart';
import 'package:gskfirebase1/product_screen/add_product_screen.dart';
import 'package:gskfirebase1/product_screen/all_product_screen.dart';
import 'package:gskfirebase1/router.dart';
import 'package:provider/provider.dart';

import '../provider/firestore_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FirestoreProvider>(
          builder: (context, provider , x) {
            return
              provider.categories == null?
              const Center(child : CircularProgressIndicator()):
              ListView.builder(

                itemCount:provider.categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: (){
                          provider.getAllProducts(provider.categories[index].catId!);
                       AppRouter.NavigateToWidget(ProductsScreen(provider.categories[index].catId!));
                        },
                        child: CategoryWidget(provider.categories[index]));

            },);


          }
      ),
    );

  }
}
