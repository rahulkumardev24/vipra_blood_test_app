import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Report",
          style: myTextStyle24(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/report-data.png",
              height: 100,
              width: 100,
              color: Colors.black45,
            ),
            const SizedBox(height: 6,),
            Text("No Report Found" , style: myTextStyle18(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
