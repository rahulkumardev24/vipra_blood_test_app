import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/screen/admin/admin_dashboard_screen.dart';
import 'package:vipra_lap/screen/start_screen/login_screen.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/widgets/my_filled_button.dart';
import 'package:vipra_lap/widgets/my_text_field.dart';
import '../../domain/colors.dart';
import '../../widgets/my_outline_button.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  MediaQueryData? mqData;
  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0),

        actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: MyOutlineButton(
                btnText: "User",
                textWeight: FontWeight.bold,
                btnTextColor: Colors.black45,
                borderColor: Colors.white54,
                btnBackground:
                AppColors.primaryColor.withOpacity(0.5),
                borderRadius: 8,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const LoginScreen()));
                },
              )),
        ),
      ],),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                width: mqData!.size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        left: mqData!.size.width * 0.15,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/images/management.png",
                              height: mqData!.size.height * 0.15,
                            ),
                          ),
                        )),
                    Positioned(
                        right: mqData!.size.width * 0.15,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              "assets/icons/appicon.png",
                              height: mqData!.size.height * 0.18,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text("Vipra lab Admin",
                  style: myTextStyle36(
                      fontColor: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    MyTextField(
                      textEditingController: emailController,
                      filled: true,
                      borderColor: const Color(0xcd083f70),
                      filledColor: const Color(0xcd083f70),
                      borderRadius: 8,
                      prefixIcon: Icons.email_outlined,
                      hintText: "Enter Admin Email",
                      labelText: "Admin email",
                    ),
                    const SizedBox(height: 12),
                    MyTextField(
                      textEditingController: passwordController,
                      filled: true,
                      borderColor: Color(0xcd083f70),
                      filledColor: Color(0xcd083f70),
                      labelText: "Admin password",
                      borderRadius: 8,
                      prefixIcon: Icons.lock,
                      hintText: "Enter Admin Password",
                    ),
                    const SizedBox(height: 12),
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
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              if (email.isEmpty && password.isEmpty) {
                                snackMessage(
                                    "Plz Enter email and password", Colors.red);
                              } else if (email.isNotEmpty &&
                                  password.isNotEmpty) {
                                _authService.adminLogin(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    context);
                              }
                            })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// function for snackMessage
  void snackMessage(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: myTextStyle18(fontColor: Colors.white),
      ),
      backgroundColor: backgroundColor,
    ));
  }
}
