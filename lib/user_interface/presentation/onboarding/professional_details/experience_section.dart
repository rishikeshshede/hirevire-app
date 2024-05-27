import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/button_flat.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/common/widgets/dropdown_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ExperienceSection extends GetWidget<UserOnbController> {
  const ExperienceSection({super.key});

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
                Obx(
                  () => controller.addingExp.value
                      ? Container()
                      : const HeadingLarge(heading: "Show your Experience"),
                ),
                Obx(
                  () => controller.addingExp.value
                      ? Container()
                      : SizedBox(height: 10.h(context)),
                ),
                Obx(
                  () => controller.addingExp.value
                      ? Container()
                      : const BodyTextWidget(
                          text:
                              "Your skills will help increase your credability with your recruiters.",
                        ),
                ),
                SizedBox(height: 15.h(context)),
                Obx(
                  () => controller.addingExp.value
                      ? Row(
                          children: [
                            Expanded(
                              child: ButtonFlat(
                                onTap: () {
                                  controller.clearExpControllers();
                                },
                                btnText: "Cancel",
                              ),
                            ),
                            Expanded(
                              child: ButtonPrimary(
                                btnText: 'Save',
                                onPressed: () {
                                  controller.saveExp();
                                },
                                btnColor: AppColors.primaryDark,
                                textColor: AppColors.background,
                              ),
                            )
                          ],
                        )
                      : ButtonPrimary(
                          btnText: 'Add Experience',
                          onPressed: () {
                            controller.addingExp.value = true;
                          },
                          btnColor: AppColors.disabled,
                          textColor: AppColors.primaryDark,
                          iconPath: ImageConstant.bagIcon,
                          iconColor: AppColors.primaryDark,
                        ),
                ),
                SizedBox(height: 10.h(context)),
                // TODO: SHOW ADDED EXP
                Obx(
                  () => controller.addingExp.value
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            // boxShadow: const [
                            //   BoxShadow(
                            //     color: Colors.red,
                            //     spreadRadius: 2,
                            //     blurRadius: 5,
                            //     offset: Offset(0, 1),
                            //   ),
                            // ],
                            border: Border.all(color: Colors.grey[350]!),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                            children: [
                              CustomTextField(
                                titleText: "Title*",
                                labelText: 'Ex: Software Engineer',
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: controller.expTitleController,
                                focusNode: controller.expTitleFocusNode,
                                onChanged: (String value) {
                                  controller.searchExpTitle();
                                },
                                onEditingComplete: () {
                                  controller.expTitleFocusNode.unfocus();
                                  FocusScope.of(context).requestFocus(
                                      controller.companyNameFocusNode);
                                },
                              ),
                              VerticalSpace(space: 15.w(context)),
                              CustomTextField(
                                titleText: "Company name*",
                                labelText: 'Ex: Microsoft',
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: controller.companyNameController,
                                focusNode: controller.companyNameFocusNode,
                                onChanged: (String value) {
                                  controller.searchExpTitle();
                                },
                                onEditingComplete: () {
                                  controller.companyNameFocusNode.unfocus();
                                  FocusScope.of(context).requestFocus(
                                      controller.companyLocationFocusNode);
                                },
                              ),
                              VerticalSpace(space: 15.w(context)),
                              CustomTextField(
                                titleText: "Location",
                                labelText: 'Ex: Pune, India',
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller:
                                    controller.companyLocationController,
                                focusNode: controller.companyLocationFocusNode,
                                onChanged: (String value) {
                                  controller.searchExpTitle();
                                },
                                onEditingComplete: () {
                                  controller.companyLocationFocusNode.unfocus();
                                  FocusScope.of(context).requestFocus(
                                      controller.expDescriptionFocusNode);
                                },
                              ),
                              VerticalSpace(space: 15.w(context)),
                              CustomTextField(
                                titleText: "Description",
                                textInputType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                controller: controller.expDescriptionController,
                                focusNode: controller.expDescriptionFocusNode,
                                maxLength:
                                    GlobalConstants.maxExpDescriptionChars,
                                maxLines: 4,
                                onChanged: (String value) {
                                  controller.searchExpTitle();
                                },
                                onEditingComplete: () {
                                  controller.expDescriptionFocusNode.unfocus();
                                },
                              ),
                              VerticalSpace(space: 15.w(context)),
                              DropdownWidget(
                                controller: controller,
                                title: 'Job type',
                                list: GlobalConstants.employmentTypes,
                                initialValue: controller.employmentType.value,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    controller.employmentType.value = value;
                                  }
                                },
                              ),
                              VerticalSpace(space: 15.w(context)),
                              DropdownWidget(
                                controller: controller,
                                title: 'Location type',
                                list: GlobalConstants.locationTypes,
                                initialValue: controller.locationType.value,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    controller.locationType.value = value;
                                  }
                                },
                              ),
                              VerticalSpace(space: 15.w(context)),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownWidget(
                                      controller: controller,
                                      title: 'Start Date*',
                                      list: GlobalConstants.monthsMap.keys
                                          .toList(),
                                      initialValue: controller.startMonth.value,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controller.startMonth.value = value;
                                        }
                                      },
                                    ),
                                  ),
                                  const HorizontalSpace(space: 8),
                                  Expanded(
                                    child: DropdownWidget(
                                      controller: controller,
                                      title: '',
                                      list: GlobalConstants.years,
                                      initialValue: controller.startYear.value,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controller.startYear.value = value;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              VerticalSpace(space: 15.w(context)),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Obx(
                                      () => Checkbox(
                                        value: controller.stillWorking.value,
                                        checkColor: AppColors.background,
                                        activeColor: AppColors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        onChanged: (value) {
                                          controller.toggleStillWorkingValue();
                                        },
                                      ),
                                    ),
                                  ),
                                  const HorizontalSpace(space: 8),
                                  Expanded(
                                    child: Text(
                                      'I am currently working in this role',
                                      style: AppTextThemes.smallText(context),
                                    ),
                                  ),
                                ],
                              ),
                              VerticalSpace(space: 15.w(context)),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownWidget(
                                      controller: controller,
                                      title: 'End date*',
                                      list: GlobalConstants.monthsMap.keys
                                          .toList(),
                                      initialValue: controller.endMonth.value,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controller.endMonth.value = value;
                                        }
                                      },
                                    ),
                                  ),
                                  const HorizontalSpace(space: 8),
                                  Expanded(
                                    child: DropdownWidget(
                                      controller: controller,
                                      title: '',
                                      list: GlobalConstants.years,
                                      initialValue: controller.endYear.value,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controller.endYear.value = value;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              VerticalSpace(space: 15.w(context)),
                            ],
                          ),
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
                    ButtonFlat(
                      onTap: () {
                        controller.clearExpControllers();
                        controller.moveToNextStep();
                      },
                      btnText: "Skip",
                    ),
                    ButtonCircular(
                      icon: ImageConstant.arrowNext,
                      onPressed: () {
                        controller.validateAddedExp();
                      },
                      isActive: controller.expAdded.value,
                    ),
                  ],
                ),
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
