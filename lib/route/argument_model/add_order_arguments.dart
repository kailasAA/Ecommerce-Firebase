import 'package:shoe_app/views/detail_page/models/size_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class AddOrderArguments {
  Variant? variant;
  ProductModel? product;
  SizeModel? size;
  String? categoryName;

  AddOrderArguments({this.product, this.size, this.variant, this.categoryName});
}
