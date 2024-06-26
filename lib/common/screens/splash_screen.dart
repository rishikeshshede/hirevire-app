import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/controllers/common_nav_controller.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final CommonNavController commonNavController =
      Get.put(tag: 'commonNavController', CommonNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: AppColors.primaryDark,
        child: CustomImageView(
          imagePath: ImageConstant.logo,
          height: 212.h(context),
        ),
      ),
    );
  }
}
