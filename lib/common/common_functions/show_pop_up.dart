
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/common_functions/show_alertdialougue.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/view_model.dart/catgeory_provider.dart';

void showPopup(BuildContext context, int index, Offset tapPosition,
    String categoryId, String categoryName) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(tapPosition, tapPosition),
    Offset.zero & overlay.size,
  );

  showMenu(
    popUpAnimationStyle: AnimationStyle(
        curve: Curves.ease, duration: const Duration(milliseconds: 300)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    context: context,
    position: position,
    items: [
      PopupMenuItem(
        value: 1,
        child: Selector<CatgeoryProvider, TextEditingController?>(
          selector: (p0, p1) => p1.categoryEditingController,
          builder: (context, value, child) {
            return Center(
                child: GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                      showAlertDialog(
                        context: context,
                        controller: value!,
                        headingText: "Update Category",
                        onAddCategory: () {
                          context
                              .read<CatgeoryProvider>()
                              .updateCategory(value.text, categoryId);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          10.horizontalSpace,
                          Text(
                            "Edit",
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    )));
          },
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.read<CatgeoryProvider>().deleteCategory(categoryId);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    children: [
                      const Icon(Icons.delete),
                      10.horizontalSpace,
                      Text(
                        'Delete',
                        style:
                            FontPallette.headingStyle.copyWith(fontSize: 13.sp),
                      ),
                    ],
                  ),
                ))),
      ),
    ],
  ).then((value) {
    if (value != null) {
    }
  });
}
