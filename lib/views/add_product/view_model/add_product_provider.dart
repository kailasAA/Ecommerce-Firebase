import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoe_app/common/common_functions/pick_image.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';

class AddProductProvider extends ChangeNotifier {
  List<XFile?> pickedXfileList = [];
  List<File> pickedfileList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  // TextEditingController priceController = TextEditingController();
  // TextEditingController sellingPriceController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  String selectedCategory = "";
  bool isColorValidated = true;
  bool isNameValidated = true;
  // bool isPriceValidated = true;
  // bool isSellingPriceValidated = true;
  bool isBrandValidated = true;
  bool isLoading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// to add baseProduct

  Future<void> addBaseProduct(
      {required String name,
      // required String price,
      // required String sellingPrice,
      required String categoryId,
      required String categoryName,
      required String brandName,
      required String color}) async {
    try {
      if (pickedXfileList.isNotEmpty) {
        isLoading = true;
        notifyListeners();
        final imageUrlList = await uploadImageToFirebase(pickedXfileList);
        if (imageUrlList.isNotEmpty) {
          DocumentReference productRef = firestore.collection("products").doc();
            DocumentReference variantRef = firestore.collection("variants").doc();
          await productRef.set({
            "id": productRef.id,
            "name": name,
            "brand_name": brandName,
            "category_id": categoryId,
          });
          await variantRef.set({
            'variant_id':variantRef.id,
            'product_id': productRef.id,
            'color': color,
            "category_id": categoryId,
            "image_url": imageUrlList,
          });
          showToast("Product added successfully");
        } else {
          print("Image upload failed");
        }
      }
      clearControllers();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearControllers() {
    nameController.clear();
    // priceController.clear();
    // sellingPriceController.clear();
    colorController.clear();
    brandController.clear();
    pickedXfileList = [];
    pickedfileList = [];
    pickedXfileList = [];
    isNameValidated = true;
    // isPriceValidated = true;
    // isSellingPriceValidated = true;
    isColorValidated = true;
    notifyListeners();
  }

  void nameValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isNameValidated = false;
      notifyListeners();
    } else {
      isNameValidated = true;
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

  void colorValidation(String value) {
    if (value.isEmpty && value.length < 2) {
      isColorValidated = false;
      notifyListeners();
    } else {
      isColorValidated = true;
      notifyListeners();
    }
  }

  bool isValidated() {
    if (nameController.text.isNotEmpty &&
    brandController.text.isNotEmpty&&
        // priceController.text.isNotEmpty &&
        // sellingPriceController.text.isNotEmpty &&
        colorController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // void priceValidation(String value) {
  //   if (value.isEmpty && value.length < 2) {
  //     isPriceValidated = false;
  //     notifyListeners();
  //   } else {
  //     isPriceValidated = true;
  //     notifyListeners();
  //   }
  // }

  // void sellingPriceValidation(String value) {
  //   if (value.isEmpty && value.length < 2) {
  //     isSellingPriceValidated = false;
  //     notifyListeners();
  //   } else {
  //     isSellingPriceValidated = true;
  //     notifyListeners();
  //   }
  // }

  void changeSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
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

Future<List<String?>> uploadImageToFirebase(List<XFile?> imageFiles) async {
  List<String> downloadUrls = [];
  for (var imageFile in imageFiles) {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference ref = storage.ref().child('uploads/$fileName.jpg');

      UploadTask uploadTask = ref.putFile(File(imageFile?.path ?? ""));

      TaskSnapshot snapshot = await uploadTask;

      String url = await snapshot.ref.getDownloadURL();

      downloadUrls.add(url);
    } catch (e) {
      print("Error uploading image: $e");
      return [];
    }
  }
  return downloadUrls;
}
