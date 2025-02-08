import 'package:flutter/material.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/widgets/my_outline_button.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();

}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard screen"),),
      body: Center(child: MyOutlineButton(btnText: "Logout", onPressed: (){
        _authService.adminLogout(context);

      }),),
    ) ;
  }
}
