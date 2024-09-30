import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/route/argument_model/product_detail_arguments.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class HomeProductListWithHeading extends StatelessWidget {
  const HomeProductListWithHeading({
    super.key,
    this.productHeading,
    required this.products,
    required this.variantList,
    required this.categoryName,
  });
  final String? productHeading;
  final List<ProductModel> products;
  final List<Variant> variantList;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty && variantList.isNotEmpty
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
                      final variants = variantList.where(
                        (element) {
                          return element.productId == product.id;
                        },
                      ).toList();
                      final variant = variants[0];
                      return ProductTile(
                        product: product,
                        variant: variant,
                        categoryName: categoryName,
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

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.variant,
    this.height,
    this.width,
    this.imageHeigh,
    this.categoryName,
  });

  final ProductModel product;
  final Variant variant;
  final double? height;
  final double? width;
  final double? imageHeigh;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteGenerator.detailScreen,
            arguments: ProductDetailArguments(
                categoryName: categoryName,
                categoryId: product.categoryId ?? "",
                product: product));
      },
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: NeumorphicContainer(
          offset: const Offset(3, 3),
          blurRadius: 12.r,
          height: height ?? 210.h,
          width: width ?? 160.w,
          childWidget: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              children: [
                SizedBox(
                  height: imageHeigh ?? 130.w,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: (variant.imageUrlList ?? []).isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: variant.imageUrlList?[0] ?? "",
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) => Center(
                                child: LoadingAnimation(
                              size: 20.r,
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Container(
                            height: 130.w,
                            decoration: BoxDecoration(
                                color: ColorPallette.greyColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                  ),
                ),
                5.verticalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                      child: Text(
                        product.name ?? "",
                        style:
                            FontPallette.headingStyle.copyWith(fontSize: 13.sp),
                      ),
                    ),
                    // 10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.brandName ?? "",
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
  }
}
