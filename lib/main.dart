import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gskfirebase1/login_screen.dart';
import 'package:gskfirebase1/provider/auth_provider.dart';
import 'package:gskfirebase1/provider/firestore_provider.dart';
import 'package:gskfirebase1/router.dart';
import 'package:gskfirebase1/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(
    create: (context)=>AuthProvider()),

    ChangeNotifierProvider<FirestoreProvider>(
    create: (context)=>FirestoreProvider()),
    ],
      child: MaterialApp(
        navigatorKey: AppRouter.navKey,
       home: Builder(
       builder: (context) {
      return SplashScreen();
  }
),    ),
    );
  }
}
