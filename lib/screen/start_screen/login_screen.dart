import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/screen/admin/admin_login_screen.dart';
import 'package:vipra_lap/screen/dashboard_screen.dart';
import 'package:vipra_lap/screen/start_screen/signup_screen.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/widgets/my_filled_button.dart';
import 'package:vipra_lap/widgets/my_icon_text_button.dart';
import 'package:vipra_lap/widgets/my_outline_button.dart';
import 'package:vipra_lap/widgets/my_text_field.dart';

import '../../domain/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: MyOutlineButton(
                  btnText: "Admin",
                  textWeight: FontWeight.bold,
                  btnTextColor: Colors.black45,
                  borderColor: Colors.white54,
                  btnBackground: AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: 8,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminLoginScreen()));
                  },
                )),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      style: myTextStyle36(fontColor: Colors.white),
                      children: [
                    TextSpan(
                        text: " Back",
                        style: myTextStyle48(
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])),
              Text(
                "Track tests, stay healthy",
                style: myTextStyle18(fontColor: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
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

                    /// Forgot
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password",
                          style: myTextStyle18(fontColor: Colors.white60),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: MyFilledButton(
                            btnText: "Log In",
                            btnTextColor: Colors.black,
                            textWeight: FontWeight.bold,
                            btnBackground:
                                AppColors.primaryLight.withOpacity(1),
                            borderRadius: 8,
                            onPressed: () {
                              _authService.loginWithEmail(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  context);
                            })),
                    const SizedBox(
                      height: 12,
                    ),
                    MyIconTextButton(
                      btnText: "Log in with Google",
                      onPressed: () async {
                        try {
                          final user = await _authService.signInWithGoogle();
                          if (user != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen()));
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Failed : $error")));
                        }
                      },
                      btnTextColor: Colors.white,
                      btnBackground: AppColors.primaryLight.withOpacity(0.8),
                      textWeight: FontWeight.bold,
                      borderRadius: 8,
                      iconPath: "assets/images/google_icon.png",
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Don't have an account? ",
                      style: myTextStyle18(fontColor: Colors.white60),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: MyOutlineButton(
                          btnText: "Sign Up",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          btnBackground:
                              AppColors.primaryColor.withOpacity(0.9),
                          borderRadius: 8,
                          btnTextColor: Colors.white70,
                          textWeight: FontWeight.bold,
                        ))
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
