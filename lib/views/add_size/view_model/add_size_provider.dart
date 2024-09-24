import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';

class AddSizeProvider extends ChangeNotifier {
  bool isLoading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isSizeValidated = true;
  bool isStockValidated = true;
  bool isRecievingPriceValidated = true;
  bool isSellingPriceValidated = true;
  bool isDiscountPriceValidated = true;

  void receivingPriceValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isRecievingPriceValidated = false;
      notifyListeners();
    } else {
      isRecievingPriceValidated = true;
      notifyListeners();
    }
  }

  void sellingPriceValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isSellingPriceValidated = false;
      notifyListeners();
    } else {
      isSellingPriceValidated = true;
      notifyListeners();
    }
  }

  void discountPriceValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isDiscountPriceValidated = false;
      notifyListeners();
    } else {
      isDiscountPriceValidated = true;
      notifyListeners();
    }
  }

  void sizeValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isSizeValidated = false;
      notifyListeners();
    } else {
      isSizeValidated = true;
      notifyListeners();
    }
  }

  void stockValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isStockValidated = false;
      notifyListeners();
    } else {
      isStockValidated = true;
      notifyListeners();
    }
  }

  Future<void> addSize(
      {required String recievingPrice,
      required String sellingPrice,
      required String discountPrice,
      required String size,
      required String stock,
      required String categoryId,
      required String productId,
      required String variantID}) async {
    try {
      isLoading = true;
      notifyListeners();

      final productRef = await firestore.collection("sizes").add({
        "variant_id": variantID,
        "category_id": categoryId,
        "product_id": productId,
        "size": size,
        "stock": stock,
        "recieving_price": recievingPrice,
        "selling_price": sellingPrice,
        "discount_price": discountPrice
      });

      final sizeId = productRef.id;
      await productRef.update({"size_id": sizeId});
      isLoading = false;
      notifyListeners();
      showToast("size added successfully");
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
