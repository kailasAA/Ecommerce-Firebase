import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_size/view_model/add_size_provider.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:tuple/tuple.dart';

class AddSizeScreen extends StatelessWidget {
  const AddSizeScreen({super.key, required this.productEditingArgments});
  final ProductEditingArgments productEditingArgments;
  @override
  Widget build(BuildContext context) {
    final TextEditingController sizeEditingController = TextEditingController();
    final TextEditingController recievingPriceEditingController =
        TextEditingController();
    final TextEditingController sellingPriceEditingController =
        TextEditingController();
    final TextEditingController discountPriceEditingController =
        TextEditingController();
    final TextEditingController stockEditingController =
        TextEditingController();

    return Selector<AddSizeProvider, Tuple6>(
      selector: (p0, p1) => Tuple6(
          p1.isLoading,
          p1.isSizeValidated,
          p1.isStockValidated,
          p1.isRecievingPriceValidated,
          p1.isSellingPriceValidated,
          p1.isDiscountPriceValidated),
      builder: (context, value, child) {
        final variant = productEditingArgments.variant;
        final product = productEditingArgments.product;
        final isLoading = value.item1;
        final isSizeValidated = value.item2;
        final isStockValidated = value.item3;
        final isRecievingPriceValidated = value.item4;
        final isSellingPriceValidated = value.item4;
        final isDiscountPriceValidated = value.item4;

        return Scaffold(
          backgroundColor: ColorPallette.scaffoldBgColor,
          appBar: AppBar(
            backgroundColor: ColorPallette.scaffoldBgColor,
            centerTitle: true,
            title: Text(
              "Add size",
              style: FontPallette.headingStyle,
            ),
          ),
          body: isLoading
              ? const LoadingAnimation()
              : Padding(
                  padding: EdgeInsets.all(15.r),
                  child: ListView(
                    children: [
                      NuemorphicTextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 2) {
                            context
                                .read<AddSizeProvider>()
                                .sizeValidation(value);
                          }
                        },
                        keyboardType: TextInputType.name,
                        textEditingController: sizeEditingController,
                        headingText: "Size",
                        hintText: "Enter size of product",
                      ),
                      8.verticalSpace,
                      !isSizeValidated
                          ? SizedBox(
                              height: 20.h,
                              child: Text(
                                "Please give a valid size",
                                style: FontPallette.subtitleStyle.copyWith(
                                    color: ColorPallette.redColor,
                                    fontSize: 10.sp),
                              ),
                            )
                          : SizedBox(
                              height: 20.h,
                            ),
                      NuemorphicTextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 2) {
                            context
                                .read<AddSizeProvider>()
                                .stockValidation(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        textEditingController: stockEditingController,
                        headingText: "Stock",
                        hintText: "Enter stock of product",
                      ),
                      8.verticalSpace,
                      !isStockValidated
                          ? SizedBox(
                              height: 20.h,
                              child: Text(
                                "Please give a valid price",
                                style: FontPallette.subtitleStyle.copyWith(
                                    color: ColorPallette.redColor,
                                    fontSize: 10.sp),
                              ),
                            )
                          : SizedBox(
                              height: 20.h,
                            ),
                      NuemorphicTextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 2) {
                            context
                                .read<AddSizeProvider>()
                                .receivingPriceValidation(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        textEditingController: recievingPriceEditingController,
                        headingText: "Recieving Price",
                        hintText: "Enter recieving price of product",
                      ),
                      8.verticalSpace,
                      !isRecievingPriceValidated
                          ? SizedBox(
                              height: 20.h,
                              child: Text(
                                "Please give a valid price",
                                style: FontPallette.subtitleStyle.copyWith(
                                    color: ColorPallette.redColor,
                                    fontSize: 10.sp),
                              ),
                            )
                          : SizedBox(
                              height: 20.h,
                            ),
                      NuemorphicTextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 2) {
                            context
                                .read<AddSizeProvider>()
                                .sellingPriceValidation(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        textEditingController: sellingPriceEditingController,
                        headingText: "Selling Price",
                        hintText: "Enter selling Price of product",
                      ),
                      8.verticalSpace,
                      !isSellingPriceValidated
                          ? SizedBox(
                              height: 20.h,
                              child: Text(
                                "Please give a valid price",
                                style: FontPallette.subtitleStyle.copyWith(
                                    color: ColorPallette.redColor,
                                    fontSize: 10.sp),
                              ),
                            )
                          : SizedBox(
                              height: 20.h,
                            ),
                      NuemorphicTextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 2) {
                            context
                                .read<AddSizeProvider>()
                                .discountPriceValidation(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        textEditingController: discountPriceEditingController,
                        headingText: "Discount price",
                        hintText: "Enter price of product",
                      ),
                      8.verticalSpace,
                      !isDiscountPriceValidated
                          ? SizedBox(
                              height: 20.h,
                              child: Text(
                                "Please give a valid price",
                                style: FontPallette.subtitleStyle.copyWith(
                                    color: ColorPallette.redColor,
                                    fontSize: 10.sp),
                              ),
                            )
                          : SizedBox(
                              height: 20.h,
                            ),
                      20.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          context.read<AddSizeProvider>().addSize(
                              discountPrice:
                                  discountPriceEditingController.text,
                              recievingPrice:
                                  recievingPriceEditingController.text,
                              sellingPrice: sellingPriceEditingController.text,
                              categoryId: product?.categoryId ?? "",
                              productId: product?.id ?? "",
                              size: sizeEditingController.text,
                              stock: stockEditingController.text,
                              variantID: variant?.variantId ?? "");
                          context
                              .read<ProductDetailProvider>()
                              .getVariants(product?.id ?? "");
                          context
                              .read<ProductDetailProvider>()
                              .getVariantDetails(variant?.variantId ?? "");
                          context.read<HomeProvider>().getAllProducts();
                          context.read<AddVariantProvider>().clearData();
                        },
                        child: NeumorphicContainer(
                          height: 50.h,
                          width: 120.h,
                          childWidget: Center(
                            child: Text(
                              "Add",
                              style: FontPallette.headingStyle
                                  .copyWith(fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
