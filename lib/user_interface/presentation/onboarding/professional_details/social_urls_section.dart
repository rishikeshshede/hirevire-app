import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/common/widgets/dropdown_widget.dart';
import 'package:hirevire_app/common/widgets/error_text_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/social_url_cards.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class SocialUrlsSection extends GetWidget<UserOnbController> {
  const SocialUrlsSection({super.key});

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
                const HeadingLarge(heading: "Show your public profiles"),
                SizedBox(height: 10.h(context)),
                const BodyTextWidget(
                    text: "Add your public profiles to show your work"),
                SizedBox(height: 30.h(context)),
                Obx(
                  () => DropdownWidget(
                    controller: controller,
                    title: 'Platform type*',
                    list: GlobalConstants.socialProfileTypesMap.keys.toList(),
                    initialValue: controller.socialProfileType.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.socialProfileType.value = value;
                      }
                    },
                  ),
                ),
                SizedBox(height: 15.h(context)),
                CustomTextField(
                  titleText: "URL*",
                  labelText: 'Ex: https://linkedin.com/hirevire',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: controller.socialUrlController,
                  focusNode: controller.socialUrlFocusNode,
                  onChanged: (String value) {
                    controller.checkUrlStatus();
                  },
                  onEditingComplete: () {
                    controller.socialUrlFocusNode.unfocus();
                    controller.addSocialUrl();
                  },
                ),
                Obx(
                  () => ErrorTextWidget(text: controller.errorMsg.value),
                ),
                SizedBox(height: 15.h(context)),
                Obx(
                  () => controller.isAddingUrl.value
                      ? Row(
                          children: [
                            Expanded(
                              child: ButtonFlat(
                                onTap: () {
                                  controller.socialUrlController.clear();
                                  controller.checkUrlStatus();
                                },
                                btnText: "Clear",
                              ),
                            ),
                            Expanded(
                              child: ButtonPrimary(
                                btnText: 'Save',
                                onPressed: () {
                                  controller.addSocialUrl();
                                  controller.socialUrlFocusNode.unfocus();
                                },
                                btnColor: AppColors.primaryDark,
                                textColor: AppColors.background,
                              ),
                            )
                          ],
                        )
                      : Container(),
                ),
                SizedBox(height: 15.h(context)),
                Obx(
                  () => controller.socialProfiles.isNotEmpty
                      ? Column(
                          children: List.generate(
                              controller.socialProfiles.length, (index) {
                            return SocialUrlCard(
                              platform: controller.socialProfiles[index]
                                  ['platform'],
                              url: controller.socialProfiles[index]['url'],
                              onTap: () {
                                controller.socialProfiles.removeAt(index);
                              },
                            );
                          }),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => controller.addingExp.value
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => controller.socialProfiles.isNotEmpty
                          ? Container()
                          : ButtonFlat(
                              onTap: () {
                                controller.clearSocialControllers();
                                controller.moveToNextStep();
                              },
                              btnText: "Skip",
                            ),
                    ),
                    ButtonCircular(
                      icon: ImageConstant.arrowNext,
                      onPressed: () {
                        controller.moveToNextStep();
                      },
                      isActive: controller.socialProfiles.isNotEmpty,
                    ),
                  ],
                ),
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
