import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';
import 'package:shoe_app/views/add_size/view_model/add_size_provider.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';
import 'package:shoe_app/views/categories/view_model.dart/catgeory_provider.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/edit_product/view_model/edit_product_provider.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:shoe_app/views/main_screen%20copy/viemodel/main_screen_provider.dart';

class Multiproviders {
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(
      create: (context) => MainScreenProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CatgeoryProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => EditProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductDetailProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddVariantProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddSizeProvider(),
    )
  ];
}
