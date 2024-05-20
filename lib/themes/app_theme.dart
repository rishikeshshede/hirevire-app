import 'package:flutter/material.dart';

import 'package:hirevire_app/constants/color_constants.dart';

// App Theme Data
ThemeData theme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: "Poppins",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: AppColors.disabled,
  );
}
