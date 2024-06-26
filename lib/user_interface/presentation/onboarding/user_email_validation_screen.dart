import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/controllers/common_nav_controller.dart';
import 'package:hirevire_app/common/controllers/text_controller.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/loader_circular.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class UserEmailValidationScreen extends GetWidget<UserOnbController> {
  const UserEmailValidationScreen({super.key});

  static TextController textController = Get.find(tag: 'textController');
  static CommonNavController commonNavController =
      Get.find(tag: 'commonNavController');

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
        onBackBtnPressed: () {
          controller.emailController.clear();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingLarge(
              heading: commonNavController.isUserRegistered.value
                  ? textController.getText('signinEmailHeading')
                  : textController.getText('signupEmailHeading'),
            ),
            SizedBox(height: 10.h(context)),
            BodyTextWidget(
              text: textController.getText('signupEmailSubHeading'),
            ),
            SizedBox(height: 40.h(context)),
            CustomTextField(
              titleText: 'Email',
              autofocus: true,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              onChanged: (String value) {
                controller.validateEmail();
              },
              onEditingComplete: () {
                controller.sendOtp();
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const LoaderCircular()
                      : ButtonCircular(
                          icon: ImageConstant.arrowNext,
                          onPressed: () {
                            controller.sendOtp();
                          },
                          isActive: controller.isEmailValid.value,
                        ),
                ),
                SizedBox(width: 4.h(context)),
              ],
            ),
            SizedBox(height: 16.h(context)),
          ],
        ));
  }
}
