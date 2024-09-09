import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/responsive.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
    this.size,
    this.backgroundColor,
    this.color,
    this.strokWidth,
  });

  final Color? backgroundColor;
  final Color? color;
  final double? size;
  final double? strokWidth;
  double defaultLoaderSize(context) => Responsive.width(context, .09);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: size ?? defaultLoaderSize(context),
          maxWidth: size ?? defaultLoaderSize(context)),
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor ?? AppColors.disabled.withOpacity(.6),
        color: color ?? AppColors.primaryDark,
        strokeWidth: strokWidth ?? 3,
      ),
    );
  }
}
