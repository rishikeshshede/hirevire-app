import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/chip_widget.dart';
import '../../../../common/widgets/dropdown_widget.dart';
import '../../../../common/widgets/error_text_widget.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../../themes/text_theme.dart';
import '../controllers/requisitions_controller.dart';
import 'package:get/get.dart';

class CreateJobPostingScreen extends StatefulWidget {
  const CreateJobPostingScreen({
    super.key,
    required this.requisitionsController,
    required this.requisition,
    required this.index,
  });

  final RequisitionsController requisitionsController;
  final Requisition requisition;
  final int index;

  @override
  State<CreateJobPostingScreen> createState() => _CreateJobPostingScreenState();
}

class _CreateJobPostingScreenState extends State<CreateJobPostingScreen> {
  @override
  void initState() {
    super.initState();
    widget.requisitionsController.setJobTitle(widget.requisition.title);
    //requisitionsController.setJobMode(requisition.jobMode);
    widget.requisitionsController
        .setDescription(widget.requisition.description ?? '');
    widget.requisitionsController
        .setOpeningCount(widget.requisition.openingsCount ?? 0);
    widget.requisitionsController.setJobMode(widget.requisition.jobMode ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      screenTitle: "Create Job Posting",
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VideoUploadWidget(
                      onFilesSelected:
                          widget.requisitionsController.onFilesSelected),
                  VerticalSpace(space: 20.h(context)),
                  CustomTextField(
                    titleText: 'Job Title',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.requisitionsController.jobTitleFocusNode,
                    controller:
                        widget.requisitionsController.jobTitleController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.requisitionsController.jobTitleFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.requisitionsController.descFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                          text: widget
                              .requisitionsController.errorMsgJobTitle.value,
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    titleText: 'Description',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 2000,
                    maxLines: 5,
                    focusNode: widget.requisitionsController.descFocusNode,
                    controller: widget.requisitionsController.descController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.requisitionsController.descFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.requisitionsController.locationCityFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget.requisitionsController
                                .errorMsgDescription.value),
                      ],
                    ),
                  ),
                  // CustomTextField(
                  //   titleText: 'Required Skills',
                  //   textInputType: TextInputType.text,
                  //   textInputAction: TextInputAction.done,
                  //   //focusNode: requisitionsController.reqSkillsFocusNode,
                  //   controller: requisitionsController.reqSkillsController,
                  //   onChanged: (String value) {},
                  //   readOnly: true,
                  //   onEditingComplete: () {
                  //     // requisitionsController.reqSkillsFocusNode.unfocus();
                  //     // FocusScope.of(context)
                  //     //     .requestFocus(requisitionsController.locationFocusNode);
                  //   },
                  // ),
                  // const VerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        titleText: 'City',
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        focusNode: widget.requisitionsController.locationCityFocusNode,
                        controller:
                            widget.requisitionsController.locationCityController,
                        onChanged: (String value) {},
                        onEditingComplete: () {
                          widget.requisitionsController.locationCityFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(
                              widget.requisitionsController.locationCountryFocusNode);
                        },
                      ),
                      const HorizontalSpace(space: 4),
                      CustomTextField(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        titleText: 'Country',
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        focusNode: widget.requisitionsController.locationCountryFocusNode,
                        controller:
                        widget.requisitionsController.locationCountryController,
                        onChanged: (String value) {},
                        onEditingComplete: () {
                          widget.requisitionsController.locationCountryFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(
                              widget.requisitionsController.perksFocusNode);
                        },
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgLocation.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),
                  Obx(
                    () => DropdownWidget(
                      controller: widget.requisitionsController,
                      title: 'Job mode',
                      list: GlobalConstants.locationTypes,
                      initialValue:
                          widget.requisitionsController.jobModeController.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          widget.requisitionsController.jobModeController
                              .value = value;
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgJobMode.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),
                  // CustomTextField(
                  //   titleText: 'Video Requirement',
                  //   textInputType: TextInputType.text,
                  //   textInputAction: TextInputAction.done,
                  //   controller: requisitionsController.vidReqController,
                  //   onChanged: (String value) {},
                  // ),
                  // SizedBox(height: 8.h(context)),
                  CustomTextField(
                    titleText: 'Opening Count',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller:
                        widget.requisitionsController.openingCountController,
                    onChanged: (String value) {},
                    readOnly: true,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget.requisitionsController
                                .errorMsgOpeningCount.value),
                      ],
                    ),
                  ),
                  CustomTextField(
                    titleText: 'Perks',
                    labelText: 'Perks of joining the company/team...',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    focusNode: widget.requisitionsController.perksFocusNode,
                    controller: widget.requisitionsController.perksController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.requisitionsController.perksFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.requisitionsController.ctcFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgPerks.value),
                      ],
                    ),
                  ),
                  //TODO: ctc should be in range
                  CustomTextField(
                    titleText: 'CTC',
                    labelText: 'Per annum (in Lakhs)',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.requisitionsController.ctcFocusNode,
                    controller: widget.requisitionsController.ctcController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.requisitionsController.ctcFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.requisitionsController.tDaysFocusNode);
                    },
                    // readOnly: true,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgCtc.value),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Growth Plan',
                        style: AppTextThemes.subtitleStyle(context)
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const VerticalSpace(),
                  CustomTextField(
                    titleText: '30 Days Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.requisitionsController.tDaysFocusNode,
                    controller:
                        widget.requisitionsController.tDaysPlanController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.requisitionsController.tDaysFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.requisitionsController.sDaysFocusNode);
                    },
                  ),
                  Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgGrowthPlanThi.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: '60 Days Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.requisitionsController.sDaysFocusNode,
                    controller:
                        widget.requisitionsController.sDaysPlanController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.requisitionsController.sDaysFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.requisitionsController.nDaysFocusNode);
                    },
                  ),
                  Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgGrowthPlanSix.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                      titleText: '3 Months Plan',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: widget.requisitionsController.nDaysFocusNode,
                      controller:
                          widget.requisitionsController.nDaysPlanController,
                      onChanged: (String value) {},
                      onEditingComplete: () {
                        widget.requisitionsController.nDaysFocusNode.unfocus();
                      }),
                  Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .requisitionsController.errorMsgGrowthPlan3Mon.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Required Skills',
                        style: AppTextThemes.subtitleStyle(context)
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const VerticalSpace(),
                  // C
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      requiredSkills(),
                    ],
                  ),
                  // Text(
                  //   textAlign: TextAlign.start,
                  //   'Questions for Applicant',
                  //   style: AppTextThemes.bodyTextStyle(context)
                  //       .copyWith(fontWeight: FontWeight.w300),
                  // ),
                  // VerticalSpace(space: 4.h(context)), // CustomTextField(
                  // CustomTextField(
                  //   titleText: 'Question 1',
                  //   textInputType: TextInputType.text,
                  //   textInputAction: TextInputAction.next,
                  //   focusNode: requisitionsController.qOneFocusNode,
                  //   controller: requisitionsController.qOneController,
                  //   onChanged: (String value) {},
                  //   onEditingComplete: () {
                  //     requisitionsController.qOneFocusNode.unfocus();
                  //     FocusScope.of(context)
                  //         .requestFocus(requisitionsController.qTwoFocusNode);
                  //   },
                  // ),
                  // VerticalSpace(space: 8.h(context)),
                  // CustomTextField(
                  //   titleText: 'Question 2',
                  //   textInputType: TextInputType.text,
                  //   textInputAction: TextInputAction.done,
                  //   focusNode: requisitionsController.qTwoFocusNode,
                  //   controller: requisitionsController.qTwoController,
                  //   onChanged: (String value) {},
                  //   onEditingComplete: () {
                  //     requisitionsController.qTwoFocusNode.unfocus();
                  //     requisitionsController.createJobApplication(requisition);
                  //   },
                  // ),
                  const VerticalSpace(space: 20),
                  Obx(
                    () => ButtonPrimary(
                      btnText: 'Submit Job Post',
                      onPressed: () {
                        widget.requisitionsController
                            .createJobApplication(widget.requisition);
                      },
                      showLoading:
                          widget.requisitionsController.isCreatingJobPost.value,
                    ),
                  ),
                  const VerticalSpace(space: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Wrap requiredSkills() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        widget.requisition.requiredSkills!.length,
        (index) => SkillChip(
            text: widget.requisition.requiredSkills![index].skill?.name ?? ''),
      ),
    );
  }
}
