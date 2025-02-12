import 'package:flutter/material.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/widgets/my_outline_button.dart';
import 'package:vipra_lap/screen/admin/patients_screen.dart';
import '../bottom_navigation_screen/report_screen.dart';
import 'appointments_screen.dart';
import 'booked_calls_screen.dart';
import 'booked_tests_screen.dart';
import 'doctors_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AuthService _authService = AuthService();

  final List<Map<String, dynamic>> _dashboardItems = [
    {'icon': Icons.people, 'label': 'Patients', 'screen': const PatientsScreen()},
    {'icon': Icons.description, 'label': 'Reports', 'screen': const ReportScreen()},
    {'icon': Icons.phone, 'label': 'Booked Calls', 'screen': const BookedCallsScreen()},
    {'icon': Icons.science, 'label': 'Booked Tests', 'screen': const BookedTestsScreen()},
    {'icon': Icons.medical_services, 'label': 'Doctors', 'screen': const DoctorsScreen()},
    {'icon': Icons.calendar_today, 'label': 'Appointments', 'screen': const AppointmentsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _authService.adminLogout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: _dashboardItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _dashboardItems[index]['screen'],
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.deepPurpleAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_dashboardItems[index]['icon'], size: 50, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      _dashboardItems[index]['label'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}