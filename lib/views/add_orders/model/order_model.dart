class OrderModel {
  String? orderId;
  String? itemQuantity;
  String? productId;
  String? productName;
  String? categoryId;
  String? categoryName;
  String? variantId;
  String? variantColor;
  String? receivedPrice; 
  String? profit;
  String? soldPrice;
  String? sizeId;
  String? size;
  String? totalPrice;
  String? imageUrl;
  String? brandName;
  bool? orderCompleted;
  bool? returnInitialized;
  bool? returnCompleted;
  String? district;
  String? state;
  String? place;
  String? address;
  String? phoneNumber;
  String? orderedPersonName;
  String? orderDate;
  String? orderCompletedDate;
  String? returnInitializedDate;
  String? returnCompletedDate;

  OrderModel({
    this.orderId,
    this.itemQuantity,
    this.productId,
    this.productName,
    this.categoryId,
    this.categoryName,
    this.variantId,
    this.variantColor,
    this.receivedPrice,
    this.profit,
    this.soldPrice,
    this.sizeId,
    this.size,
    this.totalPrice,
    this.imageUrl,
    this.brandName,
    this.orderCompleted,
    this.returnInitialized,
    this.returnCompleted,
    this.district,
    this.state,
    this.place,
    this.address,
    this.phoneNumber,
    this.orderedPersonName,
    this.orderDate,
    this.orderCompletedDate,
    this.returnInitializedDate,
    this.returnCompletedDate,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'],
      itemQuantity: map['itemQuantity'],
      productId: map['productId'],
      productName: map['productName'],
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      variantId: map['variantId'],
      variantColor: map['variantColor'],
      receivedPrice: map['receivedPrice'],
      profit: map['profit'],
      soldPrice: map['soldPrice'],
      sizeId: map['sizeId'],
      size: map['size'],
      totalPrice: map['totalPrice'],
      imageUrl: map['imageUrl'],
      brandName: map['brandName'],
      orderCompleted: map['orderCompleted'],
      returnInitialized: map['returnInitialized'],
      returnCompleted: map['returnCompleted'],
      district: map['district'],
      state: map['state'],
      place: map['place'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      orderedPersonName: map['orderedPersonName'],
      orderDate: map['orderDate'],
      orderCompletedDate: map['orderCompletedDate'],
      returnInitializedDate: map['returnInitializedDate'],
      returnCompletedDate: map['returnCompletedDate'],
    );
  }

  Map<String, dynamic> toMap(OrderModel order) {
    return {
      'orderId': orderId,
      'itemQuantity': itemQuantity,
      'productId': productId,
      'productName': productName,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'variantId': variantId,
      'variantColor': variantColor,
      'receivedPrice': receivedPrice,
      'profit': profit,
      'soldPrice': soldPrice,
      'sizeId': sizeId,
      'size': size,
      'totalPrice': totalPrice,
      'imageUrl': imageUrl,
      'brandName': brandName,
      'orderCompleted': orderCompleted,
      'returnInitialized': returnInitialized,
      'returnCompleted': returnCompleted,
      'district': district,
      'state': state,
      'place': place,
      'address': address,
      'phoneNumber': phoneNumber,
      'orderedPersonName': orderedPersonName,
      'orderDate': orderDate,
      'orderCompletedDate': orderCompletedDate,
      'returnInitializedDate': returnInitializedDate,
      'returnCompletedDate': returnCompletedDate,
    };
  }
}
