import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/utils/font_pallette.dart';

import '../utils/color_pallette.dart';

class NuemorphicTextField extends StatelessWidget {
  const NuemorphicTextField({
    super.key,
    this.textEditingController,
    this.hintText,
    this.obscureText,
    this.prefixWidget,
    this.suffixWidget,
    this.headingText,
    this.keyboardType,
    this.textformFieldText,
    this.onChanged,
  });
  final TextEditingController? textEditingController;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String? headingText;
  final TextInputType? keyboardType;
  final String? textformFieldText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headingText ?? "",
          style: FontPallette.headingStyle.copyWith(fontSize: 15.sp),
        ),
        10.verticalSpace,
        Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-3, -3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(3, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Center(
            child: TextFormField(
              onChanged: onChanged,
              style: FontPallette.headingStyle
                  .copyWith(fontSize: 14.sp, color: ColorPallette.blackColor),
              // validator: validator,
              controller: textEditingController,
              keyboardType: keyboardType,
              cursorColor: ColorPallette.greyColor,
              cursorWidth: 3,
              decoration: InputDecoration(
                prefixIcon: prefixWidget,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                hintText: hintText ?? 'Enter text...',
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
