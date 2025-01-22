import 'package:flutter/material.dart';
import 'package:vipra_lap/screen/bottom_navigation_screen/test_screen.dart';
import 'package:vipra_lap/screen/dashboard_screen.dart';
import 'package:vipra_lap/screen/start_screen/login_screen.dart';
import 'package:vipra_lap/screen/start_screen/signup_screen.dart';
import 'package:vipra_lap/screen/start_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginScreen()
    );
  }
}

