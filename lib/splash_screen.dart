
import 'package:flutter/material.dart';
import 'package:gskfirebase1/data/auth_helper.dart';
import 'package:gskfirebase1/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateFun() async{
    await Future.delayed(const Duration(seconds: 3));
   Provider.of<AuthProvider>(context,listen: false).checkUser();

  }

  @override
  Widget build(BuildContext context) {
    navigateFun();
    return Scaffold(
      body: Center(

        child:Image.network('http://5dmat-web.com/storage/playlists/December2016/YeSOZ7m2vmZZR4MT87wG.jpg'),
      ),
    );
  }
}
