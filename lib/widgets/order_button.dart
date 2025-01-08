import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

class OrderButton extends StatefulWidget {
  /// here we create constructor
 final String buttonText;
 final Color buttonColor;
 final VoidCallback onTap;
 final Color textColor ;


 OrderButton({
   super.key,
   this.buttonColor = Colors.black,
   this.textColor = Colors.white,
   required this.buttonText,
   required this.onTap,
 });

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: widget.buttonColor),
        child: Text(
          widget.buttonText,
          style: myTextStyle15(fontColor: widget.textColor),
        ));
  }
}
