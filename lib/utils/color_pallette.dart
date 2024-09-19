import 'package:flutter/material.dart';

class ColorPallette {
  ColorPallette._privateConstructor();

  static ColorPallette instance = ColorPallette._privateConstructor();
  factory ColorPallette() {
    return instance;
  }

  static Color blackColor = Colors.black;
  static Color whiteColor = Colors.white;
  // static Color purple = const Color.fromARGB(255, 104, 16, 187);
  static Color greyColor = Colors.grey;
  static Color greenColor = Colors.green;
  
  static Color redColor = Colors.red;
  static Color scaffoldBgColor = Colors.grey.shade300;
}
