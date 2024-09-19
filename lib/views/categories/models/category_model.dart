import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryName;
  String? id;
  CategoryModel({this.categoryName, this.id});

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return CategoryModel(id: data["id"], categoryName: data["categoryName"]);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'categoryName': categoryName,
  //   };
  // }
}
