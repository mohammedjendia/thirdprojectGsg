

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gskfirebase1/home/category_screen.dart';
import 'package:gskfirebase1/home/home_screen.dart';
import 'package:gskfirebase1/login_screen.dart';
import 'package:gskfirebase1/signup.dart';

import '../router.dart';

class AuthHelper{
  AuthHelper._();
 static AuthHelper authHelper = AuthHelper._();
 FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

Future<UserCredential?> signIn(String email , String password)async{
  try {
   final credential = await firebaseAuthInstance.signInWithEmailAndPassword(
       email: email,
       password: password
   );
   return credential ;
  } on FirebaseAuthException catch (e) {
   if (e.code == 'user-not-found') {
    print('No user found for that email.');
   } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
   }
  }
 }

  Future<UserCredential?> signUp(String emailAddress, String password) async {
   try {
    UserCredential credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: emailAddress,
     password: password,
    );

    return credential;

   } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
     print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
     print('The account already exists for that email.');
    }
    return null;

   } catch (e) {
    print(e);
    return null;
   }
  }



  checkUser()async{
  User? user = firebaseAuthInstance.currentUser;
  if(user == null){
   AppRouter.NavigateWithReplacemtnToWidget(LoginScreen());//login
  }else{
   AppRouter.NavigateWithReplacemtnToWidget(const CategoryScreen());//home

       }
   }
  User? getUserState(){
   User? user = auth.currentUser;
   return user;
  }





  signOut() {
   auth.signOut();
   AppRouter.NavigateWithReplacemtnToWidget(SignupScreen());

  }
  forgetPassword(String email)async{
 try {
   await firebaseAuthInstance.sendPasswordResetEmail(email: email);
   return 'تم إرسال كلمة المرور';
 } on Exception catch (e) {
   // TODO
 }
  }
}