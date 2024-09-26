
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_size/view_model/add_size_provider.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class AddSizeButton extends StatelessWidget {
  const AddSizeButton({
    super.key,
    required this.addSizeProvider,
    required this.discountPriceEditingController,
    required this.recievingPriceEditingController,
    required this.sellingPriceEditingController,
    required this.product,
    required this.sizeEditingController,
    required this.stockEditingController,
    required this.variant,
    required this.detailPageProvider,
  });

  final AddSizeProvider addSizeProvider;
  final TextEditingController discountPriceEditingController;
  final TextEditingController recievingPriceEditingController;
  final TextEditingController sellingPriceEditingController;
  final ProductModel? product;
  final TextEditingController sizeEditingController;
  final TextEditingController stockEditingController;
  final Variant? variant;
  final ProductDetailProvider detailPageProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addSizeProvider
            .addSize(
                discountPrice: discountPriceEditingController.text,
                recievingPrice: recievingPriceEditingController.text,
                sellingPrice: sellingPriceEditingController.text,
                categoryId: product?.categoryId ?? "",
                productId: product?.id ?? "",
                size: sizeEditingController.text,
                stock: stockEditingController.text,
                variantID: variant?.variantId ?? "")
            .then(
          (value) {
            detailPageProvider.getVariants(product?.id ?? "");
            detailPageProvider.getVariantDetails(
                variant?.variantId ?? "", variant);
            detailPageProvider.getSizes();
          },
        );
        // context.read<HomeProvider>().getAllProducts();
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
