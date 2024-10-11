import 'package:final_project1/pages/home_page.dart';
import 'package:final_project1/pages/intro_page.dart';
import 'package:final_project1/pages/login_page.dart';
import 'package:final_project1/pages/register_page.dart';
import 'package:final_project1/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:firebase_core/firebase_core.dart";


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDleSy0TD_g4Q24i9UdWgrZHE4uAqvQtys",
        appId: "1:183377188085:android:a604075cb836a0fe2ca1bc",
        messagingSenderId: "183377188085",
        projectId: "smart-home-9009c",
        databaseURL: "https://smart-home-9009c-default-rtdb.asia-southeast1.firebasedatabase.app"
      )
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FirebaseProvider()  ),
    ],
    child: MaterialApp(
      title: "final project 1",
      routes: {
        '/IntroPage': (context) => IntroPage(),
        '/HomePage': (context) => HomePage(),
        "/LoginPage": (context) => LoginPage(),
        "/RegisterPage": (context) => RegisterPage()
      },
      home: IntroPage(),
      debugShowCheckedModeBanner: false,

    ),
  ));
}
