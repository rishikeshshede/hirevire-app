import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

class OTPScreen extends GetWidget<UserOnbController> {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingLarge(heading: "Verify your email"),
        SizedBox(height: 10.h(context)),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    "Enter the code we've sent by text to ${controller.emailController.text.trim()}. ",
                style: AppTextThemes.bodyTextStyle(context),
              ),
              TextSpan(
                text: 'Change email',
                style: AppTextThemes.bodyTextStyle(context).copyWith(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.back();
                  },
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h(context)),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            "Code",
            style: AppTextThemes.smallText(context)
                .copyWith(fontSize: 12.5.adaptSize(context)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return CustomTextField(
              width: Responsive.width(context, .1),
              autofocus: index == 0,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.h(context), vertical: 10.w(context)),
              focusNode: controller.otpFocusNodes[index],
              controller: controller.otpControllers[index],
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              showCursor: false,
              maxLength: 1,
              onChanged: (String value) {
                if (value.length == 1) {
                  if (index < 5) {
                    FocusScope.of(context)
                        .requestFocus(controller.otpFocusNodes[index + 1]);
                  } else {
                    controller.otpFocusNodes[index].unfocus();
                  }
                } else if (value.isEmpty) {
                  if (index > 0) {
                    FocusScope.of(context)
                        .requestFocus(controller.otpFocusNodes[index - 1]);
                  }
                }
                controller.validateOtpLength();
              },
              onBackspacePressed: () {
                if (index > 0) {
                  FocusScope.of(context)
                      .requestFocus(controller.otpFocusNodes[index - 1]);
                  controller.otpControllers[index - 1].text = '';
                }
              },
              onEditingComplete: () {
                controller.otpFocusNodes[index].unfocus();
              },
            );
          }),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonFlat(
              onTap: () {
                controller.sendOtp();
              },
              btnText: "Didn't get a code?",
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(right: 4.h(context)),
                child: ButtonCircular(
                  icon: ImageConstant.arrowNext,
                  onPressed: () {
                    controller.verifyOTP();
                  },
                  isActive: controller.isOtpLengthValid.value,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h(context)),
      ],
    ));
  }
}
