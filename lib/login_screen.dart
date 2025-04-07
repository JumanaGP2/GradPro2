import 'package:flutter/material.dart';
  import 'login_page_v2.dart';
  // ignore: unused_import
  import 'sign_up_screen.dart';

  class LoginScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3891D6),
                Color(0xFF170557),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/shopping_bag.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                "JUST \n      STORE",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              
              CustomButton(
                text: "Login",
                highlight: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPageV2()),
                  );
                },
              ),

              const SizedBox(height: 20),

              
              CustomButton(
                text: "Sign up",
                highlight: true, 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  class CustomButton extends StatelessWidget {
    final String text;
    final VoidCallback onPressed;
    final bool highlight;

    const CustomButton({
      required this.text,
      required this.onPressed,
      this.highlight = false,
    });

    @override
    Widget build(BuildContext context) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (highlight && states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.2);
              }
              return null;
            },
          ),
          side: MaterialStateProperty.all(
            const BorderSide(color: Colors.white, width: 2),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
    }
  }