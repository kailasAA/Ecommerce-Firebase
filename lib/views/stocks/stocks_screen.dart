import 'package:flutter/material.dart';
import 'package:shoe_app/utils/color_pallette.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Center(child: Text("stocks")),
    );
  }
}
