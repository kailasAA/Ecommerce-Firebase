import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
import 'package:shoe_app/views/home/view/widgets/home_products_listview.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeProvider>().getCategories();
    context.read<HomeProvider>().getAllProducts();
    context.read<HomeProvider>().getAllVariants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Selector<HomeProvider, Tuple4>(
        selector: (p0, p1) {
          return Tuple4(
              p1.categoryList, p1.isLoading, p1.productList, p1.variantList);
        },
        builder: (context, value, child) {
          final isLoading = value.item2;
          List<CategoryModel> categoryList = value.item1;
          List<ProductModel> productList = value.item3;
          List<Variant> variantList = value.item4;

          return isLoading
              ? const LoadingAnimationStaggeredDotsWave()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(15.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            40.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 30.h,
                                child: Text(
                                  "Welcome Back",
                                  style: FontPallette.headingStyle.copyWith(
                                      color: ColorPallette.blackColor),
                                ),
                              ),
                            ),
                            10.verticalSpace,
                            NeumorphicContainer(
                              offset: const Offset(5, 5),
                              blurRadius: 15,
                              height: 200.h,
                              width: 320.w,
                            ),
                            30.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                    productList.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final category = categoryList[index];
                                return Column(
                                  children: [
                                    HomeProductListWithHeading(
                                      variantList: variantList,
                                      products:
                                          // productList,
                                          productList
                                              .where(
                                                (product) =>
                                                    product.categoryId ==
                                                    category.id,
                                              )
                                              .toList(),
                                      productHeading: category.categoryName,
                                    ),
                                  ],
                                );
                              },
                              childCount: categoryList.length,
                            ),
                          )
                        : SliverToBoxAdapter(
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
                          ),
                  ],
                );
        },
      ),
    );
  }
}
