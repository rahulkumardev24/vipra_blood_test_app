import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/screen/dashboard_screen.dart';
import 'package:vipra_lap/screen/start_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Function to check if the user is already logged in
  void _checkLoginState() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      /// Check if a user is already logged in
      final User? user = FirebaseAuth.instance.currentUser;

      /// Navigate based on the login state
      if (user != null) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const DashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      print("Error checking login state: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Lottie Animation with fallback
            Lottie.asset(
              "assets/lottie/heart beat animation.json",
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 100,
                );
              },
            ),

            const SizedBox(height: 50),

            /// Animated Text
            SizedBox(
              height: 100,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.2, // Responsive font size
                  fontFamily: 'Third',
                  shadows: [
                    Shadow(color: AppColors.primaryColor, blurRadius: 9),
                  ],
                  color: Colors.red,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: const Duration(microseconds: 500),
                  animatedTexts: [
                    ScaleAnimatedText(
                      'Vipra',
                      duration: const Duration(milliseconds: 1300),
                    ),
                    ScaleAnimatedText(
                      'Lab',
                      duration: const Duration(milliseconds: 1300),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
