import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

class ReportUploadScreen extends StatefulWidget {
  const ReportUploadScreen({super.key});

  @override
  State<ReportUploadScreen> createState() => _ReportUploadScreenState();
}

class _ReportUploadScreenState extends State<ReportUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report Upload" , style: myTextStyle24(),),),
    );
  }
}
