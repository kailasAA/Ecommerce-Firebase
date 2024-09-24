import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';

class AddVariantScreen extends StatelessWidget {
  const AddVariantScreen({super.key, required this.productEditingArgments});
  final ProductEditingArgments productEditingArgments;
  @override
  Widget build(BuildContext context) {
    final product = productEditingArgments.product;
    final variant = productEditingArgments.variant;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<AddVariantProvider>().clearData();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorPallette.scaffoldBgColor,
        centerTitle: true,
        title: Text(
          "Add Variant",
          style: FontPallette.headingStyle.copyWith(fontSize: 16.sp),
        ),
      ),
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Consumer<AddVariantProvider>(
        builder: (context, addVariantProvider, child) {
          final imageList = addVariantProvider.pickedfileList;
          final colorController = addVariantProvider.colorController;
          final isColorValidated = addVariantProvider.isColorValidated;
          final isLoading = addVariantProvider.isLoading;
          return isLoading
              ? const LoadingAnimation()
              : ListView(
                  children: [
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        context
                            .read<AddVariantProvider>()
                            .selectMultipleImage();
                      },
                      child: imageList.isEmpty
                          ? NeumorphicContainer(
                              blurRadius: 15.r,
                              offset: const Offset(5, 5),
                              height: 250.h,
                              width: 330.w,
                              childWidget: Icon(
                                Icons.add_a_photo_outlined,
                                size: 50.r,
                                color: ColorPallette.greyColor,
                              ))
                          : SizedBox(
                              height: 270.h,
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: imageList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(20.r),
                                    child: NeumorphicContainer(
                                      blurRadius: 15.r,
                                      offset: const Offset(2, 5),
                                      height: 250.h,
                                      width: 330.w,
                                      childWidget: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15.r), // Rounded corners
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          height: 230.h,
                                          width: 310.w,
                                          child: Image.file(
                                            imageList[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NuemorphicTextField(
                            onChanged: (value) {
                              if (value.isEmpty || value.length < 2) {
                                context
                                    .read<AddVariantProvider>()
                                    .colorValidation(value);
                              }
                            },
                            keyboardType: TextInputType.name,
                            textEditingController: colorController,
                            headingText: "Color",
                            hintText: "Enter color of product",
                          ),
                          8.verticalSpace,
                          !isColorValidated
                              ? SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    "Please give a valid name",
                                    style: FontPallette.subtitleStyle.copyWith(
                                        color: ColorPallette.redColor,
                                        fontSize: 10.sp),
                                  ),
                                )
                              : SizedBox(
                                  height: 20.h,
                                ),
                        ],
                      ),
                    ),
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        context.read<AddVariantProvider>().addProductVariant(
                            colorController.text,
                            product?.categoryId ?? "",
                            product?.id ?? "");
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
                    50.verticalSpace
                  ],
                );
        },
      ),
    );
  }
}
