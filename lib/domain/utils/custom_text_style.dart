import 'dart:ui';

import 'package:flutter/material.dart';

/// font Size 15
TextStyle myTextStyle15(
    {String fontFamily = "primary",
    Color fontColor = Colors.black,
    FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
    color: fontColor,
    fontSize: 15,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
  );
}
