import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2100), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: const DashboardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Lottie Animation
            Lottie.asset(
              "assets/lottie/heart beat animation.json",
            ),

            SizedBox(
              height: 100,
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 80.0,
                    fontFamily: 'Third',
                    shadows: [
                      Shadow(color: AppColors.primaryColor, blurRadius: 9)
                    ],
                    color: Colors.red),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: const Duration(microseconds: 500),
                  animatedTexts: [
                    ScaleAnimatedText('Vipra',
                        duration: const Duration(milliseconds: 1300)),
                    ScaleAnimatedText('Lab',
                        duration: const Duration(milliseconds: 1300)),
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
