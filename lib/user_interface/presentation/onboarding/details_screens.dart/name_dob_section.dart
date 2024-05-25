import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/error_text_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/common/widgets/title_textbox.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

class NameDobSection extends GetWidget<UserOnbController> {
  const NameDobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingLarge(heading: "Oh hey! Let's start with an intro."),
        SizedBox(height: 40.h(context)),
        const TextboxTitle(title: "Your Name"),
        CustomTextField(
          autofocus: true,
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: controller.nameController,
          focusNode: controller.nameFocusNode,
          onChanged: (String value) {
            controller.validateName();
          },
          onEditingComplete: () {
            controller.nameFocusNode.unfocus();
            FocusScope.of(context).requestFocus(controller.dobFocusNodes[0]);
          },
        ),
        SizedBox(height: 30.h(context)),
        const TextboxTitle(title: "Your Birthday"),
        SizedBox(height: 10.h(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            return CustomTextField(
              titleText: index == 0
                  ? 'Date'
                  : index == 1
                      ? 'Month'
                      : 'Year',
              width: Responsive.width(context, .28),
              focusNode: controller.dobFocusNodes[index],
              controller: controller.dobControllers[index],
              textInputType: TextInputType.number,
              textInputAction:
                  index == 2 ? TextInputAction.done : TextInputAction.next,
              showCursor: false,
              maxLength: index == 2 ? 4 : 2,
              onChanged: (String value) {
                if (index < 2) {
                  bool isValid = controller.validateDobValues(index, value);
                  if (isValid) {
                    FocusScope.of(context)
                        .requestFocus(controller.dobFocusNodes[index + 1]);
                  }
                } else if (index == 2 && value.length == 4) {
                  bool isValid = controller.validateDobValues(index, value);
                  if (isValid) {
                    controller.dobFocusNodes[index].unfocus();
                  }
                }
              },
              onBackspacePressed: () {
                if (index > 0 &&
                    controller.dobControllers[index].value.text.isEmpty) {
                  FocusScope.of(context)
                      .requestFocus(controller.dobFocusNodes[index - 1]);
                } else if (index > 0 &&
                    controller.dobControllers[index].value.text.isNotEmpty) {
                  // controller.validateDobValuesWhenEdited(index,
                  //     controller.dobControllers[index].value.text.trim());
                }
              },
              onEditingComplete: () {
                controller.dobFocusNodes[index].unfocus();
                if (index < 2) {
                  FocusScope.of(context)
                      .requestFocus(controller.dobFocusNodes[index + 1]);
                }
              },
            );
          }),
        ),
        Obx(
          () => controller.isDobValid.value
              ? const SizedBox()
              : ErrorTextWidget(text: controller.errorMsg.value),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () => ButtonCircular(
                icon: ImageConstant.arrowNext,
                onPressed: () {
                  controller.validateStep1();
                  controller.moveToNextStep();
                },
                isActive: controller.isStep1Valid.value,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
