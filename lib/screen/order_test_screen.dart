import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/widgets/my_navigation_button.dart';

class OrderTestScreen extends StatefulWidget {
  const OrderTestScreen({super.key});

  @override
  State<OrderTestScreen> createState() => _OrderTestScreenState();
}

class _OrderTestScreenState extends State<OrderTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Order test" , style: myTextStyle24(fontWeight: FontWeight.bold),),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: MyNavigationButton(btnIcon: Icons.backspace_outlined, onPressed: (){
            Navigator.pop(context);
          }),
        ),

      ),
    );
  }
}
