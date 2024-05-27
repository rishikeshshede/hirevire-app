import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/error_text_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class BioSection extends GetWidget<UserOnbController> {
  const BioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingLarge(heading: "Setup your profile"),
                SizedBox(height: 10.h(context)),
                const BodyTextWidget(
                  text:
                      "Stand out from crowd with your Headline, Bio and a clear and professional profile picture.",
                ),
                SizedBox(height: 30.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        debugPrint('change profile pic');
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.disabled.withOpacity(0.5),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.dummyUserImage,
                              padding: 30,
                              color: Colors.grey[350],
                            ),
                          ),
                          Positioned(
                            bottom: 0.w(context),
                            right: 8.w(context),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.background,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryLight,
                                  border: Border(),
                                ),
                                child: CustomImageView(
                                  imagePath: ImageConstant.editIcon,
                                  height: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h(context)),
                CustomTextField(
                  titleText: "Your headline",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.headlineController,
                  focusNode: controller.headlineFocusNode,
                  maxLength: GlobalConstants.maxHeadlineChars,
                  onChanged: (String value) {
                    controller.isHeadlineValid.value = value.isNotEmpty;
                  },
                  onEditingComplete: () {
                    controller.headlineFocusNode.unfocus();
                    FocusScope.of(context)
                        .requestFocus(controller.bioFocusNode);
                  },
                ),
                SizedBox(height: 10.h(context)),
                CustomTextField(
                  titleText: "Your bio",
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  controller: controller.bioController,
                  focusNode: controller.bioFocusNode,
                  maxLength: GlobalConstants.maxBioChars,
                  maxLines: 5,
                  onEditingComplete: () {
                    controller.bioFocusNode.unfocus();
                  },
                ),
                Obx(
                  () => ErrorTextWidget(text: controller.errorMsg.value),
                ),
                SizedBox(height: 15.h(context)),
              ],
            ),
          ),
        ),
        const VerticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonFlat(
              onTap: () {
                controller.moveToNextStep();
              },
              btnText: "Skip",
            ),
            Obx(
              () => ButtonCircular(
                icon: ImageConstant.arrowNext,
                onPressed: () {
                  controller.validateHeadline();
                },
                isActive: controller.isHeadlineValid.value,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
