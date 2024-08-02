import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/chip_widget.dart';
import '../../../../common/widgets/dropdown_widget.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../../themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../models/job_posting.dart';
import '../controllers/job_postings_controller.dart';

class EditJobPostingScreen extends StatefulWidget {
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
  State<EditJobPostingScreen> createState() => _EditJobPostingScreenState();
}


class _EditJobPostingScreenState extends State<EditJobPostingScreen> {
  @override
  void initState() {
    super.initState();
    widget.jobPostingsController.setPerks(widget.jobPostings.perks);
    widget.jobPostingsController.setJobTitle(widget.jobPostings.title);
    widget.jobPostingsController
        .setDescription(widget.jobPostings.description ?? '');
    widget.jobPostingsController
        .setCtc(widget.jobPostings.ctc);
    widget.jobPostingsController
        .setLocation(widget.jobPostings.location);
    widget.jobPostingsController
        .setOpeningCount(widget.jobPostings.openingsCount ?? 0);
    widget.jobPostingsController.setNinetyDays(widget.jobPostings.growthPlan?[2].description ?? '');
    widget.jobPostingsController.setSixDays(widget.jobPostings.growthPlan?[1].description ?? '');
    widget.jobPostingsController.setThiDays(widget.jobPostings.growthPlan?[0].description ?? '');
    widget.jobPostingsController.setJobMode(widget.jobPostings.jobMode ?? []);
    widget.jobPostingsController.setRecruiterVideoThumbnail(widget.jobPostings.media?[0].url, widget.jobPostings.media?[0].thumbnail);
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      screenTitle: "Edit Job Posting",
      child: Stack(
        children: [
          Positioned.fill(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                  () =>
                  VideoUploadWidget(
                      onFilesSelected: widget.jobPostingsController.onFilesSelected,
                    videoUrl: widget.jobPostingsController.selectedVideoFileUrl.value,
                    thumbnailUrl: widget.jobPostingsController.selectedThumbnailFileUrl.value,
                  ),),
                  VerticalSpace(space: 40.h(context)),

                  CustomTextField(
                    titleText: 'Job Title',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: widget.jobPostingsController.jobTitleController,
                    onChanged: (String value) {},
                    onEditingComplete: () {},
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Description',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 2000,
                    maxLines: 5,
                    controller: widget.jobPostingsController.descController,
                    onChanged: (String value) {},
                    onEditingComplete: () {},
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        titleText: 'City',
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller:
                        widget.jobPostingsController.locationCityController,
                        onChanged: (String value) {},
                        onEditingComplete: () {
                        },
                      ),
                      const HorizontalSpace(space: 4),
                      CustomTextField(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        titleText: 'Country',
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller:
                        widget.jobPostingsController.locationCountryController,
                        onChanged: (String value) {},
                        onEditingComplete: () {
                        },
                      ),
                    ],
                  ),
                  VerticalSpace(space: 8.h(context)),

                  Obx(
                        () => DropdownWidget(
                      controller: widget.jobPostingsController,
                      title: 'Job mode',
                      list: GlobalConstants.locationTypes,
                      initialValue: widget.jobPostingsController.jobModeController.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          widget.jobPostingsController.jobModeController.value = value;
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
                    controller: widget.jobPostingsController.perksController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                    },

                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: 'CTC',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: widget.jobPostingsController.minCtcController,
                    onChanged: (String value) {},
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
                    controller: widget.jobPostingsController.tDaysPlanController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      },

                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: '60 Days Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: widget.jobPostingsController.sDaysPlanController,
                    onChanged: (String value) {},
                    readOnly: true,
                    onEditingComplete: () {                 },
                  ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: '3 Months Plan',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: widget.jobPostingsController.nDaysPlanController,
                    onChanged: (String value) {},
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
                    value: widget.jobPostingsController.isClosedStatus.value,
                    onChanged: (bool value) {
                      widget.jobPostingsController.isClosedStatus.value = value;

                    },
                  )),

                  const VerticalSpace(space: 20),
                  ButtonPrimary(
                    btnText: 'Update',
                    onPressed: () {
                      widget.jobPostingsController.updateJobPosting(widget.jobPostings);
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
        widget.jobPostings.requiredSkills!.length,
            (index) => SkillChip(text: widget.jobPostings.requiredSkills![index].skill ?? 'No skill'),
      ),
    );
  }
}
