import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/screen/bottom_navigation_screen/booking_screen.dart';
import 'package:vipra_lap/screen/bottom_navigation_screen/home_screen.dart';
import 'package:vipra_lap/screen/bottom_navigation_screen/profile_screen.dart';
import 'package:vipra_lap/screen/bottom_navigation_screen/report_screen.dart';
import 'package:vipra_lap/screen/bottom_navigation_screen/test_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  /// list of screen
  List<Widget> screen = [
    const HomeScreen(),
    const ReportScreen(),
    const TestScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: AppColors.mainColor,
          items: [
            CurvedNavigationBarItem(
                child: Image.asset(
                  "assets/icons/home.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                label: 'Home',
                labelStyle: myTextStyle15()),
            CurvedNavigationBarItem(
                child: Image.asset(
                  "assets/icons/report.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                label: 'Report',
                labelStyle: myTextStyle15()),
            CurvedNavigationBarItem(
                child: Image.asset(
                  "assets/icons/test.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                label: 'Test',
                labelStyle: myTextStyle15()),
            CurvedNavigationBarItem(
                child: Image.asset(
                  "assets/icons/booking.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                label: 'Booking',
                labelStyle: myTextStyle15()),
            CurvedNavigationBarItem(
                child: Image.asset(
                  "assets/icons/user (5).png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                label: 'Profile',
                labelStyle: myTextStyle15()),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screen,
        ));
  }
}
