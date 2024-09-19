import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamed(context, RouteGenerator.mainScreen);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Center(
          child: SizedBox(
              height: 300.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  "splash",
                  style: FontPallette.headingStyle,
                ),
              ))),
    );
  }
}
