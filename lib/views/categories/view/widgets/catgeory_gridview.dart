import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/common_functions/show_pop_up.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/categories/view_model.dart/catgeory_provider.dart';

class CategoryGridview extends StatelessWidget {
  const CategoryGridview({
    super.key,
    required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: categoryList.isNotEmpty
          ? GridView.builder(
              padding: EdgeInsets.only(top: 15.h),
              itemCount: categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onLongPressStart: (details) {
                  context.read<CatgeoryProvider>().changeSelectedCategory(
                      categoryList[index].categoryName ?? "");
                  showPopup(
                      context,
                      index,
                      details.globalPosition,
                      categoryList[index].id ?? "",
                      categoryList[index].categoryName ?? "");
                },
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteGenerator.addProductScreen,
                    arguments: AddProductArguments(
                      categoryId: categoryList[index].id ?? "",
                      categoryName: categoryList[index].categoryName,
                    ),
                  );
                },
                child: NeumorphicContainer(
                  offset: const Offset(5, 5),
                  blurRadius: 10.r,
                  width: 150.w,
                  childWidget: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            categoryList[index].categoryName ?? "",
                            maxLines: 2,
                            style: FontPallette.headingStyle.copyWith(
                              fontSize: 17.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                " No Category found add One",
                style: FontPallette.headingStyle.copyWith(fontSize: 15.sp),
              ),
            ),
    );
  }
}
