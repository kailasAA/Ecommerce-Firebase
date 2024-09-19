import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import '../../utils/font_pallette.dart';

void showAlertDialog(
    {required BuildContext context,
    required String headingText,
    required TextEditingController controller,
    required VoidCallback onAddCategory}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 100.h,
          width: 350.w,
          child: Column(
            children: [
              NuemorphicTextField(
                headingText: headingText,
                keyboardType: TextInputType.name,
                textEditingController: controller,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      onAddCategory();
                    }
                  },
                  child: NeumorphicContainer(
                      height: 40.h,
                      width: 100.w,
                      childWidget: Center(
                          child: Text(
                        'Save',
                        style:
                            FontPallette.headingStyle.copyWith(fontSize: 13.sp),
                      )))),
              20.horizontalSpace,
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: NeumorphicContainer(
                    height: 40.h,
                    width: 100.w,
                    childWidget: Center(
                        child: Text(
                      'Cancel',
                      style:
                          FontPallette.headingStyle.copyWith(fontSize: 13.sp),
                    ))),
              ),
            ],
          ),
        ],
      );
    },
  );
}
