import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/gen/assets.gen.dart';
import 'package:shoe_app/route/argument_model/product_detail_arguments.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/detail_page/models/size_model.dart';
import 'package:shoe_app/views/detail_page/models/variant_model.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:tuple/tuple.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productDetailArguments});

  final ProductDetailArguments productDetailArguments;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final ProductDetailProvider provider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        provider = context.read<ProductDetailProvider>();
        provider
            .getVariants(widget.productDetailArguments.product.id ?? "")
            .then(
          (value) {
            provider.getSizes();
            provider.getProductDetails(
                widget.productDetailArguments.product.id ?? "");
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: ColorPallette.scaffoldBgColor,
        title: Text(
          widget.productDetailArguments.product.name ?? "Product Details",
          style: FontPallette.headingStyle,
        ),
      ),
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Selector<
          ProductDetailProvider,
          Tuple6<bool, ProductModel?, List<Variant>, Variant?, List<SizeModel>,
              SizeModel?>>(
        selector: (p0, detailProvider) => Tuple6(
            detailProvider.isLoading,
            detailProvider.product,
            detailProvider.variantList,
            detailProvider.variant,
            detailProvider.variantSizes,
            detailProvider.selectedSize),
        builder: (context, value, child) {
          final product = value.item2;
          final isLoading = value.item1;
          final variantList = value.item3;
          final variant = value.item4;
          final sizeList = value.item5;
          final selectedSize = value.item6;
          return isLoading
              ? const LoadingAnimation()
              : ListView(
                  children: [
                    ImageSlider(
                      variant: variant,
                    ),
                    const SizedBox(height: 20),
                    ProductDetailsWidget(
                      selectedSize: selectedSize,
                      variantList: variantList,
                      variant: variant,
                      product: product,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Variants",
                                style: FontPallette.headingStyle,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteGenerator.addVariantScreen,
                                      arguments: ProductEditingArgments(
                                          variant: variant, product: product));
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                    color: ColorPallette.blackColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add New",
                                      style: FontPallette.headingStyle.copyWith(
                                          fontSize: 10.sp,
                                          color: ColorPallette.whiteColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        SizedBox(
                          height: 140.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: variantList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final variantAtIndex = variantList[index];
                              final isVariant = variantAtIndex.variantId ==
                                  variant?.variantId;
                              return Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (!isVariant) {
                                          provider.getVariantDetails(
                                              variantAtIndex.variantId ?? "",
                                              variantAtIndex);
                                        }
                                      },
                                      child: Container(
                                        height: 80.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: isVariant
                                                  ? ColorPallette.blackColor
                                                  : ColorPallette.greyColor,
                                              width: isVariant ? 3 : 2),
                                          color: ColorPallette.greyColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: variantList[index]
                                                      .imageUrlList?[0] ??
                                                  ""),
                                        ),
                                      ),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      variantList[index].color ?? "",
                                      style: FontPallette.headingStyle.copyWith(
                                          fontSize: 13.sp,
                                          color: ColorPallette.darkGreyColor),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sizes",
                                style: FontPallette.headingStyle,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteGenerator.addSizeScreen,
                                              arguments: ProductEditingArgments(
                                                  variant: variant,
                                                  product: product));
                                        },
                                        child: SizedBox(
                                            height: 25.h,
                                            width: 25.h,
                                            child: SvgPicture.asset(
                                                Assets.editSvgrepoCom)),
                                      ),
                                      20.horizontalSpace,
                                      InkWell(
                                        onTap: () {
                                          confirmationDialog(
                                              onTap: () {
                                                provider
                                                    .removeSize(
                                                        selectedSize?.sizeId ??
                                                            "")
                                                    .then(
                                                  (value) {
                                                    Navigator.pop(context);
                                                    provider.getSizes();
                                                  },
                                                );
                                              },
                                              context: context,
                                              buttonText: "Remove",
                                              content:
                                                  "Do you want to delete this ?");
                                        },
                                        child: SizedBox(
                                            height: 25.h,
                                            width: 25.h,
                                            child: SvgPicture.asset(
                                                Assets.bagCrossSvgrepoCom)),
                                      )
                                    ],
                                  ),
                                  10.horizontalSpace,
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteGenerator.addSizeScreen,
                                          arguments: ProductEditingArgments(
                                              variant: variant,
                                              product: product));
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        color: ColorPallette.blackColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Add New",
                                          style: FontPallette.headingStyle
                                              .copyWith(
                                                  fontSize: 10.sp,
                                                  color:
                                                      ColorPallette.whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        SizedBox(
                          height: 70.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sizeList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final isSelectedSize =
                                  selectedSize == sizeList[index];

                              final size = sizeList[index];
                              return Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (selectedSize != size) {
                                          provider.selectSize(size);
                                        }
                                      },
                                      child: Container(
                                        height: 35.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: isSelectedSize
                                                  ? ColorPallette.blackColor
                                                  : ColorPallette.greyColor,
                                              width: isSelectedSize ? 3 : 1),
                                          color: ColorPallette.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: Text(
                                            size.size,
                                            style: FontPallette.subtitleStyle
                                                .copyWith(
                                                    fontSize: 12.sp,
                                                    color: ColorPallette
                                                        .blackColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    5.verticalSpace,
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
        },
      ),
    );
  }
}

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
            "Selling Price : ₹${selectedSize?.sellingPrice ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Recieving Price : ₹${selectedSize?.receivingPrice ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Discount Price : ₹${selectedSize?.discountPrice ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Stock : ${selectedSize?.stock ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 15.sp, color: ColorPallette.darkGreyColor),
          )
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.variant});
  final Variant? variant;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int page = 0;
  int nextPage = 0;
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _listenController();
        startAutoScroll();
      },
    );
    super.initState();
  }

  void _listenController() {
    pageController.addListener(() {
      page = pageController.page!.round();
      nextPage = page + 1;
    });
  }

  void startAutoScroll() {
    Future.delayed(const Duration(milliseconds: 300)).then(
      (value) {
        if (pageController.hasClients && mounted) {
          nextPage = page + 1;
          Future.delayed(const Duration(
            seconds: 2,
          )).then(
            (value) {
              if (pageController.hasClients && mounted) {
                pageController
                    .animateToPage(nextPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut)
                    .then(
                      (value) => startAutoScroll(),
                    );
              }
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.variant?.imageUrlList ?? []).isNotEmpty
        ? SizedBox(
            height: 270.h,
            width: double.infinity,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              itemBuilder: (context, index) {
                final currentIndex =
                    index % (widget.variant?.imageUrlList ?? []).length;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NeumorphicContainer(
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                    height: 240.h,
                    width: 330.w,
                    childWidget: SizedBox(
                      height: 130.w,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.variant?.imageUrlList?[currentIndex] ?? "",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Center(
                              child: LoadingAnimation(
                            size: 20.r,
                          )),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }
}

void confirmationDialog(
    {required BuildContext context,
    String? heading,
    String? content,
    required buttonText,
    void Function()? onTap}) {
  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 30.h,
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: AlertDialog(
            // title: Text(heading ?? ""),
            content: Text(
              content ?? "",
              style: FontPallette.headingStyle.copyWith(fontSize: 15.sp),
            ),

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: onTap,
                      child: NeumorphicContainer(
                          height: 40.h,
                          width: 100.w,
                          childWidget: Center(
                              child: Text(
                            buttonText,
                            style: FontPallette.headingStyle
                                .copyWith(fontSize: 13.sp),
                          )))),
                  20.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: NeumorphicContainer(
                        height: 40.h,
                        width: 100.w,
                        childWidget: Center(
                            child: Text(
                          'Cancel',
                          style: FontPallette.headingStyle
                              .copyWith(fontSize: 13.sp),
                        ))),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
