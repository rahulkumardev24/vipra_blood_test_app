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
  Color? textColor;
  VoidCallback? suffixIconOnPress;
  FontWeight textWeight;
  Color? cursorColor;
  Color sufAndFixIconColor;
  Color? suffixIconColor;
  Color? hintColor;
  Color? labelColor;

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
      this.textColor = Colors.white,
      this.textWeight = FontWeight.normal,
      this.suffixIconOnPress,
      this.sufAndFixIconColor = Colors.white54,
      this.cursorColor = Colors.white60,
      this.suffixIconColor = Colors.black54,
      this.hintColor = Colors.white54 ,
        this.labelColor = Colors.white38
      });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: widget.cursorColor,
      controller: widget.textEditingController,
      style: myTextStyle15(
          fontColor: widget.textColor!, fontWeight: widget.textWeight),
      decoration: InputDecoration(
          hintText: widget.hintText ?? null,
          filled: widget.filled ?? false,
          fillColor: widget.filledColor ?? null,
          hintStyle:
              myTextStyle18(fontColor: widget.hintColor ?? Colors.white54),
          label: widget.labelText != null ? Text(widget.labelText!) : null,
          labelStyle: myTextStyle18(fontColor: widget.labelColor ?? Colors.white38),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon ?? null,
                  color: widget.sufAndFixIconColor,
                )
              : null,
          suffixIcon: IconButton(
              onPressed: widget.suffixIconOnPress,
              icon: Icon(
                widget.suffixIcon ?? null,
                color: widget.suffixIconColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(width: 2, color: widget.borderColor!)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(width: 2, color: widget.borderColor!))),
    );
  }
}
