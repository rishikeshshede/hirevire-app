import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/body_text_widget.dart';
import '../../../../common/widgets/button_circular.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/custom_chip.dart';
import '../../../../common/widgets/error_text_widget.dart';
import '../../../../common/widgets/heading_large.dart';
import '../../../../common/widgets/loader_circular_with_bg.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../common/widgets/title_textbox.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_constants.dart';
import '../../../../themes/text_theme.dart';
import '../../../models/job_model.dart';
import '../../profile/professional_details/skills_section.dart';
import '../controllers/jobs_controller.dart';

class JobApplicationForm extends StatelessWidget {
  const JobApplicationForm({
    super.key,
    required this.jobsController,
    required this.job,
    required this.index,
  });

  final JobsController jobsController;
  final JobModel job;
  final int index;

  @override
  Widget build(BuildContext context) {
    // final args = Get.arguments as Map<String, dynamic>;
    // final jobsController = args['jobsController'];
    // final job = args['job'];
    // final index = args['index'];

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
                    VerticalSpace(space: 4.h(context)),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        textAlign: TextAlign.start,
                        'Provide Ratings for Skills',
                        style: AppTextThemes.smallText(context)
                            .copyWith(fontWeight: FontWeight.w400, fontSize: 12.5.adaptSize(context)),
                      ),
                    ),
                    VerticalSpace(space: 12.h(context)),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Java',
                          style: AppTextThemes.bodyTextStyle(context)
                              .copyWith(fontSize: 14.adaptSize(context)),
                        ),
                        const HorizontalSpace(),
                        Obx(
                              () => Slider(
                            value: jobsController.skillsRatings['Java'] ?? 1.0,
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: (jobsController.skillsRatings['Java'] ?? 1.0)
                                .round()
                                .toString(),
                            onChanged: (value) {
                              jobsController.skillsRatings['Java'] = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(space: 10.h(context)),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Python',
                          style: AppTextThemes.bodyTextStyle(context)
                              .copyWith(fontSize: 14.adaptSize(context)),
                        ),
                        const HorizontalSpace(),
                        Obx(
                              () => Slider(
                            value: jobsController.skillsRatings['Python'] ?? 1.0,
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: (jobsController.skillsRatings['Python'] ?? 1.0)
                                .round()
                                .toString(),
                            onChanged: (value) {
                              jobsController.skillsRatings['Python'] = value;
                            },
                          ),
                        ),
              
                      ],
                    ),
                    VerticalSpace(space: 10.h(context)),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Flutter',
                          style: AppTextThemes.bodyTextStyle(context)
                              .copyWith(fontSize: 14.adaptSize(context)),
                        ),
                        const HorizontalSpace(),
                        Obx(
                              () => Slider(
                            value: jobsController.skillsRatings['Flutter'] ?? 1.0,
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: (jobsController.skillsRatings['Flutter'] ?? 1.0)
                                .round()
                                .toString(),
                            onChanged: (value) {
                              jobsController.skillsRatings['Flutter'] = value;
                            },
                          ),
                        ),
                      ],
                    ),

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
