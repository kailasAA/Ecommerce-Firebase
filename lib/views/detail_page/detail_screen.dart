import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common_widgets/neumorphic.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';
import 'package:shoe_app/gen/assets.gen.dart';
import 'package:shoe_app/route/argument_model/product_detail_arguments.dart';
import 'package:shoe_app/route/argument_model/product_editing_argments.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/utils/color_pallette.dart';
import 'package:shoe_app/utils/font_pallette.dart';
import 'package:shoe_app/views/detail_page/view_model/product_detail_provider.dart';
import 'package:shoe_app/views/home/models/product_model.dart';
import 'package:shoe_app/views/home/view_model/home_provider.dart';
import 'package:shoe_app/views/main_screen%20copy/view/main_screen.dart';
import 'package:tuple/tuple.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productDetailArguments});

  final ProductDetailArguments productDetailArguments;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    context
        .read<ProductDetailProvider>()
        .getProductDetails(widget.productDetailArguments.product?.id ?? "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: ColorPallette.scaffoldBgColor,
        title: Text(
          widget.productDetailArguments.product?.name ?? "Product Details",
          style: FontPallette.headingStyle,
        ),
      ),
      backgroundColor: ColorPallette.scaffoldBgColor,
      body: Selector<ProductDetailProvider, Tuple2<bool, ProductModel?>>(
        selector: (p0, detailProvider) =>
            Tuple2(detailProvider.isLoading, detailProvider.product),
        builder: (context, value, child) {
          final product = value.item2;
          final isLoading = value.item1;
          return isLoading
              ? const LoadingAnimation()
              : ListView(
                  children: [
                    ImageSlider(
                      product: product,
                    ),
                    const SizedBox(height: 20),
                    ProductDetailsWidget(product: product),
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
                                onTap: () {},
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
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: ColorPallette.greyColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    "color",
                                    style: FontPallette.headingStyle.copyWith(
                                        fontSize: 15.sp,
                                        color: ColorPallette.darkGreyColor),
                                  )
                                ],
                              ),
                            ),
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
                              InkWell(
                                onTap: () {},
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
                          height: 70.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                children: [
                                  Container(
                                    height: 35.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: ColorPallette.greyColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "size",
                                        style: FontPallette.subtitleStyle
                                            .copyWith(
                                                fontSize: 12.sp,
                                                color:
                                                    ColorPallette.whiteColor),
                                      ),
                                    ),
                                  ),
                                  5.verticalSpace,
                                ],
                              ),
                            ),
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

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.product,
  });

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product?.name ?? "",
                style: FontPallette.headingStyle,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.editScreen,
                          arguments: ProductEditingArgments(product: product));
                    },
                    child: SizedBox(
                        height: 30.h,
                        width: 30.h,
                        child: SvgPicture.asset(Assets.editSvgrepoCom)),
                  ),
                  20.horizontalSpace,
                  InkWell(
                    onTap: () {
                      confirmationDialog(
                          onTap: () {
                            context
                                .read<ProductDetailProvider>()
                                .removeProduct(product?.id ?? "");
                            context.read<HomeProvider>().getAllProducts();
                            Navigator.pushNamed(
                                context, RouteGenerator.mainScreen);
                          },
                          context: context,
                          buttonText: "Remove",
                          content: "Do you want to delete this ?");
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
            "Brand : ${product?.brandName ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 16.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Price : ₹${product?.price ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 16.sp, color: ColorPallette.darkGreyColor),
          ),
          5.verticalSpace,
          Text(
            "Selling Price : ₹${product?.sellingPrice ?? ""}",
            style: FontPallette.headingStyle
                .copyWith(fontSize: 16.sp, color: ColorPallette.darkGreyColor),
          )
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.product});
  final ProductModel? product;
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
    return (widget.product?.images ?? []).isNotEmpty
        ? SizedBox(
            height: 270.h,
            width: double.infinity,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              itemBuilder: (context, index) {
                final currentIndex = index % widget.product!.images!.length;
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
                          imageUrl: widget.product?.images?[currentIndex] ?? "",
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
