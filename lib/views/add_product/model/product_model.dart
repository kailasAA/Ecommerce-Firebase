class Product {
  String? categoryId;
  String? categoryName;
  String? imageUrl;
  String? name;
  String? price;
  String? sellingPrice;

  Product({
    this.categoryId,
    this.categoryName,
    this.imageUrl,
    this.name,
    this.price,
    this.sellingPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price'],
      sellingPrice: json['sellingPrice'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'sellingPrice': sellingPrice,
    };
  }
}

class Size {
  String? productId;
  String? productName;
  String? size;
  int? stock;

  Size({
    this.productId,
    this.productName,
    this.size,
    this.stock,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      productId: json['productId'],
      productName: json['productName'],
      size: json['size'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'size': size,
      'stock': stock,
    };
  }
}
