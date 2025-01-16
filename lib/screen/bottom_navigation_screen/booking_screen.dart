import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

import '../../domain/colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Booking",
          style: myTextStyle24(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(child: Column(
        children: [
          ListTile(
            leading: Container(
                width: 80,
                decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset("assets/icons/doctor-consultation.png"),
                )),
            title: Text(
              "Book your test?",
              style: myTextStyle18(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Book your test by call",
              style: myTextStyle15(),
            ),
            trailing: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white),
                child: Text(
                  "Call Now",
                  style: myTextStyle12(
                      fontWeight: FontWeight.w800, fontColor: Colors.white),
                )),
          ) ,
        ],
      ),),
    );
  }
}
