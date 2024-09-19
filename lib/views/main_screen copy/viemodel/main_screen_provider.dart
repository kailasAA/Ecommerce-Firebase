import 'package:flutter/material.dart';

class MainScreenProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
