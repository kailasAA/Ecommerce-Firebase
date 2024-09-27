import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/categories/view/widgets/add_category_button.dart';
import 'package:shoe_app/views/categories/view/widgets/catgeory_gridview.dart';
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
    final categoryProvider = context.read<CatgeoryProvider>();
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
                : CategoryGridview(categoryList: categoryList);
          },
        ),
        floatingActionButton:
            Selector<CatgeoryProvider, Tuple2<TextEditingController, bool>>(
          selector: (p0, p1) =>
              Tuple2(p1.categoryNameController, p1.addCatgeoryLoading),
          builder: (context, value, child) {
            final categoryNameController = value.item1;
            return AddNewCategoryButton(
                categoryNameController: categoryNameController,
                categoryProvider: categoryProvider);
          },
        ),
      ),
    );
  }
}
