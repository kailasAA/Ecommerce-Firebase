import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Selector<HomeProvider, Tuple3>(
        selector: (p0, p1) {
          return Tuple3(p1.categoryList, p1.isLoading, p1.productList);
        },
        builder: (context, value, child) {
          final isLoading = value.item2;
          List<CategoryModel> categoryList = value.item1;
          List<ProductModel> productList = value.item3;

          return isLoading
              ? const LoadingAnimationStaggeredDotsWave()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          80.verticalSpace,
                          NeumorphicContainer(
                            height: 200.h,
                            width: 320.w,
                          ),
                          30.verticalSpace,
                        ],
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
                                      products: productList
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
                                  style: FontPallette.headingStyle,
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

class HomeProductListWithHeading extends StatelessWidget {
  const HomeProductListWithHeading({
    super.key,
    this.productHeading,
    required this.products,
  });
  final String? productHeading;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  productHeading ?? "",
                  style: FontPallette.headingStyle,
                ),
              ),
              SizedBox(
                height: 260.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: EdgeInsets.all(10.r),
                        child: NeumorphicContainer(
                          blurRadius: 15,
                          offset: const Offset(5, 5),
                          height: 220.h,
                          width: 160.w,
                          childWidget: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              children: [
                                Container(
                                  height: 130.w,
                                  width: 140.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        15.r), // Rounded corners
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      height: 230.h,
                                      width: 310.w,
                                      child: Image.network(
                                        product.images?[0] ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                5.verticalSpace,
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40.h,
                                      child: Text(
                                        product.name ?? "",
                                        style: FontPallette.headingStyle
                                            .copyWith(fontSize: 13.sp),
                                      ),
                                    ),
                                    // 10.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.brandName ?? "",
                                          style: FontPallette.headingStyle
                                              .copyWith(fontSize: 13.sp),
                                        ),
                                        Text(
                                          "₹${product.price ?? ""}",
                                          style: FontPallette.headingStyle
                                              .copyWith(fontSize: 13.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    // separatorBuilder: (context, index) => 20.horizontalSpace,
                    itemCount: products.length),
              ),
            ],
          )
        : const SizedBox();
  }
}
