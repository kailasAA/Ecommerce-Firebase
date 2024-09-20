import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({
    super.key,
    required this.addProductArguments,
  });

  final AddProductArguments addProductArguments;

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Consumer<AddProductProvider>(builder: (context, value, child) {
        final pickeImagelist = value.pickedfileList;
        final TextEditingController nameController = value.nameController;
        final TextEditingController priceController = value.priceController;
        final TextEditingController sellingPriceController =
            value.sellingPriceController;
        final isNameValidated = value.isNameValidated;
        final isPriceValidate = value.isPriceValidated;
        final isBrandValidate = value.isBrandValidated;
        final isSellingPriceVlidated = value.isSellingPriceValidated;
        final TextEditingController brandController = value.brandController;
        bool isLoading = value.isLoading;

        return isLoading
            ? Center(
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child:
                      const Center(child: LoadingAnimationStaggeredDotsWave()),
                ),
              )
            : ListView(
                children: [
                  20.verticalSpace,
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<AddProductProvider>()
                                .clearControllers();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Text(
                        addProductArguments.categoryName ?? "",
                        style: FontPallette.headingStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AddProductProvider>()
                              .selectMultipleImage();
                        },
                        child: pickeImagelist.isEmpty
                            ? NeumorphicContainer(
                                height: 250.h,
                                width: 330.w,
                                childWidget:
                                    // pickeImage.isEmpty
                                    //     ?
                                    Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 50.r,
                                  color: ColorPallette.greyColor,
                                ))
                            : SizedBox(
                                height: 320.h,
                                child: ListView.builder(
                                  itemCount: pickeImagelist.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 10.r),
                                      child: NeumorphicContainer(
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
                                              pickeImagelist[index],
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
                      Form(
                        key: formkey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NuemorphicTextField(
                                onChanged: (value) {
                                  if (value.isEmpty || value.length < 2) {
                                    context
                                        .read<AddProductProvider>()
                                        .nameValidation(value);
                                  }
                                },
                                keyboardType: TextInputType.name,
                                textEditingController: nameController,
                                headingText: "Name",
                                hintText: "Enter name of product",
                              ),
                              5.verticalSpace,
                              !isNameValidated
                                  ? SizedBox(
                                      height: 20.h,
                                      child: Text(
                                        "Please give a valid name",
                                        style: FontPallette.subtitleStyle
                                            .copyWith(
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
                                        .read<AddProductProvider>()
                                        .priceValidation(value);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textEditingController: priceController,
                                headingText: "Price",
                                hintText: "Enter price of product",
                              ),
                              5.verticalSpace,
                              !isPriceValidate
                                  ? SizedBox(
                                      height: 20.h,
                                      child: Text(
                                        "Please give a valid price",
                                        style: FontPallette.subtitleStyle
                                            .copyWith(
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
                                        .read<AddProductProvider>()
                                        .sellingPriceValidation(value);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textEditingController: sellingPriceController,
                                headingText: "Selling Price",
                                hintText: "Enter price of product",
                              ),
                              5.verticalSpace,
                              !isSellingPriceVlidated
                                  ? SizedBox(
                                      height: 20.h,
                                      child: Text(
                                        "Please give a valid price",
                                        style: FontPallette.subtitleStyle
                                            .copyWith(
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
                                        .read<AddProductProvider>()
                                        .brandValidation(value);
                                  }
                                },
                                keyboardType: TextInputType.name,
                                textEditingController: brandController,
                                headingText: "Brand Name",
                                hintText: "Enter name of Brand",
                              ),
                              5.verticalSpace,
                              !isBrandValidate
                                  ? SizedBox(
                                      height: 20.h,
                                      child: Text(
                                        "Please give a valid name",
                                        style: FontPallette.subtitleStyle
                                            .copyWith(
                                                color: ColorPallette.redColor,
                                                fontSize: 10.sp),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 20.h,
                                    )
                            ],
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          if (pickeImagelist.isNotEmpty) {
                            context
                                .read<AddProductProvider>()
                                .nameValidation(nameController.text);
                            context
                                .read<AddProductProvider>()
                                .priceValidation(priceController.text);
                            context
                                .read<AddProductProvider>()
                                .sellingPriceValidation(
                                    sellingPriceController.text);
                            context
                                .read<AddProductProvider>()
                                .brandValidation(brandController.text);
                            final isValidated = context
                                .read<AddProductProvider>()
                                .isValidated();
                            if (isValidated) {
                              print("form is validated");
                              context.read<AddProductProvider>().addBaseProduct(
                                  brandName: brandController.text,
                                  name: nameController.text,
                                  price: priceController.text.toString(),
                                  sellingPrice:
                                      sellingPriceController.text.toString(),
                                  categoryId: addProductArguments.categoryId,
                                  categoryName:
                                      addProductArguments.categoryName ?? "");
                            } else {
                              print("not validated");
                            }
                          } else {
                            showToast("Please select a image",
                                toastColor: ColorPallette.redColor);
                          }
                        },
                        child: NeumorphicContainer(
                          height: 50.h,
                          width: 150.w,
                          childWidget: Center(
                            child: Text(
                              "Add Product",
                              style: FontPallette.bodyStyle.copyWith(
                                  color: ColorPallette.blackColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                    ],
                  )
                ],
              );
      }),
    );
  }
}
