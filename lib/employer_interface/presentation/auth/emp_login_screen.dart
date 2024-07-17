import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/controllers/text_controller.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/loader_circular_with_bg.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/controllers/emp_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class EmpLoginScreen extends GetWidget<EmpOnbController> {
  const EmpLoginScreen({super.key});

  static TextController textController = Get.find(tag: 'textController');

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingLarge(
            heading: textController.getText('empLoginHeading'),
          ),
          SizedBox(height: 10.h(context)),
          BodyTextWidget(
            text: textController.getText('empLoginSubHeading'),
          ),
          SizedBox(height: 40.h(context)),
          CustomTextField(
            titleText: 'Email',
            autofocus: true,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: controller.emailController,
            focusNode: controller.emailFocusNode,
            onChanged: (String value) {
              controller.validateEmail();
            },
            onEditingComplete: () {
              controller.emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(controller.passwordFocusNode);
            },
          ),
          SizedBox(height: 10.h(context)),
          CustomTextField(
            titleText: 'Password',
            obscureText: true,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: controller.passwordController,
            focusNode: controller.passwordFocusNode,
            onChanged: (String value) {
              // controller.validatePassword();
            },
            onEditingComplete: () {
              controller.emailFocusNode.unfocus();
              controller.signin();
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const LoaderCircularWithBg()
                    : ButtonCircular(
                        icon: ImageConstant.tickIcon,
                        onPressed: () {
                          controller.signin();
                        },
                        isActive: controller.isEmailValid.value &&
                            controller.passwordController.text
                                .trim()
                                .isNotEmpty,
                      ),
              ),
              SizedBox(width: 4.h(context)),
            ],
          ),
          SizedBox(height: 16.h(context)),
        ],
      ),
    );
  }
}
