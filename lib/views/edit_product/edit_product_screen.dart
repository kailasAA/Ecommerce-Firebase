import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/common_widgets/textform_field.dart';
import 'package:shoe_app/gen/assets.gen.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/detail_page/detail_screen.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/edit_product/view_model/edit_product_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    super.key,
    required this.productEditingArgments,
  });
  final ProductEditingArgments productEditingArgments;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (timeStamp) {
        context.read<EditProductProvider>().fetchImageUrl(
            widget.productEditingArgments.variant?.imageUrlList ?? []);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productEditingArgments.product;
    final variant = widget.productEditingArgments.variant;
    TextEditingController colorController =
        TextEditingController(text: variant?.color ?? "");
    TextEditingController nameController =
        TextEditingController(text: product?.name ?? "");
    TextEditingController brandController =
        TextEditingController(text: product?.brandName ?? "");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product?.name ?? "",
          style: FontPallette.headingStyle,
        ),
        backgroundColor: ColorPallette.scaffoldBgColor,
      ),
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Consumer<EditProductProvider>(
        builder: (context, productEditingProvider, child) {
          return productEditingProvider.isLoading == false
              ? ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: SizedBox(
                        height: 300.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              productEditingProvider.imageUrlList.length + 1,
                          itemBuilder: (context, index) {
                            if (index ==
                                    productEditingProvider
                                        .imageUrlList.length ||
                                productEditingProvider.imageUrlList.isEmpty) {
                              return SizedBox(
                                height: 240.h,
                                width: 330.w,
                                child: Padding(
                                  padding: EdgeInsets.all(120.r),
                                  child: InkWell(
                                    onTap: () async {
                                      context
                                          .read<EditProductProvider>()
                                          .addNewMultipleImage();
                                    },
                                    child: SizedBox(
                                        height: 60.h,
                                        width: 60.w,
                                        child: SvgPicture.asset(
                                            Assets.galleryAddSvgrepoCom)),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Stack(
                                  children: [
                                    NeumorphicContainer(
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                      height: 240.h,
                                      width: 330.w,
                                      childWidget: SizedBox(
                                        height: 130.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: productEditingProvider
                                                    .imageUrlList[index] ??
                                                "",
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                            placeholder: (context, url) =>
                                                Center(
                                                    child: LoadingAnimation(
                                              size: 20.r,
                                            )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 35.h,
                                        right: 15.w,
                                        child: InkWell(
                                            onTap: () {
                                              confirmationDialog(
                                                  onTap: () {
                                                    print(
                                                        "removefunction is called");
                                                    context
                                                        .read<
                                                            EditProductProvider>()
                                                        .removeImageUrl(
                                                            index,
                                                            variant?.variantId ??
                                                                "");
                                                    Navigator.pop(context);
                                                  },
                                                  context: context,
                                                  buttonText: "Remove",
                                                  content:
                                                      "Do you want to remove the image ?");
                                            },
                                            child: SizedBox(
                                                height: 30.h,
                                                width: 30.h,
                                                child: SvgPicture.asset(Assets
                                                    .backspaceSvgrepoCom))))
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NuemorphicTextField(
                            onChanged: (value) {
                              if (value.isEmpty || value.length < 2) {
                                context
                                    .read<EditProductProvider>()
                                    .nameValidation(value);
                              }
                            },
                            keyboardType: TextInputType.name,
                            textEditingController: nameController,
                            headingText: "Name",
                            hintText: "Enter name of product",
                          ),
                          5.verticalSpace,
                          !productEditingProvider.isNameValidated
                              ? SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    "Please give a valid name",
                                    style: FontPallette.subtitleStyle.copyWith(
                                        color: ColorPallette.redColor,
                                        fontSize: 10.sp),
                                  ),
                                )
                              : SizedBox(
                                  height: 20.h,
                                ),
                          NuemorphicTextField(
                            onChanged: (value) {
                              if (value.isEmpty || value.length < 2) {
                                context
                                    .read<EditProductProvider>()
                                    .brandValidation(value);
                              }
                            },
                            keyboardType: TextInputType.name,
                            textEditingController: brandController,
                            headingText: "Brand Name",
                            hintText: "Enter name of Brand",
                          ),
                          5.verticalSpace,
                          !productEditingProvider.isBrandValidated
                              ? SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    "Please give a valid name",
                                    style: FontPallette.subtitleStyle.copyWith(
                                        color: ColorPallette.redColor,
                                        fontSize: 10.sp),
                                  ),
                                )
                              : SizedBox(
                                  height: 20.h,
                                ),
                          NuemorphicTextField(
                            onChanged: (value) {
                              if (value.isEmpty || value.length < 2) {
                                context
                                    .read<EditProductProvider>()
                                    .colourValidation(value);
                              }
                            },
                            keyboardType: TextInputType.name,
                            textEditingController: colorController,
                            headingText: "Color",
                            hintText: "Enter name of Color",
                          ),
                          5.verticalSpace,
                          !productEditingProvider.isColourValidated
                              ? SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    "Please give a valid color",
                                    style: FontPallette.subtitleStyle.copyWith(
                                        color: ColorPallette.redColor,
                                        fontSize: 10.sp),
                                  ),
                                )
                              : SizedBox(
                                  height: 20.h,
                                )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<EditProductProvider>().updateProduct(
                            ProductModel(
                              brandName: brandController.text,
                              categoryId: product?.categoryId ?? "",
                              categoryName: product?.categoryName ?? "",
                              id: product?.id ?? "",
                              name: nameController.text,
                            ),
                            product?.id ?? "");
                        context.read<EditProductProvider>().updateVariant(
                            Variant(
                              color: colorController.text,
                              productId: variant?.productId,
                              categoryId: variant?.categoryId ?? "",
                              categoryName: variant?.categoryName ?? "",
                              variantId: variant?.variantId ?? "",
                              imageUrlList: productEditingProvider.imageUrlList,
                            ),
                            variant?.variantId ?? "");
                        context
                            .read<ProductDetailProvider>()
                            .getProductDetails(variant?.productId ?? "");
                        context
                            .read<ProductDetailProvider>()
                            .getVariantDetails(variant?.variantId ?? "",variant);
                        context
                            .read<ProductDetailProvider>()
                            .getVariants(variant?.productId ?? "");

                        // context.read<HomeProvider>().getAllProducts();
                      },
                      child: NeumorphicContainer(
                        height: 50.h,
                        width: 120.h,
                        childWidget: Center(
                          child: Text(
                            "Update",
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                    50.verticalSpace
                  ],
                )
              : const LoadingAnimation();
        },
      ),
    );
  }
}
