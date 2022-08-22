import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gskfirebase1/data/firestore_helper.dart';
import 'package:gskfirebase1/data/storage_helper.dart';
import 'package:gskfirebase1/models/category.dart';
import 'package:gskfirebase1/product_screen/product.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreProvider extends ChangeNotifier {

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();

  File? selectedImage;

  List<Category> categories = [];

  List<Product> products = [];

  FirestoreProvider() {
    getAllCategory();
  }

  // insertNewCategory(){
  //   FirestoreHelper.firestoreHelper.insertDummyDataInFirestore();
  // }
  selectImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xfile!.path);
  }

  addNewCategory() async {
    if (selectedImage != null) {
      String imageUrl = await StorageHelper.storageHelper.uploadImage(
          selectedImage!);
      Category category = Category(
          name: categoryNameController.text, imageUrl: imageUrl);
      Category newCategory = await FirestoreHelper.firestoreHelper
          .addNewCategory(category);
      selectedImage = null;
      categories.add(newCategory);
    }
  }

  getAllCategory() async {
    categories = await FirestoreHelper.firestoreHelper.getAllCategory();
    log(categories.length.toString());


    notifyListeners();
  }

  updateAllCategory(Category category) async {
    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(selectedImage!);
    }
    Category newCategory = Category(name: categoryNameController.text,
        imageUrl: imageUrl ?? category.imageUrl);
    newCategory.catId = category.catId;
    await FirestoreHelper.firestoreHelper.updateCategory(category);
    int index = categories.indexOf(categories
        .where((element) => element.catId == category.catId)
        .first);
    categories[index] = newCategory;
    notifyListeners();
  }

  deleteCategory(Category category) async {
    await FirestoreHelper.firestoreHelper.deleteCategory(category);
    categories.removeWhere((element) => element.catId == category.catId);
    notifyListeners();
  }

  getAllProducts(String catId) async {
    products = await FirestoreHelper.firestoreHelper.getAllProduct(catId);
    log(categories.length.toString());


    notifyListeners();
  }

  addNewProduct(String catId) async {
    if (selectedImage != null) {
      String imageUrl = await StorageHelper.storageHelper.uploadImage(
          selectedImage!);
      Product product = Product(
        name: productNameController.text,
        description: productDescController.text,
        price: num.parse(productPriceController.text),
        quantity: int.parse(productQuantityController.text),
        image: imageUrl,
      );
      Product newProduct = await FirestoreHelper.firestoreHelper.addNewProduct(
          product, catId);
      selectedImage = null;
      products.add(newProduct);
    }
  }

  updateAllProduct(Product product, String catId) async {
    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(selectedImage!);
    }
    Product newProduct =
    Product(name: productNameController.text,
      description: productDescController.text,
      price: num.parse(productPriceController.text),
      quantity: int.parse(productQuantityController.text),
      image: imageUrl ?? product.image,
    );
    newProduct.id = product.id;
    await FirestoreHelper.firestoreHelper.updateProduct(newProduct, catId);
    getAllProducts(catId);
  }

  deleteProduct(Product product , String catId)async{
    FirestoreHelper.firestoreHelper.deleteProduct(product, catId);
    getAllProducts(catId);
  }
}