import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/route/argument_model/add_order_arguments.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/route/argument_model/product_detail_arguments.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/route/argument_model/search_screen_arguments.dart';
import 'package:shoe_app/views/add_orders/view/add_order_screen.dart';
import 'package:shoe_app/views/add_product/view/add_screen.dart';
import 'package:shoe_app/views/add_size/view/add_size.dart';
import 'package:shoe_app/views/add_variant/view/add_variant.dart';
import 'package:shoe_app/views/detail_page/detail_screen.dart';
import 'package:shoe_app/views/edit_product/edit_product_screen.dart';
import 'package:shoe_app/views/main_screen/view/main_screen.dart';
import 'package:shoe_app/views/search_screen/search_screen.dart';
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
  static const editScreen = "editProductScreen";
  static const addVariantScreen = "addVariantScreen";
  static const addSizeScreen = "addSizeScreen";
  static const searchScreen = "searchScreen";
  static const addOrderScreen = "addOrderScreen";

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
      case detailScreen:
        return buildRoute(
            settings,
            DetailScreen(
              productDetailArguments: arguments as ProductDetailArguments,
            ));
      case editScreen:
        return buildRoute(
            settings,
            EditProductScreen(
              productEditingArgments:
                  settings.arguments as ProductEditingArgments,
            ));
      case addVariantScreen:
        return buildRoute(
            settings,
            AddVariantScreen(
              productEditingArgments:
                  settings.arguments as ProductEditingArgments,
            ));
      case addSizeScreen:
        return buildRoute(
            settings,
            AddSizeScreen(
              productEditingArgments:
                  settings.arguments as ProductEditingArgments,
            ));
      case searchScreen:
        return buildRoute(
            settings,
            SearchScreen(
              searchScreenArguments:
                  settings.arguments as SearchScreenArguments,
            ));
      case addOrderScreen:
        return buildRoute(
            settings,
            AddOrderScreen(
              addOrderArguments: settings.arguments as AddOrderArguments,
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
