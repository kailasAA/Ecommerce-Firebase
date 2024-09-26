
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_variant/view_model/add_variant_provider.dart';
import 'package:shoe_app/views/add_variant/view/widgets/add_variant_button.dart';
import 'package:shoe_app/views/add_variant/view/widgets/add_variant_textfields.dart';
import 'package:shoe_app/views/add_variant/view/widgets/variant_image_picker.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';

class AddVariantScreen extends StatelessWidget {
  const AddVariantScreen({super.key, required this.productEditingArgments});
  final ProductEditingArgments productEditingArgments;
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final detailPageProvider = context.read<ProductDetailProvider>();
    final product = productEditingArgments.product;
    final addVariantProvider = context.read<AddVariantProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              addVariantProvider.clearData();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorPallette.scaffoldBgColor,
        centerTitle: true,
        title: Text(
          "Add Variant",
          style: FontPallette.headingStyle.copyWith(fontSize: 16.sp),
        ),
      ),
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Consumer<AddVariantProvider>(
        builder: (context, addVariantProvider, child) {
          final imageList = addVariantProvider.pickedfileList;
          final colorController = addVariantProvider.colorController;
          final isColorValidated = addVariantProvider.isColorValidated;
          final isLoading = addVariantProvider.isLoading;
          return isLoading
              ? const LoadingAnimation()
              : ListView(
                  children: [
                    20.verticalSpace,
                    VariantImagePicker(imageList: imageList),
                    20.verticalSpace,
                    VariantTextFields(
                        colorController: colorController,
                        isColorValidated: isColorValidated),
                    10.verticalSpace,
                    VariantAddButton(
                        addVariantProvider: addVariantProvider,
                        colorController: colorController,
                        product: product,
                        detailPageProvider: detailPageProvider,
                        homeProvider: homeProvider),
                    50.verticalSpace
                  ],
                );
        },
      ),
    );
  }
}

