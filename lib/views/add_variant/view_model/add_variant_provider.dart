import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_app/common/common_functions/pick_image.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';

class AddVariantProvider extends ChangeNotifier {
  bool isLoading = false;
  List<XFile?> pickedXfileList = [];
  List<File> pickedfileList = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController colorController = TextEditingController();
  bool isColorValidated = true;

  void colorValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isColorValidated = false;
      notifyListeners();
    } else {
      isColorValidated = true;
      notifyListeners();
    }
  }

  void clearData() {
    colorController.clear();
    pickedXfileList = [];
    pickedfileList = [];
    notifyListeners();
  }

  Future<void> addProductVariant(
      String variantColour, String categoryId, String productId) async {
    try {
      isLoading = true;
      notifyListeners();
      final imageList = await uploadImageToFirebase(pickedXfileList);
      if (imageList.isNotEmpty) {
        final productRef = await firestore.collection("variants").add({
          "color": variantColour,
          "category_id": categoryId,
          "product_id": productId,
          "image_url": imageList
        });

        final variantId = productRef.id;
        await productRef.update({"variant_id": variantId});
        isLoading = false;
        notifyListeners();
        showToast("variant added successfully");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  Future<void> selectMultipleImage() async {
    final list = await pickMultipleImage();

    if (list.isNotEmpty) {
      pickedXfileList = list;
      pickedfileList = list.map((xFile) => File(xFile?.path ?? "")).toList();
      notifyListeners();
    }
  }
}
