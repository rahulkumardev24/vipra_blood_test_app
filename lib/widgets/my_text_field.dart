import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

import '../domain/colors.dart';

class MyTextField extends StatefulWidget {
  TextEditingController textEditingController;
  String? hintText;
  String? labelText;
  bool? filled;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Color? filledColor;
  double? borderRadius;
  Color? borderColor;
  VoidCallback? suffixIconOnPress;

  MyTextField(
      {super.key,
      required this.textEditingController,
      this.hintText,
      this.labelText,
      this.filled,
      this.prefixIcon,
      this.suffixIcon,
      this.filledColor,
      this.borderRadius = 16,
      this.borderColor = AppColors.primaryColor,
      this.suffixIconOnPress});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
          hintText: widget.hintText ?? null,
          filled: widget.filled ?? false,
          fillColor: widget.filledColor ?? null,
          hintStyle: myTextStyle18(),
          label: widget.labelText != null ? Text(widget.labelText!) : null ,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon ?? null)
              : null,
          suffixIcon: IconButton(
              onPressed: widget.suffixIconOnPress,
              icon: Icon(widget.suffixIcon ?? null)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(width: 2, color: widget.borderColor!)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(width: 2, color: widget.borderColor!))),
    );
  }
}
