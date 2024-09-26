import 'package:shoe_app/views/home/models/product_model.dart';

class ProductDetailArguments {
  String categoryId;

  ProductModel product;

  ProductDetailArguments({required this.categoryId, required this.product});
}
