import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

class AppTextThemes {
  static double _getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = Responsive.width(context, 1);

    // Define breakpoints and corresponding font sizes
    if (screenWidth >= 600) {
      // Large screens
      return baseSize * 1.5;
    } else if (screenWidth >= 400) {
      // Medium-sized screens
      return baseSize * 1.2;
    } else {
      // Small screens (e.g., mobile phones)
      return baseSize;
    }
  }

  static TextStyle titleStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 26.0.adaptSize(context)),
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle screenTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 20.0.adaptSize(context)),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle subtitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 18.0.adaptSize(context)),
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle bodyTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 16.0.adaptSize(context)),
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle secondaryTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 16.0.adaptSize(context)),
      fontWeight: FontWeight.w400,
      color: AppColors.greyDisabled,
    );
  }

  static TextStyle buttonTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 16.0.adaptSize(context)),
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  static TextStyle smallText(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 14.0.adaptSize(context)),
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle extraSmallText(BuildContext context) {
    return TextStyle(
      fontSize: _getResponsiveFontSize(context, 12.5.adaptSize(context)),
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    );
  }
}
