import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/controllers/navigation_controller.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final NavigationController navController =
      Get.put(tag: 'navController', NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: AppColors.primaryDark,
        child: Text(
          'Hirevire',
          style: AppTextThemes.titleStyle(context).copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
