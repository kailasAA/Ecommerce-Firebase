
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/utils/font_pallette.dart';

void confirmationDialog(
    {required BuildContext context,
    String? heading,
    String? content,
    required buttonText,
    void Function()? onTap}) {
  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 30.h,
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: AlertDialog(
            // title: Text(heading ?? ""),
            content: Text(
              content ?? "",
              style: FontPallette.headingStyle.copyWith(fontSize: 15.sp),
            ),

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: onTap,
                      child: NeumorphicContainer(
                          height: 40.h,
                          width: 100.w,
                          childWidget: Center(
                              child: Text(
                            buttonText,
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 13.sp),
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
                          style: FontPallette.headingStyle
                              .copyWith(fontSize: 13.sp),
                        ))),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
