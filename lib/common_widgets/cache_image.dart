import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_app/common_widgets/progress_indicators.dart';

class CacheImageNetwork extends StatelessWidget {
  const CacheImageNetwork({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Image(
          image: imageProvider,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
      placeholder: (context, url) => LoadingAnimationStaggeredDotsWave(
        size: 25.r,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error, size: 25.r),
    );
  }
}
