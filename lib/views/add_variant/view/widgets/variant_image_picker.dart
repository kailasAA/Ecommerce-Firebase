
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';

class VariantImagePicker extends StatelessWidget {
  const VariantImagePicker({
    super.key,
    required this.imageList,
  });

  final List<File> imageList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AddVariantProvider>().selectMultipleImage();
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
                        borderRadius:
                            BorderRadius.circular(15.r), // Rounded corners
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
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
    );
  }
}
