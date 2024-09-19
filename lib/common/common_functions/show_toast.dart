import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_app/utils/color_pallette.dart';

void showToast(String toastMessage, {Color? toastColor}) {
  Fluttertoast.showToast(
    msg: toastMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: toastColor ?? ColorPallette.blackColor,
    textColor: ColorPallette.whiteColor,
  );
}
