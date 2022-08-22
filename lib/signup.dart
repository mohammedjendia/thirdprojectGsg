
import 'package:flutter/material.dart';
import 'package:gskfirebase1/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<AuthProvider>(
            builder: (context , provider , x) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Center(child: Text('تسجيل جديد' , style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),)),
                        SizedBox(height: 30,),
                        Form(
                          key: provider.signUpKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('يمكنك انشاء تسجيل جديد من هنا ',  style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),) ,
                              SizedBox(height: 10,),
                              Text('يجب أن تكون كلمة المرور أكبر من 6 أحرف ',  style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),) ,
                              SizedBox(height: 10,),
                              TextFormField(
                                validator: provider.emailValidation,
                                keyboardType: TextInputType.emailAddress,
                                controller: provider.emailController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.email),
                                  hintText: 'البريد الالكتروني',

                                ),
                              ),
                              SizedBox(height: 15,),
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
                        SizedBox(height: 100,),
                        Column(
                          children: [
                            ElevatedButton(onPressed: (){
                              provider.signup();
                            }, child: Text('تسجيل جديد'))
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
