import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/loader_circular.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ProvideEmailScreen extends GetWidget<UserOnbController> {
  const ProvideEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
        onBackBtnPressed: () {
          controller.emailController.clear();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadingLarge(
              heading: "Can we get your email, please?",
            ),
            SizedBox(height: 10.h(context)),
            const BodyTextWidget(
              text: "We use email to make make sure everyone here is real.",
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
