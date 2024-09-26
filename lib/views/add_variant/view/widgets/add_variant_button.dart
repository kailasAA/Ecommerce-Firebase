
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';

class VariantAddButton extends StatelessWidget {
  const VariantAddButton({
    super.key,
    required this.colorController,
    required this.product,
    required this.detailPageProvider,
    required this.homeProvider,
    required this.addVariantProvider,
  });

  final TextEditingController colorController;
  final ProductModel? product;
  final ProductDetailProvider detailPageProvider;
  final HomeProvider homeProvider;
  final AddVariantProvider addVariantProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addVariantProvider
            .addProductVariant(colorController.text, product?.categoryId ?? "",
                product?.id ?? "")
            .then(
          (value) {
            detailPageProvider.getVariants(product?.id ?? "");
            homeProvider.getAllProducts();
            addVariantProvider.clearData();
          },
        );
      },
      child: NeumorphicContainer(
        height: 50.h,
        width: 120.h,
        childWidget: Center(
          child: Text(
            "Add",
            style: FontPallette.headingStyle.copyWith(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
