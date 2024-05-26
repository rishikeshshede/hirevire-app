import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/custom_chip.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class SkillsSection extends GetWidget<UserOnbController> {
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
                  controller: controller.searchController,
                  focusNode: controller.searchFocusNode,
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                  onEditingComplete: () {
                    controller.searchFocusNode.unfocus();
                  },
                ),
                Obx(() {
                  if (controller.filteredSuggestions.isEmpty) {
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
                          children: controller.filteredSuggestions
                              .map((suggestion) => ListTile(
                                    dense: true,
                                    title: Text(suggestion),
                                    onTap: () {
                                      controller.addSkill(suggestion);
                                      controller.searchQuery.value = '';
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 15.h(context)),
                Obx(() {
                  if (controller.selectedSkills.isEmpty) {
                    return Container();
                  }
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      controller.selectedSkills.length,
                      (index) => CustomChip(
                        text: controller.selectedSkills[index],
                        onRemove: () {
                          controller
                              .removeSkill(controller.selectedSkills[index]);
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonFlat(
              onTap: () {
                controller.moveToNextStep();
              },
              btnText: "Skip",
            ),
            ButtonCircular(
              icon: ImageConstant.arrowNext,
              onPressed: () {
                controller.moveToNextStep();
              },
              isActive: true,
            ),
          ],
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
