
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/common_functions/dialog_box.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/gen/assets.gen.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/detail_page/models/size_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    this.variant,
    this.product,
    required this.variantList,
    this.selectedSize,
  });

  final Variant? variant;
  final ProductModel? product;
  final List<Variant> variantList;
  final SizeModel? selectedSize;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late final ProductDetailProvider provider;
  @override
  void initState() {
    provider = context.read<ProductDetailProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedSize = widget.selectedSize;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product?.name ?? "",
                style: FontPallette.headingStyle,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.editScreen,
                          arguments: ProductEditingArgments(
                              variant: widget.variant,
                              product: widget.product));
                    },
                    child: SizedBox(
                        height: 30.h,
                        width: 30.h,
                        child: SvgPicture.asset(Assets.editSvgrepoCom)),
                  ),
                  20.horizontalSpace,
                  InkWell(
                    onTap: () {
                      if (widget.variantList.length > 1) {
                        confirmationDialog(
                            onTap: () {
                              context
                                  .read<ProductDetailProvider>()
                                  .removeProduct(
                                      widget.variant?.variantId ?? "")
                                  .then(
                                (value) {
                                  provider
                                      .getVariants(widget.product?.id ?? "");

                                  provider.getProductDetails(
                                      widget.product?.id ?? "");
                                },
                              );
                              context.read<HomeProvider>().getAllProducts();
                              Navigator.of(context).pop();
                            },
                            context: context,
                            buttonText: "Remove",
                            content: "Do you want to delete this ?");
                      } else {
                        showToast("There should be atleast one variant");
                      }
                    },
                    child: SizedBox(
                        height: 30.h,
                        width: 30.h,
                        child: SvgPicture.asset(Assets.bagCrossSvgrepoCom)),
                  )
                ],
              )
            ],
          ),
          5.verticalSpace,
          Text(
            "Brand : ${widget.product?.brandName ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Color : ${widget.variant?.color ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Selling Price : ₹${selectedSize?.sellingPrice ?? "0"}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Recieving Price : ₹${selectedSize?.receivingPrice ?? "0"}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Discount Price : ₹${selectedSize?.discountPrice ?? "0"}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Stock : ${selectedSize?.stock ?? "0"}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          )
        ],
      ),
    );
  }
}