class ProductModel {
  String? id;
  String? name;
  String? brandName;
  String? categoryId;
  String? categoryName;
  String? price;
  String? sellingPrice;
  List<String>? images;

  ProductModel({
    this.id,
    this.brandName,
    this.name,
    this.categoryName,
    this.categoryId,
    this.price,
    this.sellingPrice,
    this.images,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      id: data["id"],
      brandName: data["brand_name"],
      categoryId: data["category_id"],
      name: data['name'],
      categoryName: data['category_name'],
      price: data['price'],
      sellingPrice: data["selling_price"],
      images: List<String>.from(data['image_url'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category_name': categoryName,
      'price': price,
      'selling_price':sellingPrice,
      'image_url': images,
      'brand_name':brandName,
      'category_id':categoryId,
      'id':id,

    };
  }
}

// class ColorVariation {
//   String colorId;
//   String colorName;
//   List<String> images;
//   Map<String, SizeVariation> sizes;

//   ColorVariation({
//     required this.colorId,
//     required this.colorName,
//     required this.images,
//     required this.sizes,
//   });

//   // From Map
//   factory ColorVariation.fromMap(String colorId, Map<String, dynamic> data) {
//     return ColorVariation(
//       colorId: colorId,
//       colorName: data['colorName'],
//       images: List<String>.from(data['images'] ?? []),
//       sizes: (data['sizes'] as Map<String, dynamic>)
//           .map((sizeId, sizeData) => MapEntry(
//                 sizeId,
//                 SizeVariation.fromMap(sizeId, sizeData),
//               )),
//     );
//   }

//   // To Map
//   Map<String, dynamic> toMap() {
//     return {
//       'colorName': colorName,
//       'images': images,
//       'sizes': sizes.map((sizeId, size) => MapEntry(
//             sizeId,
//             size.toMap(),
//           ))
//     };
//   }
// }

// class SizeVariation {
//   String sizeId;
//   String sizeName;
//   int stock;

//   SizeVariation({
//     required this.sizeId,
//     required this.sizeName,
//     required this.stock,
//   });

//   factory SizeVariation.fromMap(String sizeId, Map<String, dynamic> data) {
//     return SizeVariation(
//       sizeId: sizeId,
//       sizeName: data['sizeName'],
//       stock: data['stock'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'sizeName': sizeName,
//       'stock': stock,
//     };
//   }
// }
