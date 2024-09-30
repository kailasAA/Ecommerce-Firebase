import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_app/common/common_functions/pick_image.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/views/detail_page/models/size_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class ProductDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<XFile?> pickedXfileList = [];
  List<File> pickedfileList = [];
  ProductModel? product;
  List<Variant> variantList = [];
  Variant? variant;
  List<SizeModel> variantSizes = [];
  SizeModel? selectedSize;

// to get the product details
  Future<void> getProductDetails(String productId) async {
    try {
      product = null;
      isLoading = true;
      notifyListeners();
      var data = await firestore.collection("products").doc(productId).get();
      product = ProductModel.fromMap(data.data() as Map<String, dynamic>);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

// to get the all variants
  Future<void> getVariants(String productId) async {
    try {
      variant = null;
      isLoading = true;
      notifyListeners();
      var data = await firestore.collection("variants").get();
      final list = data.docs;
      final allVariants = list.map(
        (variant) {
          return Variant.fromMap(variant.data());
        },
      ).toList();
      variantList = [];
      variantList = allVariants.where(
        (element) {
          return element.productId == productId;
        },
      ).toList();
      variant = variantList[0];
      isLoading = false;
      notifyListeners();
      print("variant detail fetched successfully");
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

// to get all the sizes
  Future<void> getSizes() async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await firestore.collection("sizes").get();
      final sizeData = data.docs;
      final allSizes = sizeData.map(
        (size) {
          return SizeModel.fromMap(size.data());
        },
      ).toList();

      variantSizes = [];
      variantSizes = allSizes.where(
        (size) {
          return size.variantId == variant?.variantId;
        },
      ).toList();
      if (variantSizes.isEmpty) {
        selectedSize = null;
      }
      selectedSize = variantSizes[0];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("size was not fetched $e");
      isLoading = false;
      notifyListeners();
    }
  }

// to get the variant details
  Future<void> getVariantDetails(
      String variantId, Variant? selectedVariant) async {
    try {
      isLoading = true;
      notifyListeners();
      variant = selectedVariant;
      variantSizes = [];
      getSizes();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

// to select multiple images
  Future<void> selectMultipleImage() async {
    final list = await pickMultipleImage();
    if (list.isNotEmpty) {
      pickedXfileList = list;
      pickedfileList = list.map((xFile) => File(xFile?.path ?? "")).toList();
      notifyListeners();
    }
  }

// to upload list of images to firebase
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

//  to add a product variant
  Future<void> addProductVariant(String variantColour, String categoryId,
      String categoryName, String productId, String productName) async {
    try {
      isLoading = true;
      notifyListeners();
      final imageList = await uploadImageToFirebase(pickedXfileList);
      if (imageList.isNotEmpty) {
        final productRef = await firestore.collection("variants").add({
          "variant_color": variantColour,
          "category_id": categoryId,
          "category_name": categoryName,
          "product_id": productId,
          "profuct_name": productName
        });

        final variantId = productRef.id;
        await productRef.update({"variant_id": variantId});
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      print(e.toString());
    }
  }

  // to reduce the stock

  Future<void> updateStock(int stock, String stockId) async {
    isLoading = true;
    notifyListeners();
    try {
      final sizeRef = firestore.collection("sizes");
      await sizeRef.doc(stockId).update({'stock': stock.toString()});
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

// to remove a product and sizes related to it
  Future<void> removeProduct(String productId) async {
    isLoading = true;
    notifyListeners();
    try {
      final productRef =
          FirebaseFirestore.instance.collection('variants').doc(productId);
      await productRef.delete();

      var sizes = await firestore
          .collection("sizes")
          .where("product_id", isEqualTo: productId)
          .get();
      for (var size in sizes.docs) {
        await firestore.collection("sizes").doc(size.id).delete();
      }
      notifyListeners();
      showToast("Variant successfully deleted");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

// to remove the size only
  Future<void> removeSize(String sizeId) async {
    isLoading = true;
    notifyListeners();
    try {
      final sizeRef =
          FirebaseFirestore.instance.collection('sizes').doc(sizeId);
      await sizeRef.delete();

      notifyListeners();
      showToast("Size successfully deleted");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

// to update the selected size
  Future<void> selectSize(SizeModel sizeModel) async {
    try {
      selectedSize = sizeModel;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
