import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/utils/color_pallette.dart';

class FontPallette {
  static TextStyle headingStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: ColorPallette.blackColor,
  );

  static TextStyle bodyStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: ColorPallette.blackColor,
  );

  static TextStyle subtitleStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: ColorPallette.greyColor,
  );
}
