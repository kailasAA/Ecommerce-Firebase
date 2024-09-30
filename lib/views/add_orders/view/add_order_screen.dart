import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/route/argument_model/add_order_arguments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_orders/model/order_model.dart';
import 'package:shoe_app/views/add_orders/view_model/order_provider.dart';
import 'package:intl/intl.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key, required this.addOrderArguments});
  final AddOrderArguments addOrderArguments;
  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    final detailPageProvider = context.read<ProductDetailProvider>();
    final product = addOrderArguments.product;
    final variant = addOrderArguments.variant;
    final sizeDetails = addOrderArguments.size;
    final categoryName = addOrderArguments.categoryName;
    final TextEditingController orderQuantityTextController =
        TextEditingController();
    final TextEditingController sellingPriceTextController =
        TextEditingController();
    final TextEditingController profitTextController = TextEditingController();
    final TextEditingController nameTextController = TextEditingController();
    final TextEditingController phoneNoTextController = TextEditingController();
    final TextEditingController placeTextController = TextEditingController();
    final TextEditingController districtTextController =
        TextEditingController();
    final TextEditingController stateTextController = TextEditingController();
    final TextEditingController adressTextController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorPallette.scaffoldBgColor,
        centerTitle: true,
        title: Text(
          "Add Order",
          style: FontPallette.headingStyle,
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          final isLoading = provider.isLoading;
          final isQuantityValidated = provider.isQuantityValidated;
          final isSellingPriceValidated = provider.isSellingPriceValidated;
          final isProfitPriceValidated = provider.isProfitPriceValidated;
          final isNameValidated = provider.isNameValidated;
          final isPhoneNoValidated = provider.isPhoneNoValidated;
          final isPlaceValidated = provider.isPlaceValidated;
          final isDistrictValidated = provider.isDistrictValidated;
          final isStateValidated = provider.isStateValidated;
          final isAdressValidated = provider.isAdressValidated;
          return isLoading
              ? const LoadingAnimation()
              : ListView(
                  padding: EdgeInsets.all(20.r),
                  children: [
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.production_quantity_limits,
                        size: 20.r,
                      ),
                      headingText: "Quantity",
                      hintText: "Enter the quantity of the product",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          orderProvider.quantityValidation(true);
                        } else {
                          orderProvider.quantityValidation(false);
                        }
                      },
                      textEditingController: orderQuantityTextController,
                    ),
                    5.verticalSpace,
                    !isQuantityValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid quantity",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.currency_rupee_rounded,
                        size: 20.r,
                      ),
                      headingText: "Selling Price",
                      hintText: "Enter the selling price of the product",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 1) {
                          orderProvider.sellingPriceValidation(true);
                        } else {
                          orderProvider.sellingPriceValidation(false);
                        }
                      },
                      textEditingController: sellingPriceTextController,
                    ),
                    5.verticalSpace,
                    !isSellingPriceValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid price",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.currency_rupee_rounded,
                        size: 20.r,
                      ),
                      headingText: "Profit",
                      hintText: "Enter the profit of the product",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 1) {
                          orderProvider.profitPriceValidation(true);
                        } else {
                          orderProvider.profitPriceValidation(false);
                        }
                      },
                      textEditingController: profitTextController,
                    ),
                    5.verticalSpace,
                    !isProfitPriceValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid price",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.person,
                        size: 20.r,
                      ),
                      headingText: "Name",
                      hintText: "Enter the name of the person",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 3) {
                          orderProvider.nameValidation(true);
                        } else {
                          orderProvider.nameValidation(false);
                        }
                      },
                      textEditingController: nameTextController,
                    ),
                    5.verticalSpace,
                    !isNameValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid name",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.phone,
                        size: 20.r,
                      ),
                      headingText: "Phone No",
                      hintText: "Enter the contact number",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length == 10) {
                          orderProvider.phoneNoValidation(true);
                        } else {
                          orderProvider.phoneNoValidation(false);
                        }
                      },
                      textEditingController: phoneNoTextController,
                    ),
                    5.verticalSpace,
                    !isPhoneNoValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid number",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.location_on,
                        size: 20.r,
                      ),
                      headingText: "Place",
                      hintText: "Enter the place of the person",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 3) {
                          orderProvider.placeValidation(true);
                        } else {
                          orderProvider.placeValidation(false);
                        }
                      },
                      textEditingController: placeTextController,
                    ),
                    5.verticalSpace,
                    !isPlaceValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid place",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.place,
                        size: 20.r,
                      ),
                      headingText: "District",
                      hintText: "Enter the district of the person",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 3) {
                          orderProvider.districtValidation(true);
                        } else {
                          orderProvider.districtValidation(false);
                        }
                      },
                      textEditingController: districtTextController,
                    ),
                    5.verticalSpace,
                    !isDistrictValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid district",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.place,
                        size: 20.r,
                      ),
                      headingText: "State",
                      hintText: "Enter the state of the person",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 3) {
                          orderProvider.stateValidation(true);
                        } else {
                          orderProvider.stateValidation(false);
                        }
                      },
                      textEditingController: stateTextController,
                    ),
                    5.verticalSpace,
                    !isStateValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid state",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    NuemorphicTextField(
                      prefixWidget: Icon(
                        Icons.home,
                        size: 20.r,
                      ),
                      headingText: "Adress",
                      hintText: "Enter the adress of the person",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        if (val.isNotEmpty && val.length > 3) {
                          orderProvider.adressValidation(true);
                        } else {
                          orderProvider.adressValidation(false);
                        }
                      },
                      textEditingController: adressTextController,
                    ),
                    5.verticalSpace,
                    !isAdressValidated
                        ? SizedBox(
                            height: 20.h,
                            child: Text(
                              "Please give a valid adress",
                              style: FontPallette.subtitleStyle.copyWith(
                                  color: ColorPallette.redColor,
                                  fontSize: 9.sp),
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    15.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        final DateTime now = DateTime.now();
                        final String formattedDate =
                            DateFormat('dd-MM-yyyy').format(now);
                        orderProvider.addOrders(
                          OrderModel(
                            orderCompleted: false,
                            sizeId: sizeDetails?.sizeId ?? "",
                            state: stateTextController.text,
                            soldPrice: sellingPriceTextController.text,
                            variantId: variant?.variantId ?? "",
                            variantColor: variant?.color ?? "",
                            totalPrice: (int.parse(
                                        orderQuantityTextController.text) *
                                    (double.tryParse(
                                            sellingPriceTextController.text) ??
                                        0))
                                .toString(),
                            productId: product?.id ?? "",
                            receivedPrice: sizeDetails?.receivingPrice ?? "",
                            size: sizeDetails?.size ?? "",
                            place: placeTextController.text,
                            orderDate: formattedDate,
                            address: adressTextController.text,
                            brandName: product?.brandName ?? "",
                            categoryId: sizeDetails?.categoryId,
                            categoryName: addOrderArguments.categoryName,
                            district: districtTextController.text,
                            imageUrl: (variant?.imageUrlList ?? [])[0],
                            itemQuantity: orderQuantityTextController.text,
                            orderedPersonName: nameTextController.text,
                            phoneNumber: phoneNoTextController.text,
                            productName: product?.name,
                            profit: profitTextController.text,
                          ),
                        );
                        detailPageProvider
                            .updateStock(
                                int.parse(sizeDetails?.stock ?? "0") -
                                    int.parse(orderQuantityTextController.text),
                                sizeDetails?.sizeId ?? "")
                            .then(
                          (value) {
                            detailPageProvider.getSizes();
                          },
                        );
                        orderQuantityTextController.clear();
                        sellingPriceTextController.clear();
                        profitTextController.clear();
                        nameTextController.clear();
                        phoneNoTextController.clear();
                        placeTextController.clear();
                        districtTextController.clear();
                        stateTextController.clear();
                        adressTextController.clear();
                      },
                      child: NeumorphicContainer(
                        height: 50.h,
                        width: 130.w,
                        childWidget: Center(
                          child: Text(
                            "Add Order",
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 13.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
