import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/cache_image.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_orders/model/order_model.dart';
import 'package:shoe_app/views/add_orders/view_model/order_provider.dart';
import 'package:tuple/tuple.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<OrderProvider>().getOrders();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPallette.scaffoldBgColor,
        body: Selector<OrderProvider,
            Tuple3<bool, List<OrderModel>, List<OrderModel>>>(
          selector: (p0, p1) =>
              Tuple3(p1.isLoading, p1.allOrderList, p1.filteredList),
          builder: (context, value, child) {
            final orderList = value.item2;
            final isLoading = value.item1;
            return Padding(
              padding: EdgeInsets.all(15.r),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: 20.verticalSpace),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.black),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No of orders :",
                            style: FontPallette.headingStyle.copyWith(
                                color: ColorPallette.whiteColor,
                                fontSize: 14.sp),
                          ),
                          10.verticalSpace,
                          Text(
                            "No of orders completed :",
                            style: FontPallette.headingStyle.copyWith(
                                color: ColorPallette.whiteColor,
                                fontSize: 14.sp),
                          ),
                          10.verticalSpace,
                          Text(
                            "No of orders pending :",
                            style: FontPallette.headingStyle.copyWith(
                                color: ColorPallette.whiteColor,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: 20.verticalSpace),
                  SliverToBoxAdapter(
                    child: CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                            weekdayLabelTextStyle: FontPallette.headingStyle
                                .copyWith(
                                    fontSize: 14.sp,
                                    color: ColorPallette.darkGreyColor),
                            daySplashColor: Colors.transparent,
                            animateToDisplayedMonthDate: true,
                            firstDayOfWeek: 1,
                            calendarType: CalendarDatePicker2Type.range,
                            lastDate: DateTime.now(),
                            monthTextStyle: FontPallette.headingStyle
                                .copyWith(fontSize: 14.sp),
                            selectedYearTextStyle: FontPallette.headingStyle
                                .copyWith(
                                    fontSize: 14.sp,
                                    color: ColorPallette.whiteColor),
                            selectedMonthTextStyle: FontPallette.headingStyle
                                .copyWith(
                                    fontSize: 14.sp,
                                    color: ColorPallette.whiteColor),
                            yearTextStyle: FontPallette.headingStyle
                                .copyWith(fontSize: 14.sp),
                            currentDate: DateTime.now(),
                            selectedDayTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            selectedDayHighlightColor:
                                const Color.fromARGB(255, 0, 0, 0),
                            centerAlignModePicker: true,
                            customModePickerIcon: const SizedBox(),
                            dayTextStyle: FontPallette.headingStyle
                                .copyWith(fontSize: 12.sp)),
                        value: [DateTime.now()],
                        onValueChanged: (value) {
                          if (value.isNotEmpty) {
                            print('Start date: ${value.first}');
                            print('End date: ${value.last}');
                          }
                        }),
                  ),
                  SliverToBoxAdapter(child: 30.verticalSpace),
                  SliverList.separated(
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      final order = orderList[index];
                      return Container(
                        padding: EdgeInsets.all(20.r),
                        height: 300.h,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.productName ?? "",
                              style: FontPallette.headingStyle
                                  .copyWith(color: ColorPallette.whiteColor),
                            ),
                            15.verticalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Quantity : ${order.itemQuantity ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Catgeory : ${order.categoryName ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Brand : ${order.brandName ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Size : ${order.size ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Color : ${order.variantColor ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Name : ${order.orderedPersonName ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Place : ${order.place ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Adress : ${order.address ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Date : ${order.orderDate ?? ""}",
                                        style: FontPallette.headingStyle
                                            .copyWith(
                                                color: ColorPallette.whiteColor,
                                                fontSize: 13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CacheImageNetwork(
                                        imageUrl: order.imageUrl ?? "",
                                        height: 100.h,
                                        width: 150.w),
                                    15.verticalSpace,
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Price : ${order.soldPrice ?? ""}",
                                      style: FontPallette.headingStyle.copyWith(
                                          color: ColorPallette.whiteColor,
                                          fontSize: 13.sp),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Total Price : ${order.totalPrice ?? ""}",
                                      style: FontPallette.headingStyle.copyWith(
                                          color: ColorPallette.whiteColor,
                                          fontSize: 13.sp),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Discount : ${order.profit ?? ""}",
                                      style: FontPallette.headingStyle.copyWith(
                                          color: ColorPallette.whiteColor,
                                          fontSize: 13.sp),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Total Price : ${order.totalPrice ?? ""}",
                                      style: FontPallette.headingStyle.copyWith(
                                          color: ColorPallette.whiteColor,
                                          fontSize: 13.sp),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 10.verticalSpace,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
