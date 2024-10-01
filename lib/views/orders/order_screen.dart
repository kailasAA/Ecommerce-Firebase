import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/cache_image.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
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
    context.read<OrderProvider>().getOrders();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPallette.scaffoldBgColor,
        body: Selector<OrderProvider,
            Tuple4<bool, List<OrderModel>, List<OrderModel>, List<DateTime?>>>(
          selector: (p0, p1) => Tuple4(p1.isLoading, p1.allOrderList,
              p1.filteredList, p1.selectedDateRange),
          builder: (context, value, child) {
            final orderList = value.item2;
            final isLoading = value.item1;
            final selectedDates = value.item4;
            return isLoading
                ? const LoadingAnimation()
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: 20.verticalSpace),
                      SliverToBoxAdapter(
                        child: TotalOrderDetails(orderList: orderList),
                      ),
                      SliverToBoxAdapter(child: 20.verticalSpace),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: CalendarDatePicker2WithActionButtons(
                            config: CalendarDatePicker2WithActionButtonsConfig(
                              weekdayLabelTextStyle:
                                  FontPallette.headingStyle.copyWith(
                                fontSize: 14.sp,
                                color: ColorPallette.darkGreyColor,
                              ),
                              daySplashColor: Colors.transparent,
                              animateToDisplayedMonthDate: true,
                              firstDayOfWeek: 1,
                              calendarType: CalendarDatePicker2Type.range,
                              lastDate: DateTime.now(),
                              monthTextStyle:
                                  FontPallette.headingStyle.copyWith(
                                fontSize: 14.sp,
                              ),
                              selectedYearTextStyle:
                                  FontPallette.headingStyle.copyWith(
                                fontSize: 14.sp,
                                color: ColorPallette.whiteColor,
                              ),
                              selectedMonthTextStyle:
                                  FontPallette.headingStyle.copyWith(
                                fontSize: 14.sp,
                                color: ColorPallette.whiteColor,
                              ),
                              yearTextStyle: FontPallette.headingStyle
                                  .copyWith(fontSize: 14.sp),
                              currentDate: DateTime.now(),
                              selectedDayTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              selectedDayHighlightColor: Colors.black,
                              centerAlignModePicker: true,
                              customModePickerIcon: const SizedBox(),
                              dayTextStyle: FontPallette.headingStyle
                                  .copyWith(fontSize: 12.sp),
                            ),
                            value: selectedDates,
                            onValueChanged: (dates) {
                              if (dates.isNotEmpty) {
                                print("${dates.first}");
                                print("${dates.last}");

                                orderProvider.updateDateRange(
                                    dates.first!, dates.last!);
                              }
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: 20.verticalSpace),
                      SliverList.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          final order = orderList[index];
                          return OrderDetailTile(
                              order: order, orderProvider: orderProvider);
                        },
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class TotalOrderDetails extends StatelessWidget {
  const TotalOrderDetails({
    super.key,
    required this.orderList,
  });

  final List<OrderModel> orderList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Container(
        padding: EdgeInsets.all(20.r),
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "No of orders : ${orderList.length}",
              style: FontPallette.headingStyle
                  .copyWith(color: ColorPallette.whiteColor, fontSize: 14.sp),
            ),
            10.verticalSpace,
            Text(
              "No of orders completed :",
              style: FontPallette.headingStyle
                  .copyWith(color: ColorPallette.whiteColor, fontSize: 14.sp),
            ),
            10.verticalSpace,
            Text(
              "No of orders pending :",
              style: FontPallette.headingStyle
                  .copyWith(color: ColorPallette.whiteColor, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailTile extends StatelessWidget {
  const OrderDetailTile({
    super.key,
    required this.order,
    required this.orderProvider,
  });

  final OrderModel order;
  final OrderProvider orderProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
      child: Container(
        padding: EdgeInsets.all(20.r),
        // height: 300.h,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15.r)),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Quantity : ${order.itemQuantity ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Catgeory : ${order.categoryName ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Brand : ${order.brandName ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Size : ${order.size ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Color : ${order.variantColor ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Name : ${order.orderedPersonName ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Place : ${order.place ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Adress : ${order.address ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
                      ),
                      5.verticalSpace,
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Date : ${order.orderDate ?? ""}",
                        style: FontPallette.headingStyle.copyWith(
                            color: ColorPallette.whiteColor, fontSize: 13.sp),
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
                          color: ColorPallette.whiteColor, fontSize: 13.sp),
                    ),
                    5.verticalSpace,
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Total Price : ${order.totalPrice ?? ""}",
                      style: FontPallette.headingStyle.copyWith(
                          color: ColorPallette.whiteColor, fontSize: 13.sp),
                    ),
                    5.verticalSpace,
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Discount : ${order.profit ?? ""}",
                      style: FontPallette.headingStyle.copyWith(
                          color: ColorPallette.whiteColor, fontSize: 13.sp),
                    ),
                    5.verticalSpace,
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Total Price : ${order.totalPrice ?? ""}",
                      style: FontPallette.headingStyle.copyWith(
                          color: ColorPallette.whiteColor, fontSize: 13.sp),
                    )
                  ],
                )
              ],
            ),
            15.verticalSpace,
            order.orderCompleted == true
                ? Row(
                    children: [
                      SimpleTextButton(
                        onTap: () {},
                        buttonColor: ColorPallette.greenColor,
                        buttonText: "Completed",
                        textColor: ColorPallette.whiteColor,
                      )
                    ],
                  )
                : Row(
                    children: [
                      SimpleTextButton(
                        onTap: () {
                          orderProvider.completeOrder(order.orderId ?? "");
                        },
                        buttonColor: ColorPallette.whiteColor,
                        textColor: ColorPallette.blackColor,
                        buttonText: "Mark Completed",
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class SimpleTextButton extends StatelessWidget {
  const SimpleTextButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    this.onTap,
  });
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Selector<OrderProvider, bool>(
        selector: (p0, p1) => p1.isLoading,
        builder: (context, isLoading, child) {
          return InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(10.r),
              height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: buttonColor,
              ),
              child: Center(
                  child: Text(
                buttonText,
                style: FontPallette.headingStyle
                    .copyWith(fontSize: 10.sp, color: textColor),
              )),
            ),
          );
        });
  }
}
