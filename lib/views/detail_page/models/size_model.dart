class SizeModel {
  final String categoryId;
  final String discountPrice;
  final String productId;
  final String receivingPrice;
  final String sellingPrice;
  final String size;
  final String sizeId;
  final String stock;
  final String variantId;

  SizeModel({
    required this.categoryId,
    required this.discountPrice,
    required this.productId,
    required this.receivingPrice,
    required this.sellingPrice,
    required this.size,
    required this.sizeId,
    required this.stock,
    required this.variantId,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'discount_price': discountPrice,
      'product_id': productId,
      'recieving_price': receivingPrice,
      'selling_price': sellingPrice,
      'size': size,
      'size_id': sizeId,
      'stock': stock,
      'variant_id': variantId,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      categoryId: map['category_id'] ?? '',
      discountPrice: map['discount_price'] ?? '',
      productId: map['product_id'] ?? '',
      receivingPrice: map['recieving_price'] ?? '',
      sellingPrice: map['selling_price'] ?? '',
      size: map['size'] ?? '',
      sizeId: map['size_id'] ?? '',
      stock: map['stock'] ?? '',
      variantId: map['variant_id'] ?? '',
    );
  }
}
