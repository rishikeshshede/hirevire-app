import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class PaddedContainer extends StatelessWidget {
  const PaddedContainer({
    super.key,
    required this.child,
    this.alignment = Alignment.topLeft,
    this.screenTitle = '',
    this.showBackIcon = true,
    this.onBackBtnPressed,
    this.vPadding,
    this.hPadding,
  });
  final Alignment alignment;
  final Widget child;
  final String screenTitle;
  final bool showBackIcon;
  final VoidCallback? onBackBtnPressed;
  final double? vPadding, hPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBackIcon
          ? AppBar(
              backgroundColor: AppColors.background,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              leading: GestureDetector(
                onTap: () {
                  if (onBackBtnPressed != null) onBackBtnPressed!();
                  Get.back();
                },
                child: CustomImageView(
                  imagePath: ImageConstant.arrowLeft,
                  padding: 16,
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                screenTitle,
                style: AppTextThemes.mediumTextStyle(context).copyWith(
                  fontSize: 16.w(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
      body: Container(
        color: AppColors.background,
        alignment: alignment,
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? 16.w(context),
          vertical: vPadding ?? 8.h(context),
        ),
        child: child,
      ),
    );
  }
}
