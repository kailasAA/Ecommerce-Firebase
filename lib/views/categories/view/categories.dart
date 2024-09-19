import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/common_functions/show_alertdialougue.dart';
import 'package:shoe_app/common/common_functions/show_pop_up.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/categories/view_model.dart/catgeory_provider.dart';
import 'package:tuple/tuple.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CatgeoryProvider>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPallette.scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: ColorPallette.scaffoldBgColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Categories", style: FontPallette.headingStyle),
        ),
        body: Selector<CatgeoryProvider, Tuple2<bool, List<CategoryModel>>>(
          selector: (context, provider) =>
              Tuple2(provider.getCategoryLoading, provider.categoryList),
          builder: (context, value, child) {
            final isLoading = value.item1;
            final categoryList = value.item2;
            return isLoading
                ? Center(
                    child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: const LoadingAnimationStaggeredDotsWave()))
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: categoryList.isNotEmpty
                        ? GridView.builder(
                            itemCount: categoryList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onLongPressStart: (details) {
                                context
                                    .read<CatgeoryProvider>()
                                    .changeSelectedCategory(
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
                                    categoryName:
                                        categoryList[index].categoryName,
                                  ),
                                );
                              },
                              child: NeumorphicContainer(
                                width: 150.w,
                                childWidget: Padding(
                                  padding: EdgeInsets.all(10.r),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          categoryList[index].categoryName ??
                                              "",
                                          maxLines: 2,
                                          style: FontPallette.headingStyle
                                              .copyWith(
                                            fontSize: 18.sp,
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
                              style: FontPallette.headingStyle
                                  .copyWith(fontSize: 15.sp),
                            ),
                          ),
                  );
          },
        ),
        floatingActionButton:
            Selector<CatgeoryProvider, Tuple2<TextEditingController, bool>>(
          selector: (p0, p1) =>
              Tuple2(p1.categoryNameController, p1.addCatgeoryLoading),
          builder: (context, value, child) {
            final categoryNameController = value.item1;
            // final isLoading = value.item2;

            return FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r)),
              backgroundColor: ColorPallette.blackColor,
              onPressed: () {
                showAlertDialog(
                  headingText: "Add new Category",
                  context: context,
                  controller: categoryNameController,
                  onAddCategory: () {
                    context
                        .read<CatgeoryProvider>()
                        .addCategory(categoryName: categoryNameController.text)
                        .then((_) {
                      context.read<CatgeoryProvider>().getCategories();
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
          },
        ),
      ),
    );
  }
}
