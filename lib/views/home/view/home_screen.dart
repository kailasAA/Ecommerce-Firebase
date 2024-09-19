import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/categories/models/category_model.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeProvider>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Selector<HomeProvider, Tuple2>(
        selector: (p0, p1) {
          return Tuple2(p1.categoryList, p1.isLoading);
        },
        builder: (context, value, child) {
          final isLoading = value.item2;
          List<CategoryModel> categoryList = value.item1;

          return isLoading
              ? const LoadingAnimationStaggeredDotsWave()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          80.verticalSpace,
                          NeumorphicContainer(
                            height: 200.h,
                            width: 320.w,
                          ),
                          30.verticalSpace,
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Column(
                            children: [
                              HomeProductListWithHeading(
                                productHeading:
                                    categoryList[index].categoryName,
                              ),
                              30.verticalSpace,
                            ],
                          );
                        },
                        childCount: categoryList.length,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class HomeProductListWithHeading extends StatelessWidget {
  const HomeProductListWithHeading({
    super.key,
    this.productHeading,
  });
  final String? productHeading;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            productHeading ?? "",
            style: FontPallette.headingStyle,
          ),
        ),
        10.verticalSpace,
        SizedBox(
          height: 240.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.r),
                  child: NeumorphicContainer(
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                    height: 220.h,
                    width: 160.w,
                    childWidget: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 130.w,
                            width: 140.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.black),
                          ),
                          5.verticalSpace,
                          Text(
                            "Product Name",
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 13.sp),
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price",
                                style: FontPallette.headingStyle
                                    .copyWith(fontSize: 13.sp),
                              ),
                              Text(
                                "Size",
                                style: FontPallette.headingStyle
                                    .copyWith(fontSize: 13.sp),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              // separatorBuilder: (context, index) => 20.horizontalSpace,
              itemCount: 10),
        ),
      ],
    );
  }
}
