import 'package:shoe_app/views/home/models/product_model.dart';

class ProductDetailArguments {
  String? categoryId;
  String? catgeoryName;
  ProductModel? product;

  ProductDetailArguments({this.categoryId, this.catgeoryName, this.product});
}
