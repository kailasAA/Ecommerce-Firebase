import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoe_app/utils/color_pallette.dart';

class LoadingAnimationStaggeredDotsWave extends StatelessWidget {
  const LoadingAnimationStaggeredDotsWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: ColorPallette.blackColor,
        size: 40.h,
      ),
    );
  }
}

class ThreeDotLoadingAnimation extends StatelessWidget {
  const ThreeDotLoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.threeRotatingDots(
            color: ColorPallette.blackColor, size: 30.h));
  }
}
