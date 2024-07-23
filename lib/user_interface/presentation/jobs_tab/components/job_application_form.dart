import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/user_interface/models/job_recommendations.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../themes/text_theme.dart';
import '../controllers/jobs_controller.dart';

class JobApplicationForm extends StatelessWidget {
  const JobApplicationForm({
    super.key,
    required this.jobsController,
    required this.job,
    required this.index,
  });

  final JobsController jobsController;
  final JobRecommendationsModel job;
  final int index;

  @override
  Widget build(BuildContext context) {
    jobsController.fetchUserProfile();

    return PaddedContainer(
      onBackBtnPressed: () => {
        Get.back(result: true),
      },
      screenTitle: 'Job Application Form',
      child: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VideoUploadWidget(
                      onFilesSelected: jobsController.onFilesSelected,
                      titleText: 'Upload Video Resume',
                    ),
                    VerticalSpace(space: 30.h(context)),
                    Text(
                      "Your strength (out of 10)",
                      style: AppTextThemes.mediumTextStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      'Rate yourself in these required skills',
                      style: AppTextThemes.bodyTextStyle(context),
                    ),
                    const VerticalSpace(),
                    ...(job.requiredSkills?.map((skill) {
                          // Ensure only one skill is displayed
                          if (skill.skill?.name == null ||
                              skill.skill?.id == null) {
                            return Container(); // Return an empty container if skill name or id is null
                          }
                          // Creating a map of skill IDs to ratings from jobSeekerProfile
                          final seekerSkills = jobsController
                                      .jobSeekerProfile.value.data?.skills !=
                                  null
                              ? Map.fromEntries(
                                  jobsController
                                      .jobSeekerProfile.value.data!.skills!
                                      .map(
                                    (s) => MapEntry(
                                        s.skill?.id ?? '', s.rating ?? 1.0),
                                  ),
                                )
                              : {};

                          final preFilledRating =
                              seekerSkills[skill.skill?.id ?? ''] ?? 1.0;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const VerticalSpace(space: 15),
                              SkillChip(
                                text: skill.skill?.name ?? 'Unknown',
                              ),
                              const VerticalSpace(space: 10),
                              Obx(
                                () => skill.skill?.name == null
                                    ? const SizedBox()
                                    : SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 6.0),
                                          overlayColor: AppColors.primaryDark,
                                          overlayShape:
                                              SliderComponentShape.noOverlay,
                                          inactiveTrackColor:
                                              AppColors.disabled,
                                          trackShape:
                                              const RoundedRectSliderTrackShape(),
                                          trackHeight: 4.0,
                                          tickMarkShape:
                                              SliderTickMarkShape.noTickMark,
                                        ),
                                        child: Slider(
                                          value: jobsController.skillsRatings[
                                                  skill.skill?.id ?? ''] ??
                                              preFilledRating,
                                          min: 1,
                                          max: 10,
                                          divisions: 9,
                                          activeColor: AppColors.primaryDark,
                                          label: (jobsController.skillsRatings[
                                                      skill.skill?.id ?? ''] ??
                                                  preFilledRating)
                                              .round()
                                              .toString(),
                                          onChanged: (value) {
                                            jobsController.skillsRatings[
                                                skill.skill?.id ?? ''] = value;
                                          },
                                        ),
                                      ),
                              ),
                              const VerticalSpace(),
                            ],
                          );
                        }) ??
                        []),

                    // ...(job.requiredSkills?.map((skill) {
                    //   // Creating a map of skill names to ratings from jobSeekerProfile
                    //   final seekerSkills = jobsController.jobSeekerProfile.value.data?.skills != null
                    //       ? Map.fromEntries(
                    //       jobsController.jobSeekerProfile.value.data!.skills!.map((s) => MapEntry(s.skill?.id ?? '', s.rating ?? 1.0)))
                    //       : {};
                    //
                    //   final preFilledRating = seekerSkills[skill.skill?.id ?? ''] ?? 1.0;
                    //
                    //   return Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         textAlign: TextAlign.start,
                    //         skill.skill?.name ?? 'other',
                    //         style: AppTextThemes.bodyTextStyle(context).copyWith(fontSize: 14.adaptSize(context)),
                    //       ),
                    //       const VerticalSpace(space: 2,),
                    //       Obx(
                    //             () => Padding(
                    //           padding: const EdgeInsets.only(left: 12.0),
                    //           child: Slider(
                    //             value: jobsController.skillsRatings[skill.skill?.id ?? ''] ?? 1.0,
                    //             min: 1,
                    //             max: 10,
                    //             divisions: 9,
                    //             label: (jobsController.skillsRatings[skill.skill?.id ?? ''] ?? 1.0).round().toString(),
                    //             onChanged: (value) {
                    //               jobsController.skillsRatings[skill.skill?.id ?? ''] = value;
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //       const VerticalSpace(),
                    //     ],
                    //   );
                    // }) ?? []),

                    VerticalSpace(space: 20.h(context)),
                    CustomTextField(
                      titleText: 'Additional note',
                      labelText:
                          "Would you like to mentioned\nsomething which we didn't ask?",
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      maxLength: 500,
                      maxLines: 5,
                      focusNode: jobsController.additionalNoteFocusNode,
                      controller: jobsController.additionalNoteController,
                      onChanged: (String value) {},
                      onEditingComplete: () {
                        jobsController.additionalNoteFocusNode.unfocus();
                      },
                    ),
                    VerticalSpace(space: 20.h(context)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ButtonPrimary(
                        btnText: 'Apply',
                        onPressed: () {
                          jobsController.submitJobApplication(job);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
