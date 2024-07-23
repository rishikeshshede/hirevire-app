import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers {
  static Widget box(BuildContext context,
      {double? height, double? width, double? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height ?? 22.w(context),
        width: width ?? Responsive.width(context, .5),
        decoration: BoxDecoration(
          color: AppColors.disabled,
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
      ),
    );
  }
}
