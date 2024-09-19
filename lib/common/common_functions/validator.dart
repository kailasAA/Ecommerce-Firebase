  import 'package:flutter/material.dart';

String? validateText(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "field is empty";
    } else {
      return "";
    }
  }