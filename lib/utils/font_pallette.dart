import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:google_fonts/google_fonts.dart';

class FontPallette {
  static TextStyle headingStyle = GoogleFonts.poppins(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: ColorPallette.blackColor,
  );

  static TextStyle bodyStyle = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: ColorPallette.blackColor,
  );

  static TextStyle subtitleStyle = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: ColorPallette.greyColor,
  );
}
