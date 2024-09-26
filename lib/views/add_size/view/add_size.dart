import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_size/view/widgets/add_size_textfields.dart';
import 'package:shoe_app/views/add_size/view_model/add_size_provider.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:tuple/tuple.dart';

class AddSizeScreen extends StatelessWidget {
  const AddSizeScreen({super.key, required this.productEditingArgments});
  final ProductEditingArgments productEditingArgments;

  @override
  Widget build(BuildContext context) {
    // final homeProvider = context.read<HomeProvider>();
    final detailPageProvider = context.read<ProductDetailProvider>();
    final addSizeProvider = context.read<AddSizeProvider>();
    final TextEditingController sizeEditingController = TextEditingController();
    final TextEditingController recievingPriceEditingController =
        TextEditingController();
    final TextEditingController sellingPriceEditingController =
        TextEditingController();
    final TextEditingController discountPriceEditingController =
        TextEditingController();
    final TextEditingController stockEditingController =
        TextEditingController();

    return Selector<AddSizeProvider, Tuple6>(
      selector: (p0, p1) => Tuple6(
          p1.isLoading,
          p1.isSizeValidated,
          p1.isStockValidated,
          p1.isRecievingPriceValidated,
          p1.isSellingPriceValidated,
          p1.isDiscountPriceValidated),
      builder: (context, value, child) {
        final variant = productEditingArgments.variant;
        final product = productEditingArgments.product;
        final isLoading = value.item1;
        final isSizeValidated = value.item2;
        final isStockValidated = value.item3;
        final isRecievingPriceValidated = value.item4;
        final isSellingPriceValidated = value.item4;
        final isDiscountPriceValidated = value.item4;

        return Scaffold(
          backgroundColor: ColorPallette.scaffoldBgColor,
          appBar: AppBar(
            backgroundColor: ColorPallette.scaffoldBgColor,
            centerTitle: true,
            title: Text(
              "Add size",
              style: FontPallette.headingStyle,
            ),
          ),
          body: isLoading
              ? const LoadingAnimation()
              : AddSizeTextFields(
                  sizeEditingController: sizeEditingController,
                  isSizeValidated: isSizeValidated,
                  stockEditingController: stockEditingController,
                  isStockValidated: isStockValidated,
                  recievingPriceEditingController:
                      recievingPriceEditingController,
                  isRecievingPriceValidated: isRecievingPriceValidated,
                  sellingPriceEditingController: sellingPriceEditingController,
                  isSellingPriceValidated: isSellingPriceValidated,
                  discountPriceEditingController:
                      discountPriceEditingController,
                  isDiscountPriceValidated: isDiscountPriceValidated,
                  addSizeProvider: addSizeProvider,
                  product: product,
                  variant: variant,
                  detailPageProvider: detailPageProvider),
        );
      },
    );
  }
}
