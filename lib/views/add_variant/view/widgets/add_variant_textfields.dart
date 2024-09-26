
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';

class VariantTextFields extends StatelessWidget {
  const VariantTextFields({
    super.key,
    required this.colorController,
    required this.isColorValidated,
  });

  final TextEditingController colorController;
  final bool isColorValidated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NuemorphicTextField(
            onChanged: (value) {
              if (value.isEmpty || value.length < 2) {
                context.read<AddVariantProvider>().colorValidation(value);
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
                        color: ColorPallette.redColor, fontSize: 10.sp),
                  ),
                )
              : SizedBox(
                  height: 20.h,
                ),
        ],
      ),
    );
  }
}