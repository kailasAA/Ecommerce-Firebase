import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';

class CatgeoryProvider extends ChangeNotifier {
  String selectedCategory = "";
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController? categoryEditingController;
  bool getCategoryLoading = false;
  bool addCatgeoryLoading = false;
  List<CategoryModel> categoryList = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void clearControllers() {
    categoryNameController.clear();
    notifyListeners();
  }

  List<CategoryModel> convertToCategory(List<DocumentSnapshot> docs) {
    return docs.map(
      (doc) {
        return CategoryModel.fromFirestore(doc);
      },
    ).toList();
  }

  // to add a category

  Future<void> addCategory({required String categoryName}) async {
    addCatgeoryLoading = true;
    notifyListeners();
    try {
      DocumentReference docRef = await _firestore.collection("categories").add({
        'categoryName': categoryName,
      });
      String categoryId = docRef.id;
      await docRef.update({"id": categoryId});
      clearControllers();
      addCatgeoryLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      addCatgeoryLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCategories() async {
    categoryList = [];
    try {
      getCategoryLoading = true;
      var data = await _firestore.collection("categories").get();
      var list = data.docs;
      categoryList = convertToCategory(list);
      getCategoryLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      getCategoryLoading = false;
      notifyListeners();
    }
  }

  // to delete a category

  Future<void> deleteCategory(String categoryId) async {
    getCategoryLoading = true;
    notifyListeners();
    try {
      await _firestore.collection("categories").doc(categoryId).delete();
      var products = await _firestore
          .collection("products")
          .where('category_id', isEqualTo: categoryId)
          .get();

      for (var doc in products.docs) {
        await _firestore.collection("products").doc(doc.id).delete();
      }

      getCategories();
    } catch (e) {
      print(e.toString());
      getCategoryLoading = false;
      notifyListeners();
    }
  }

  // to edit a category

  Future<void> updateCategory(String newCategoryName, String categoryId) async {
    getCategoryLoading = true;
    try {
      await _firestore.collection('categories').doc(categoryId).update({
        'categoryName': newCategoryName,
      });
      clearControllers();
      getCategories();
      print('Category updated successfully');
      getCategoryLoading = false;
    } catch (e) {
      print(e.toString());
      getCategoryLoading = true;
    }
  }

  void changeSelectedCategory(String categoryName) {
    categoryEditingController = TextEditingController(text: categoryName);
    selectedCategory = categoryName;
    notifyListeners();
  }
}
