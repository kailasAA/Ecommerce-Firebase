

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    super.key,
    required this.pickeImagelist,
    required this.addProductProvider,
    required this.colorController,
    required this.nameController,
    required this.brandController,
    required this.addProductArguments,
    required this.homeProvider,
  });

  final List<File> pickeImagelist;
  final AddProductProvider addProductProvider;
  final TextEditingController colorController;
  final TextEditingController nameController;
  final TextEditingController brandController;
  final AddProductArguments addProductArguments;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pickeImagelist.isNotEmpty) {
          addProductProvider.colorValidation(colorController.text);
          addProductProvider.nameValidation(nameController.text);
          addProductProvider.brandValidation(brandController.text);
          final isValidated = addProductProvider.isValidated();
          if (isValidated) {
            addProductProvider
                .addBaseProduct(
                    color: colorController.text,
                    brandName: brandController.text,
                    name: nameController.text,
                    categoryId: addProductArguments.categoryId ?? "",
                    categoryName: addProductArguments.categoryName ?? "")
                .then(
              (value) {
                homeProvider.getAllVariants();
              },
            );
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
    );
  }
}
