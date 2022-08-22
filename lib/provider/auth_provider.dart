import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gskfirebase1/app_user.dart';
import 'package:gskfirebase1/data/firestore_helper.dart';
import 'package:gskfirebase1/home/home_screen.dart';
import 'package:gskfirebase1/router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';
import '../data/auth_helper.dart';
import '../product_screen/product.dart';


class AuthProvider with ChangeNotifier {
   GlobalKey<FormState> loginKey = GlobalKey();
   GlobalKey<FormState> signUpKey = GlobalKey();
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController userNameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController cityController = TextEditingController();
  User? user;
   List<Product>? allProducts;

   String? nullValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field shouldn\'t be done';
    }
  }
   String? emailValidation(value) {
    if (!isEmail(value)) {
      return 'صيغة ايميل خاطئة';
    }
  }
   String? passwordVdalidation(value){
    if (value.length < 6){
      return 'يجب أن تكون كلمة المرور أكبر من 6 خانات على الاقل';
    }
  }

  signIn() async {
    if(loginKey.currentState!.validate()) {
      UserCredential? credentials = await  AuthHelper.authHelper.signIn(
          emailController.text, passwordController.text);
      if(credentials!= null){
        AppRouter.NavigateWithReplacemtnToWidget(HomeScreen());
      }
    }
    notifyListeners();
  }
   signup() async {
     if(signUpKey.currentState!.validate()) {
       UserCredential? credentials = await  AuthHelper.authHelper.signUp(
           emailController.text, passwordController.text);
       if(credentials!= null){
         AppRouter.NavigateWithReplacemtnToWidget(HomeScreen());
       }
     }
     notifyListeners();
   }
   // signUap(String emailAddress, String password, String userName) async {
   //   UserCredential? user =
   //   await AuthHelper.authHelper.signUp(emailAddress, password);
   //
   //   print(user);
   //   if (user != null) {
   //     print('in != null');
   //     await FirestoreHelper.firestoreHelper
   //         .addNewUserToFirestore(userName, emailAddress, user.user!.uid);
   //   }
   // }
  signOut() async {
    AuthHelper.authHelper.signOut();
    notifyListeners();
  }

  getUserState() {
    user = AuthHelper.authHelper.getUserState();
    notifyListeners();
  }

  checkUser() async {
    AuthHelper.authHelper.checkUser();
  }
  Future<String> uploadImage(var StorageHelper) async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    String x = await StorageHelper.storageHelper.uploadImage(File(xFile!.path));
    return x;
  }

  forgetPassword(){
     AuthHelper.authHelper.forgetPassword('mhmed98614010@gmail.com');
  }

   ///////////////////////// fireStore
   register()async{
     UserCredential? userCredential = await AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
     AppUser appUser = AppUser(userName: userNameController.text, email: emailController.text,
         phone: phoneController.text, city: cityController.text,
     id: userCredential!.user!.uid);
     FirestoreHelper.firestoreHelper.addUserToFirebase(appUser);
   }
//////////////////////////////////////////////
//    addProduct() async {
//      String imageUrl =
//      await FirestoreHelper.firestoreHelper.uploadImage(this.file);
//      Product product = Product(
//          name: nameController.text,
//          description: descriptionController.text,
//          price: num.parse(priceController.text));
//      product.imageUrl = imageUrl;
//      await FirestoreHelper.firestoreHelper.addNewProduct(product);
//      getAllProducts();
//      Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context)
//          .pop();
//    }
//
//    editProduct(String productiD) async {
//      log(productiD ?? 'null');
//      if (file != null) {
//        this.imageUrl =
//        await FirestoreHelper.firestoreHelper.uploadImage(this.file);
//      }
//      Product product = Product(
//          id: productiD,
//          name: nameController.text,
//          description: descriptionController.text,
//          price: num.parse(priceController.text));
//      product.imageUrl = imageUrl;
//      await FirestoreHelper.firestoreHelper.editProduct(product);
//      getAllProducts();
//      Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context)
//          .pop();
//    }
//
//    goToEditProduct(Product product) {
//      this.file = null;
//      this.nameController.text = product.name;
//      this.descriptionController.text = product.description;
//      this.priceController.text = product.price.toString();
//      this.imageUrl = product.imageUrl;
//      notifyListeners();
//      RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddNewProduct(
//        isForEdit: true,
//        productId: product.id,
//      ));
//    }
//
//    getAllProducts() async {
//      this.allProducts = await FirestoreHelper.firestoreHelper.getAllProducts();
//      notifyListeners();
//    }
//
//    deleteProduct(String productiD) async {
//      await FirestoreHelper.firestoreHelper.deleteProruct(productiD);
//      getAllProducts();
//    }
// }
// Footer


}
