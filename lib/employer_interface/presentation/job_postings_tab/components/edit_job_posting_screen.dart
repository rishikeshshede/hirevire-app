import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/chip_widget.dart';
import '../../../../common/widgets/dropdown_widget.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../constants/global_constants.dart';
import '../../../../themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../models/job_posting.dart';
import '../controllers/job_postings_controller.dart';

class EditJobPostingScreen extends StatelessWidget {
  const EditJobPostingScreen({
    super.key,
    required this.jobPostingsController,
    required this.jobPostings,
    required this.index,
  });

  final JobPostingsController jobPostingsController;
  final JobPosting jobPostings;
  final int index;

  @override
  Widget build(BuildContext context) {
    jobPostingsController.setJobTitle(jobPostings.title);
    jobPostingsController.setDescription(jobPostings.description ?? '');
    jobPostingsController.setJobMode(jobPostings.jobMode ?? []);

    return PaddedContainer(
      screenTitle: "Edit Job Posting",
      child: Stack(
        children: [
          Positioned.fill(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //TODO:prefill video
                  // VideoUploadWidget(
                  //     onFilesSelected: jobPostingsController.onFilesSelected),
                  // VerticalSpace(space: 40.h(context)),

                  CustomTextField(
                    titleText: 'Job Title',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: jobPostingsController.jobTitleController,
                    onChanged: (String value) {},
                    onEditingComplete: () {},
                    readOnly: true,
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Description',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 2000,
                    maxLines: 5,
                    controller: jobPostingsController.descController,
                    onChanged: (String value) {},
                    onEditingComplete: () {},
                    readOnly: true,
                  ),
                  VerticalSpace(space: 8.h(context)),                  // CustomTextField(
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
                  CustomTextField(
                    titleText: 'Location',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: jobPostingsController.locationController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                    },
                    readOnly: true,

                  ),
                  VerticalSpace(space: 8.h(context)),

                  Obx(
                        () => DropdownWidget(
                      controller: jobPostingsController,
                      title: 'Job mode',
                      list: GlobalConstants.locationTypes,
                      initialValue: jobPostingsController.jobModeController.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          jobPostingsController.jobModeController.value = value;
                        }
                      },
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: 'Perks',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    controller: jobPostingsController.perksController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                    },
                    readOnly: true,

                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: 'CTC',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: jobPostingsController.ctcController,
                    onChanged: (String value) {},
                    readOnly: true,
                    onEditingComplete: () {
                      },
                    // readOnly: true,
                  ),
                  VerticalSpace(space: 8.h(context)),
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
                  VerticalSpace(space: 4.h(context)), // CustomTextField(
                  CustomTextField(
                    titleText: '30 Days Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: jobPostingsController.tDaysPlanController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      },
                    readOnly: true,

                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: '60 Days Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: jobPostingsController.sDaysPlanController,
                    onChanged: (String value) {},
                    readOnly: true,
                    onEditingComplete: () {                 },
                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: '3 Months Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: jobPostingsController.nDaysPlanController,
                    onChanged: (String value) {},
                      readOnly: true,

                    onEditingComplete: () {
                    }
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
                  VerticalSpace(space: 4.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      requiredSkills(),
                    ],
                  ),

                  VerticalSpace(space: 4.h(context)),
                  Obx(() => SwitchListTile(
                    title: const Text('Close Status'),
                    value: jobPostingsController.isClosedStatus.value,
                    onChanged: (bool value) {
                      jobPostingsController.isClosedStatus.value = value;

                    },
                  )),

                  const VerticalSpace(space: 20),
                  ButtonPrimary(
                    btnText: 'Update',
                    onPressed: () {
                      jobPostingsController.updateJobPosting(jobPostings);
                    },
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
        jobPostings.requiredSkills!.length,
            (index) => SkillChip(text: jobPostings.requiredSkills![index].name ?? 'No skill'),
      ),
    );
  }
}
