import 'package:flutter/material.dart';
import 'package:gskfirebase1/data/auth_helper.dart';
import 'package:gskfirebase1/fireStore_helper_cate.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(child:const Text('test'), onPressed: (){
              AuthHelper.authHelper.signUp('mhmed@gmail.com', 'password');
              },),
            ElevatedButton(child:const Text('add'), onPressed: (){
              },
            )
          ],
        ),
      ),
    );
  }
}
