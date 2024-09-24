import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/common/common_functions/pick_image.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class EditProductProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isNameValidated = true;
  bool isColourValidated = true;
  bool isPriceValidated = true;
  bool isSellingPriceValidated = true;
  bool isBrandValidated = true;
  List<String?> imageUrlList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void nameValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isNameValidated = false;
      notifyListeners();
    } else {
      isNameValidated = true;
      notifyListeners();
    }
  }

  void colourValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isColourValidated = false;
      notifyListeners();
    } else {
      isColourValidated = true;
      notifyListeners();
    }
  }

  void brandValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isBrandValidated = false;
      notifyListeners();
    } else {
      isBrandValidated = true;
      notifyListeners();
    }
  }

  bool isValidated(
      TextEditingController nameController,
      TextEditingController priceController,
      TextEditingController sellingPriceController,
      TextEditingController colorController) {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        sellingPriceController.text.isNotEmpty &&
        colorController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void priceValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isPriceValidated = false;
      notifyListeners();
    } else {
      isPriceValidated = true;
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

  void fetchImageUrl(List<String?> imageUrl) {
    imageUrlList = imageUrl;
    notifyListeners();
  }

  void removeImageUrl(int index, String id) async {
    isLoading = true;
    imageUrlList.removeAt(index);
    notifyListeners();
    try {
      // final productRef = _firestore.collection("variants").doc(id);
      // await productRef.update({"image_url": imageUrlList});
      print("image is deleted");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> addNewMultipleImage() async {
    isLoading = true;
    notifyListeners();
    final list = await pickMultipleImage();
    if (list.isNotEmpty) {
      List<String?> imageList = await uploadImageToFirebase(list);
      if (imageList.isNotEmpty) {
        imageUrlList.addAll(imageList);
        isLoading = false;
        notifyListeners();
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel product, String productId) async {
    try {
      isLoading = true;
      notifyListeners();
      final productRef = _firestore.collection("products").doc(productId);
      await productRef.update(product.toMap());
      print("the product is updated");
      isLoading = false;
      notifyListeners();
      // showToast("Product sucessfully updated");
    } catch (e) {
      isLoading = false;
      showToast("Product was not updated");
      notifyListeners();
    }
  }

  Future<void> updateVariant(Variant? variant, String variantId) async {
    try {
      isLoading = true;
      notifyListeners();
      final productRef = _firestore.collection("variants").doc(variantId);
      await productRef.update(variant!.toMap());
      print("the variant is updated");
      isLoading = false;
      notifyListeners();
      showToast("sucessfully updated");
    } catch (e) {
      isLoading = false;
      showToast("variant was not updated");
      notifyListeners();
    }
  }
}
