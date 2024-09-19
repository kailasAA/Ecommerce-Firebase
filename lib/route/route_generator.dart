import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/views/add_product/view/add_screen.dart';
import 'package:shoe_app/views/main_screen%20copy/view/main_screen.dart';
import 'package:shoe_app/views/splash/splash.dart';

class RouteGenerator {
  RouteGenerator._privateConstructor();

  static final RouteGenerator _instance = RouteGenerator._privateConstructor();

  factory RouteGenerator() {
    return _instance;
  }

  static const initial = "/";
  static const mainScreen = "mainScreen";
  static const detailScreen = "detailScreen";
  static const addProductScreen = "addProductScreen";
  static const stockScreen = "stockScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case initial:
        return buildRoute(settings, const SplashScreen());
      case mainScreen:
        return buildRoute(settings, const MainScreen());
      case addProductScreen:
        return buildRoute(
            settings,
            AddScreen(
              addProductArguments: arguments as AddProductArguments,
            ));
      default:
        return buildRoute(settings, const SplashScreen());
    }
  }

  static Route buildRoute(RouteSettings settings, Widget widget,
      {bool cupertinoPageRoute = true}) {
    return cupertinoPageRoute
        ? CupertinoPageRoute(builder: (context) => widget, settings: settings)
        : MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
