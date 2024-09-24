import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_app/common/common_functions/pick_image.dart';
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

  Future<void> getProductDetails(String productId) async {
    try {
      product = null;
      isLoading = true;
      var data = await firestore.collection("products").doc(productId).get();
      product = ProductModel.fromMap(data.data() as Map<String, dynamic>);
      isLoading = false;
      notifyListeners();

      print("product fetched successfully");
      print(product);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      print(e.toString());
    }
  }

  Future<void> getVariants(String productId) async {
    try {
      variant = null;
      variantList = [];
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
      
      print(variantList);
      // selectedVariantId = variantList.first.variantId ?? "";
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

  Future<void> getVariantDetails(String variantId) async {
    try {
      variant = null;
      isLoading = true;
      var data = await firestore.collection("variants").doc(variantId).get();
      variant = Variant.fromMap(data.data() as Map<String, dynamic>);
      isLoading = false;
      notifyListeners();
      print("variant fetched successfully");
      print(product);
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

  Future<void> removeProduct(String productId) async {
    try {
      final productRef =
          FirebaseFirestore.instance.collection('variants').doc(productId);
      await productRef.delete();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> addVariants() async {
  //   try {
  //     DocumentReference variantRef = firestore.collection("variants").doc();
  //     await variantRef.set({
  //       'variant_id': variantRef.id,
  //       'product_id': productRef.id,
  //       'color': color,
  //       "name": name,
  //       "brand_name": brandName,
  //       "category_id": categoryId,
  //       "category_name": categoryName,
  //       "image_url": imageUrlList,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> updateProductInfo(String productId, String name, String price,
  //     String sellingPrice, String brandName) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({
  //     'name': name,
  //     'price': price,
  //     'selling_price': sellingPrice,
  //     'brand_name': brandName,
  //   });
  // }

  // Future<void> addVariantWithImagesAndSizes(String productId, String color,
  //     List<String> imageUrls, Map<String, Map<String, dynamic>> sizes) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({
  //     'variants.$color': {'color': color, 'sizes': sizes, 'images': imageUrls}
  //   });
  // }

  // Future<void> removeVariant(String productId, String color) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({'variants.$color': FieldValue.delete()});
  // }

  // Future<void> addSizeToVariant(String productId, String color, String size,
  //     String price, String sellingPrice, int stock) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({
  //     'variants.$color.sizes.$size': {
  //       'price': price,
  //       'selling_price': sellingPrice,
  //       'stock': stock
  //     }
  //   });
  // }

  // Future<void> removeSizeFromVariant(
  //     String productId, String color, String size) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef
  //       .update({'variants.$color.sizes.$size': FieldValue.delete()});
  // }

  // Future<void> updateSizeInVariant(String productId, String color, String size,
  //     String price, String sellingPrice, int stock) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({
  //     'variants.$color.sizes.$size': {
  //       'price': price,
  //       'selling_price': sellingPrice,
  //       'stock': stock
  //     }
  //   });
  // }

  // Future<void> updateImagesForVariant(
  //     String productId, String color, List<String> imageUrls) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({'variants.$color.images': imageUrls});
  // }

  // Future<void> removeImageFromVariant(
  //     String productId, String color, String imageUrlToRemove) async {
  //   final productRef =
  //       FirebaseFirestore.instance.collection('products').doc(productId);

  //   await productRef.update({
  //     'variants.$color.images': FieldValue.arrayRemove([imageUrlToRemove])
  //   });
  // }
}
