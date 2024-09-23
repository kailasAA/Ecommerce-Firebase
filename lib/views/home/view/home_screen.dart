import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/route/argument_model/product_detail_arguments.dart';
import 'package:shoe_app/route/route_generator.dart';
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteGenerator.detailScreen,
                              arguments: ProductDetailArguments(
                                  categoryId: product.categoryId,
                                  catgeoryName: product.categoryName,
                                  product: product));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: NeumorphicContainer(
                            offset: const Offset(3, 3),
                            blurRadius: 12.r,
                            height: 220.h,
                            width: 160.w,
                            childWidget: Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 130.w,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: (product.images ?? []).isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  product.images?[0] ?? "",
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child: LoadingAnimation(
                                                size: 20.r,
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )
                                          : Container(
                                              height: 130.w,
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorPallette.greyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                    ),
                                  ),
                                  5.verticalSpace,
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
