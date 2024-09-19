import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<CategoryModel> categoryList = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getCategories() async {
    try {
      isLoading = true;
      categoryList = [];
      var data = await firestore.collection("categories").get();
      var list = data.docs;
      final categories = list.map(
        (category) {
          return CategoryModel.fromFirestore(category);
        },
      ).toList();
      categoryList = categories;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}
