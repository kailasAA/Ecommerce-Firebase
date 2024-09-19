import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer(
      {super.key,
      this.height,
      this.width,
      this.borderRadius,
      this.offset,
      this.blurRadius,
      this.childWidget});

  final double? height;
  final double? width;
  final double? borderRadius;
  final Offset? offset;
  final double? blurRadius;
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    Offset distance = const Offset(10, 10);
    double blur = 18.r;
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height ?? 100.h,
        width: width ?? 100.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              offset: offset ?? distance,
              blurRadius: blurRadius ?? blur,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: -(offset ?? distance),
              blurRadius: blurRadius ?? blur,
              spreadRadius: 1,
            )
          ],
        ),
        child: childWidget,
      ),
    );
  }
}
