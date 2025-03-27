import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // مهم جداً
import 'splash_screen.dart';
// ignore: unused_import
import 'package:flutter_application_1/login_screen.dart';
// ignore: unused_import
import 'package:flutter_application_1/login_page_v2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ضروري قبل Firebase
  await Firebase.initializeApp(); // تهيئة Firebase
  print("✅ Firebase Connected Successfully");


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashScreen(), // أو LoginScreen() للتجربة
    );
  }
}
