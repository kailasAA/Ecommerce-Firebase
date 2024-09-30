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
    final updatingSize = productEditingArgments.size;
    bool isUpdating = productEditingArgments.size != null;
    final detailPageProvider = context.read<ProductDetailProvider>();
    final addSizeProvider = context.read<AddSizeProvider>();
    final TextEditingController sizeEditingController = TextEditingController(
        text: updatingSize != null ? updatingSize.size : "");
    final TextEditingController recievingPriceEditingController =
        TextEditingController(
            text: updatingSize != null ? updatingSize.receivingPrice : "");
    final TextEditingController sellingPriceEditingController =
        TextEditingController(
            text: updatingSize != null ? updatingSize.sellingPrice : "");
    final TextEditingController discountPriceEditingController =
        TextEditingController(
            text: updatingSize != null ? updatingSize.discountPrice : "");
    final TextEditingController stockEditingController = TextEditingController(
        text: updatingSize != null ? updatingSize.stock : "");

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
        final isSellingPriceValidated = value.item5;
        final isDiscountPriceValidated = value.item6;

        return Scaffold(
          backgroundColor: ColorPallette.scaffoldBgColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  addSizeProvider.reset();
                },
                icon: const Icon(Icons.arrow_back)),
            backgroundColor: ColorPallette.scaffoldBgColor,
            centerTitle: true,
            title: Text(
              updatingSize == null
                  ? "Add Size and Details"
                  : "Update Size and Details",
              style: FontPallette.headingStyle,
            ),
          ),
          body: isLoading
              ? const LoadingAnimation()
              : AddSizeTextFields(
                  updatingSize: updatingSize,
                  isUpdating: isUpdating,
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
