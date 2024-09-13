import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/custom_chip.dart';
import 'package:hirevire_app/common/widgets/error_text_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/complete_profile_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class SkillsSection extends GetWidget<CompleteProfileController> {
  const SkillsSection({super.key});

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
                const HeadingLarge(heading: "Add skills"),
                SizedBox(height: 10.h(context)),
                const BodyTextWidget(
                  text:
                      "Your skills will help us suggest the best job matches to you.",
                ),
                SizedBox(height: 30.h(context)),
                CustomTextField(
                  titleText: "Skills",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: controller.skillsSearchController,
                  focusNode: controller.searchFocusNode,
                  onChanged: (value) {
                    controller.skillsSearchQuery.value = value;
                  },
                  onEditingComplete: () {
                    if (controller
                        .skillsSearchController.value.text.isNotEmpty) {
                      controller.addSkill({
                        "_id": controller.defaultItemId,
                        "name":
                            controller.skillsSearchController.value.text.trim(),
                      });
                      controller.skillsSearchQuery.value = '';
                    }
                  },
                ),
                Obx(() {
                  if (controller.filteredSkillsSuggestions.isEmpty) {
                    return Container();
                  }
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 180.h(context)),
                    child: Container(
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.grey[350]!),
                        color: AppColors.disabled.withOpacity(.6),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: controller.filteredSkillsSuggestions
                              .map((suggestion) => ListTile(
                                    dense: true,
                                    title: Text(suggestion['name'] ?? ''),
                                    onTap: () {
                                      controller.addSkill(suggestion);
                                      controller.skillsSearchQuery.value = '';
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  );
                }),
                Obx(
                  () => ErrorTextWidget(text: controller.errorMsg.value),
                ),
                SizedBox(height: 15.h(context)),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      controller.selectedSkills.length,
                      (index) {
                        var skill = controller.selectedSkills[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomChip(
                              text: skill['name'],
                              onRemove: () {
                                controller.removeSkill(skill);
                              },
                            ),
                            Obx(
                              () => Slider(
                                value: controller.skillsRatings[skill['_id']] ??
                                    1.0,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                activeColor: AppColors.primaryDark,
                                label:
                                    (controller.skillsRatings[skill['_id']] ??
                                            1.0)
                                        .round()
                                        .toString(),
                                onChanged: (value) {
                                  controller.updateSkillRating(
                                      skill['_id'], value);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => controller.selectedSkills.isEmpty
                  ? ButtonFlat(
                      onTap: () {
                        controller.moveToNextStep();
                        controller.searchFocusNode.unfocus();
                      },
                      btnText: "Skip",
                    )
                  : const HorizontalSpace(),
            ),
            Obx(
              () => ButtonCircular(
                icon: ImageConstant.arrowNext,
                onPressed: () {
                  controller.searchFocusNode.unfocus();
                  controller.moveToNextStep();
                },
                isActive: controller.selectedSkills.isNotEmpty,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
