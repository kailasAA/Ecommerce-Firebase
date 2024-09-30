import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/route/argument_model/search_screen_arguments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
import 'package:shoe_app/views/home/view/widgets/home_products_listview.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:tuple/tuple.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchScreenArguments});
  final SearchScreenArguments searchScreenArguments;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context
            .read<HomeProvider>()
            .changeSearchedProducts(widget.searchScreenArguments.productList);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: ColorPallette.scaffoldBgColor,
      ),
      body: Selector<HomeProvider,
          Tuple3<List<ProductModel>, List<ProductModel>, List<Variant>>>(
        selector: (p0, p1) =>
            Tuple3(p1.searchedProducts, p1.productList, p1.variantList),
        builder: (context, value, child) {
          final productList = value.item2;
          final variantList = value.item3;
          final searchProducts = value.item1;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: NuemorphicTextField(
                    headingText: "Search",
                    hintText: "Search here",
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final searchedList = productList.where(
                          (product) {
                            return (product.name ?? "")
                                .toLowerCase()
                                .startsWith(value.toLowerCase());
                          },
                        ).toList();
                        context
                            .read<HomeProvider>()
                            .changeSearchedProducts(searchedList);
                      } else {
                        context
                            .read<HomeProvider>()
                            .changeSearchedProducts(productList);
                      }
                    },
                    textEditingController: searchController,
                    prefixWidget: const Icon(Icons.search),
                  ),
                ),
              ),
              productList.isEmpty || searchProducts.isEmpty
                  ? SliverToBoxAdapter(
                      child: SizedBox(
                        height: 350.h,
                        child: Center(
                          child: Text(
                            "No Product Found",
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 15.sp),
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = searchProducts[index];
                          final variants = variantList
                              .where(
                                (element) => element.productId == product.id,
                              )
                              .toList();
                          final variant = variants[0];
                          return ProductTile(
                              
                              imageHeigh: 90.w,
                              height: 270.h,
                              width: 165.w,
                              product: product,
                              variant: variant);
                        },
                        childCount: searchProducts.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
