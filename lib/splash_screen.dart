import 'dart:async';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'login_screen.dart'; // استيراد صفحة تسجيل الدخول
// ignore: unused_import
import 'login_page_v2.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // الانتقال إلى صفحة تسجيل الدخول بعد 6 ثوانٍ
    Timer(Duration(seconds: 6), () {
      if (mounted) { // التحقق من أن الـ Widget لا يزال في الشجرة
        //Navigator.of(context).pushReplacement(
         // MaterialPageRoute(builder: (context) => LoginScreen()), // التنقل إلى LoginScreen
        //);
        Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => LoginScreen()),


);

      }
    });

    // تهيئة تأثير Fade Animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3891D6), // الأزرق الفاتح من الأعلى
      Color(0xFF170557), // الأزرق الغامق من الأسفل
    ],
  ),
),

        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/shopping_bag.png', // تأكد من أن الصورة موجودة في مجلد assets
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
