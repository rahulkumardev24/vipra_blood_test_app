import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Lab Tests",
          style: myTextStyle24(fontWeight: FontWeight.bold),
        ),
        actions: const [
          FaIcon(FontAwesomeIcons.cartShopping),
          SizedBox(
            width: 12,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Need Help
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
                "Need Help?",
                style: myTextStyle18(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Request a call back",
                style: myTextStyle15(),
              ),
              trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white),
                  child: Text(
                    "Book Now",
                    style: myTextStyle15(
                        fontWeight: FontWeight.w800, fontColor: Colors.white),
                  )),
            ) ,
            Text("Blood Test" , style: myTextStyle18(),)
          ],
        ),
      ),
    );
  }
}
