
import 'package:flutter/material.dart';
import 'package:gskfirebase1/provider/auth_provider.dart';
import 'package:gskfirebase1/router.dart';
import 'package:gskfirebase1/signup.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  String content = "ab";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<AuthProvider>(
          builder: (context , provider , x) {
            return Container(
              margin:const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      Center(child: Text('تسجيل الدخول' , style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),)),
                      const SizedBox(height: 30,),
                      Form(
                          key: provider.loginKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('يمكنك تسجيل الدخول من هنا ',  style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),) ,
                              const  SizedBox(height: 10,),
                              Text('يجب أن تكون كلمة المرور أكبر من 6 أحرف ',  style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),) ,
                              const  SizedBox(height: 10,),
                              TextFormField(
                                validator: provider.emailValidation,

                                controller: provider.emailController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.email),
                                  hintText: 'البريد الالكتروني',

                                ),
                                ),
                              const SizedBox(height: 15,),
                              TextFormField(
                                validator: provider.passwordVdalidation,
                                keyboardType: TextInputType.text,
                                controller: provider.passwordController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.password),
                                  hintText: 'كلمة المرور',

                                ),
                              ),


                            ],
                          ),
                      ),
                      const SizedBox(height: 100,),
                      Column(
                        children: [
                          ElevatedButton(onPressed: (){
                            provider.signIn();
                          }, child:const Text('تسجيل الدخول')),
                          const SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){
                            AppRouter.NavigateWithReplacemtnToWidget(SignupScreen());
                          }, child:const Text('تسجيل جديد')),
                          const SizedBox(height: 20,),
                          TextButton(onPressed: (){
                            provider.forgetPassword();
                          }, child:const Text('نسيت كلمة المرور'))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
