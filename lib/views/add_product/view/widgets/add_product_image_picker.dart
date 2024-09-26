
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';

class AddProductImagePicker extends StatelessWidget {
  const AddProductImagePicker({
    super.key,
    required this.pickeImagelist,
  });

  final List<File> pickeImagelist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AddProductProvider>().selectMultipleImage();
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
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: pickeImagelist.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20.r),
                    child: NeumorphicContainer(
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
    );
  }
}