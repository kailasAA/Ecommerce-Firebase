import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
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

  Future<void> getAllProducts() async {
    try {
      isLoading = true;
      var data = await firestore.collection("products").get();
      var list = data.docs;
      productList = list
          .map(
            (product) => ProductModel.fromMap(product.data()),
          )
          .toList();
      isLoading = false;
      notifyListeners();
      print("product fetched successfully");
      print(productList);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
