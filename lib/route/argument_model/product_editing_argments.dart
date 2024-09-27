import 'package:shoe_app/views/detail_page/models/size_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class ProductEditingArgments {
  ProductModel? product;
  Variant? variant;
  SizeModel? size;
  ProductEditingArgments({this.variant, this.product, this.size});
}
