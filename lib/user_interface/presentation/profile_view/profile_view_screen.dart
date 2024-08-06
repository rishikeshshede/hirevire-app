import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/loader_circular_with_bg.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/utils/responsive.dart';

import 'controllers/profile_view_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/themes/text_theme.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});
  static final ProfileViewController profileViewController =
      Get.find(tag: 'profileViewController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: AppColors.background,
      //   centerTitle: false,
      //   title: "Profile",
      // ),
      body: SafeArea(
        child: const Center(
          child: Text('User Profile View'),
        )
      ),
    );
  }
}
