import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
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
  final JobRecommendations job;
  final int index;

  @override
  Widget build(BuildContext context) {

    return PaddedContainer(
      screenTitle: 'Job Application Form',
      child: Container(
        padding: EdgeInsets.all(16.w(context)),
        color: AppColors.background,
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VideoUploadWidget(
                        onFilesSelected: jobsController.onFilesSelected,
                        titleText: 'Upload Video Resume'
                    ),
              
                    VerticalSpace(space: 40.h(context)),
              
                    Text(
                      "Your strength(%)",
                      style: AppTextThemes.bodyTextStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    VerticalSpace(space: 12.h(context)),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        textAlign: TextAlign.start,
                        'Provide Ratings for Skills',
                        style: AppTextThemes.smallText(context)
                            .copyWith(fontWeight: FontWeight.w400, fontSize: 12.5.adaptSize(context)),
                      ),
                    ),
                    VerticalSpace(space: 24.h(context)),

                    ...(job.requiredSkills?.map((skill) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            skill.skill ?? 'other', // Display skill name or a default if missing
                            style: AppTextThemes.bodyTextStyle(context)
                                .copyWith(fontSize: 14.adaptSize(context)),
                          ),
                          const VerticalSpace(space: 2,),
                          Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Slider(
                                                                value: jobsController.skillsRatings[skill.skill] ?? 1.0,
                                                                min: 1,
                                                                max: 10,
                                                                divisions: 9,
                                                                label: (jobsController.skillsRatings[skill.skill] ?? 1.0)
                                    .round()
                                    .toString(),
                                                                onChanged: (value) {
                                  jobsController.skillsRatings[skill.skill ?? 'other'] = value;
                                                                },
                                                              ),
                                ),
                          ),
                          const VerticalSpace(),
                        ],
                      );
                    }) ?? []),

                    VerticalSpace(space: 20.h(context)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ButtonPrimary(
                        btnText: 'Apply',
                        onPressed: () {
                          jobsController.submitJobApplication();
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
