import 'package:flutter/material.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/screen/admin/patients_screen.dart';
import '../bottom_navigation_screen/report_screen.dart';
import 'appointments_screen.dart';
import 'booked_calls_screen.dart';
import 'booked_tests_screen.dart';
import 'doctors_screen.dart';
import 'package:animations/animations.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AuthService _authService = AuthService();

  final List<Map<String, dynamic>> _dashboardItems = [
    {
      'icon': Icons.people,
      'label': 'Patients',
      'screen': const PatientsScreen(),
      'color': const Color(0xFF6C5CE7),
      'heroTag': 'patients'
    },
    {
      'icon': Icons.description,
      'label': 'Reports',
      'screen': const ReportScreen(),
      'color': const Color(0xFF00B894),
      'heroTag': 'reports'
    },
    {
      'icon': Icons.phone,
      'label': 'Booked Calls',
      'screen': const BookedCallsScreen(),
      'color': const Color(0xFFFD79A8),
      'heroTag': 'calls'
    },
    {
      'icon': Icons.science,
      'label': 'Booked Tests',
      'screen': const BookedTestsScreen(),
      'color': const Color(0xFFFDCB6E),
      'heroTag': 'tests'
    },
    {
      'icon': Icons.medical_services,
      'label': 'Doctors',
      'screen': const DoctorsScreen(),
      'color': const Color(0xFF0984E3),
      'heroTag': 'doctors'
    },
    {
      'icon': Icons.calendar_today,
      'label': 'Appointments',
      'screen': const AppointmentsScreen(),
      'color': const Color(0xFFE17055),
      'heroTag': 'appointments'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Admin Dashboard",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        actions: [
          OpenContainer(
            transitionDuration: const Duration(milliseconds: 500),
            closedBuilder: (_, openContainer) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: openContainer,
              );
            },
            closedElevation: 0,
            closedColor: Colors.transparent,
            openBuilder: (_, __) {
              return _buildMenuDialog();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.1,
                ),
                itemCount: _dashboardItems.length,
                itemBuilder: (context, index) {
                  return OpenContainer(
                    transitionDuration: const Duration(milliseconds: 600),
                    openBuilder: (context, _) {
                      return _dashboardItems[index]['screen'];
                    },
                    closedColor: _dashboardItems[index]['color'],
                    closedElevation: 4,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    closedBuilder: (context, openContainer) {
                      return InkWell(
                        onTap: openContainer,
                        borderRadius: BorderRadius.circular(16),
                        child: Hero(
                          tag: _dashboardItems[index]['heroTag'],
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: _dashboardItems[index]['color'],
                              boxShadow: [
                                BoxShadow(
                                  color: _dashboardItems[index]['color']
                                      .withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _dashboardItems[index]['icon'],
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  _dashboardItems[index]['label'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'View',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      /// --- Floating action button --- ///
      floatingActionButton: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        closedBuilder: (_, openContainer) {
          return FloatingActionButton(
            onPressed: openContainer,
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
        closedElevation: 6,
        closedShape: const CircleBorder(),
        openBuilder: (_, __) {
          return _buildAddMenu();
        },
      ),
    );
  }

  Widget _buildMenuDialog() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Options"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              _authService.adminLogout(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              // Navigate to settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddMenu() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person_add, color: Colors.deepPurple),
            title: const Text("Add Patient"),
            onTap: () {},
          ),
          ListTile(
            leading:
                const Icon(Icons.medical_services, color: Colors.deepPurple),
            title: const Text("Add Doctor"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.deepPurple),
            title: const Text("Add Appointment"),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
