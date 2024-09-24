import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class ProductEditingArgments {
  ProductModel? product;
  Variant? variant;
  ProductEditingArgments({required this.variant, required this.product});
}
