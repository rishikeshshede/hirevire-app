import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/error_text_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class NumberSection extends GetWidget<UserOnbController> {
  const NumberSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingLarge(heading: "Can we get your number?"),
        SizedBox(height: 10.h(context)),
        const BodyTextWidget(text: "Some relevant text for this."),
        SizedBox(height: 40.h(context)),
        Row(
          children: [
            CustomTextField(
              readOnly: true,
              width: 80.w(context),
              titleText: 'Country',
              labelText: "IN +91",
            ),
            const HorizontalSpace(),
            Expanded(
              child: CustomTextField(
                titleText: '',
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: controller.numberController,
                focusNode: controller.numberFocusNode,
                maxLength: 10,
                onChanged: (String value) {
                  controller.isNumberValid.value =
                      controller.numberController.value.text.trim().isNotEmpty;
                },
                onEditingComplete: () {
                  controller.numberFocusNode.unfocus();
                  controller.validateNumber();
                },
              ),
            ),
          ],
        ),
        Obx(
          () => ErrorTextWidget(text: controller.errorMsg.value),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonFlat(
              onTap: () {
                controller.numberFocusNode.unfocus();
                controller.moveToNextStep();
              },
              btnText: "Skip",
            ),
            Obx(
              () => ButtonCircular(
                icon: ImageConstant.arrowNext,
                onPressed: () {
                  controller.validateNumber();
                },
                isActive: controller.isNumberValid.value,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
