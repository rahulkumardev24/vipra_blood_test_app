import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vipra_lap/screen/dashboard_screen.dart';

import '../../domain/colors.dart';
import '../../domain/utils/custom_text_style.dart';
import '../../service/auth_service.dart';
import '../../widgets/my_filled_button.dart';
import '../../widgets/my_icon_text_button.dart';
import '../../widgets/my_outline_button.dart';
import '../../widgets/my_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Image.asset(
                "assets/icons/appicon.png",
                height: 100,
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                  text: TextSpan(
                text: "Welcome",
                style: myTextStyle36(
                    fontColor: Colors.white, fontWeight: FontWeight.bold),
              )),
              Text(
                "Monitor your blood tests",
                style: myTextStyle18(fontColor: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    ///  UserName Controller
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Username",
                                style: myTextStyle24(
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        MyTextField(
                          textEditingController: userNameController,
                          filled: true,
                          borderColor: const Color(0xcd083f70),
                          filledColor: const Color(0xcd083f70),
                          borderRadius: 8,
                          prefixIcon: Icons.person,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    /// Email
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Email",
                                style: myTextStyle24(
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        MyTextField(
                          textEditingController: emailController,
                          filled: true,
                          borderColor: const Color(0xcd083f70),
                          filledColor: const Color(0xcd083f70),
                          borderRadius: 8,
                          prefixIcon: Icons.email_outlined,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    /// Password
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Password",
                                style: myTextStyle24(
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        MyTextField(
                          textEditingController: passwordController,
                          filled: true,
                          borderColor: const Color(0xcd083f70),
                          filledColor: const Color(0xcd083f70),
                          suffixIcon: Icons.remove_red_eye,
                          suffixIconOnPress: () {},
                          borderRadius: 8,
                          prefixIcon: Icons.lock,
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: MyFilledButton(
                            btnText: "Sign up",
                            btnTextColor: Colors.black,
                            textWeight: FontWeight.bold,
                            btnBackground:
                                AppColors.primaryLight.withOpacity(1),
                            borderRadius: 8,
                            onPressed: () {})),
                    const SizedBox(
                      height: 12,
                    ),
                    MyIconTextButton(
                      btnText: "Sign up with Google",
                      onPressed: () async {
                        try {
                          final user = await _authService.signInWithGoogle();
                          if (user != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("SignUp Failed : $error")));
                        }
                      },
                      btnTextColor: Colors.white,
                      btnBackground: AppColors.primaryLight.withOpacity(0.8),
                      textWeight: FontWeight.bold,
                      borderRadius: 8,
                      iconPath: "assets/images/google_icon.png",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
