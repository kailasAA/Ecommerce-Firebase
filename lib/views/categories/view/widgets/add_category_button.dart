
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common/common_functions/show_alertdialougue.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/view_model.dart/catgeory_provider.dart';

class AddNewCategoryButton extends StatelessWidget {
  const AddNewCategoryButton({
    super.key,
    required this.categoryNameController,
    required this.categoryProvider,
  });

  final TextEditingController categoryNameController;
  final CatgeoryProvider categoryProvider;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      backgroundColor: ColorPallette.blackColor,
      onPressed: () {
        showAlertDialog(
          headingText: "Add new Category",
          context: context,
          controller: categoryNameController,
          onAddCategory: () {
            categoryProvider
                .addCategory(categoryName: categoryNameController.text)
                .then((_) {
              categoryProvider.getCategories();
              Navigator.of(context).pop();
            });
          },
        );
      },
      label: Text(
        'Add',
        style: FontPallette.headingStyle
            .copyWith(fontSize: 15.sp, color: ColorPallette.whiteColor),
      ),
      icon: Icon(Icons.add_circle_outline_outlined,
          color: Colors.white, size: 30.r),
    );
  }
}
