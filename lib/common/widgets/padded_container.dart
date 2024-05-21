import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class PaddedContainer extends StatelessWidget {
  const PaddedContainer({
    super.key,
    required this.child,
    this.alignment = Alignment.topLeft,
  });
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        alignment: alignment,
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 8.h(context),
        ),
        child: child,
      ),
    );
  }
}
