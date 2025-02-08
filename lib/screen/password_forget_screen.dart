import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/widgets/my_filled_button.dart';
import 'package:vipra_lap/widgets/my_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: myTextStyle18(),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Enter your registered email address, and we’ll send you a password reset link.",
              style: myTextStyle15(),
            ),
            const SizedBox(
              height: 12,
            ),
            MyTextField(
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              hintText: "Enter email",
              hintColor: Colors.black45,
              filled: false,
              textColor: Colors.black,
              borderColor: AppColors.primaryLight,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : MyFilledButton(
                    onPressed: _resetPassword,
                    borderRadius: 12,
                    btnText: 'Reset Password',
                  ),
          ],
        ),
      ),
    );
  }

  /// Method to handle password reset
  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter your email",
            style: myTextStyle18(fontColor: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      await _authService.reSetPassword(email, context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: Enter correct email ${e.toString()}",
            maxLines: 2,
            style: myTextStyle18(fontColor: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
