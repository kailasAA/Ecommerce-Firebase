import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_size/view/widgets/add_size_button.dart';

import 'package:shoe_app/views/add_size/view_model/add_size_provider.dart';
import 'package:shoe_app/views/detail_page/models/size_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class AddSizeTextFields extends StatelessWidget {
  const AddSizeTextFields({
    super.key,
    required this.sizeEditingController,
    required this.isSizeValidated,
    required this.stockEditingController,
    required this.isStockValidated,
    required this.recievingPriceEditingController,
    required this.isRecievingPriceValidated,
    required this.sellingPriceEditingController,
    required this.isSellingPriceValidated,
    required this.discountPriceEditingController,
    required this.isDiscountPriceValidated,
    required this.addSizeProvider,
    required this.product,
    required this.variant,
    required this.detailPageProvider,
    required this.isUpdating,
    this.updatingSize,
  });

  final TextEditingController sizeEditingController;
  final dynamic isSizeValidated;
  final TextEditingController stockEditingController;
  final dynamic isStockValidated;
  final TextEditingController recievingPriceEditingController;
  final dynamic isRecievingPriceValidated;
  final TextEditingController sellingPriceEditingController;
  final dynamic isSellingPriceValidated;
  final TextEditingController discountPriceEditingController;
  final dynamic isDiscountPriceValidated;
  final AddSizeProvider addSizeProvider;
  final ProductModel? product;
  final Variant? variant;
  final ProductDetailProvider detailPageProvider;
  final bool isUpdating;

  final SizeModel ?updatingSize;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      children: [
        15.verticalSpace,
        NuemorphicTextField(
          onChanged: (value) {
            if (value.isEmpty || value.length < 2) {
              context.read<AddSizeProvider>().sizeValidation(value);
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
                  style: FontPallette.subtitleStyle
                      .copyWith(color: ColorPallette.redColor, fontSize: 10.sp),
                ),
              )
            : SizedBox(
                height: 20.h,
              ),
        NuemorphicTextField(
          onChanged: (value) {
            if (value.isEmpty || value.length < 2) {
              context.read<AddSizeProvider>().stockValidation(value);
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
                  style: FontPallette.subtitleStyle
                      .copyWith(color: ColorPallette.redColor, fontSize: 10.sp),
                ),
              )
            : SizedBox(
                height: 20.h,
              ),
        NuemorphicTextField(
          onChanged: (value) {
            if (value.isEmpty || value.length < 2) {
              context.read<AddSizeProvider>().receivingPriceValidation(value);
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
                  style: FontPallette.subtitleStyle
                      .copyWith(color: ColorPallette.redColor, fontSize: 10.sp),
                ),
              )
            : SizedBox(
                height: 20.h,
              ),
        NuemorphicTextField(
          onChanged: (value) {
            if (value.isEmpty || value.length < 2) {
              context.read<AddSizeProvider>().sellingPriceValidation(value);
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
                  style: FontPallette.subtitleStyle
                      .copyWith(color: ColorPallette.redColor, fontSize: 10.sp),
                ),
              )
            : SizedBox(
                height: 20.h,
              ),
        NuemorphicTextField(
          onChanged: (value) {
            if (value.isEmpty || value.length < 2) {
              context.read<AddSizeProvider>().discountPriceValidation(value);
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
                  style: FontPallette.subtitleStyle
                      .copyWith(color: ColorPallette.redColor, fontSize: 10.sp),
                ),
              )
            : SizedBox(
                height: 20.h,
              ),
        20.verticalSpace,
        AddSizeButton(
            updatingSize: updatingSize,
            isUpdating: isUpdating,
            addSizeProvider: addSizeProvider,
            discountPriceEditingController: discountPriceEditingController,
            recievingPriceEditingController: recievingPriceEditingController,
            sellingPriceEditingController: sellingPriceEditingController,
            product: product,
            sizeEditingController: sizeEditingController,
            stockEditingController: stockEditingController,
            variant: variant,
            detailPageProvider: detailPageProvider),
      ],
    );
  }
}
