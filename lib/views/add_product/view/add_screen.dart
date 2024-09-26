import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/route/argument_model/add_product__arguments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/add_product/view/widgets/add_product_button.dart';
import 'package:shoe_app/views/add_product/view/widgets/add_product_image_picker.dart';
import 'package:shoe_app/views/add_product/view/widgets/add_product_text_fields.dart';
import 'package:shoe_app/views/add_product/view_model/add_product_provider.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({
    super.key,
    required this.addProductArguments,
  });

  final AddProductArguments addProductArguments;

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final addProductProvider = context.read<AddProductProvider>();

    return Scaffold(
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Consumer<AddProductProvider>(builder: (context, value, child) {
        final pickeImagelist = value.pickedfileList;
        final TextEditingController nameController = value.nameController;
        final TextEditingController colorController = value.colorController;
        final isNameValidated = value.isNameValidated;
        final isBrandValidate = value.isBrandValidated;
        final isColorValidate = value.isColorValidated;
        final TextEditingController brandController = value.brandController;
        bool isLoading = value.isLoading;

        return isLoading
            ? Center(
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child:
                      const Center(child: LoadingAnimationStaggeredDotsWave()),
                ),
              )
            : ListView(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<AddProductProvider>()
                                .clearControllers();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Text(
                        addProductArguments.categoryName ?? "",
                        style: FontPallette.headingStyle,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Column(
                    children: [
                      AddProductImagePicker(pickeImagelist: pickeImagelist),
                      20.verticalSpace,
                      AddProductTextFields(
                          nameController: nameController,
                          isNameValidated: isNameValidated,
                          colorController: colorController,
                          isColorValidate: isColorValidate,
                          brandController: brandController,
                          isBrandValidate: isBrandValidate),
                      30.verticalSpace,
                      AddProductButton(
                          pickeImagelist: pickeImagelist,
                          addProductProvider: addProductProvider,
                          colorController: colorController,
                          nameController: nameController,
                          brandController: brandController,
                          addProductArguments: addProductArguments,
                          homeProvider: homeProvider),
                      30.verticalSpace,
                    ],
                  )
                ],
              );
      }),
    );
  }
}
