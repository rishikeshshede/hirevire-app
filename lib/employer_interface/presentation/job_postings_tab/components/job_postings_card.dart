import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/employer_interface/models/job_posting.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/controllers/job_postings_controller.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:hirevire_app/utils/string_handler.dart';
import '../../../../common/widgets/button_outline.dart';
import '../../../../common/widgets/button_primary.dart';
import 'applicants_screen.dart';
import 'edit_job_posting_screen.dart';
import 'package:get/get.dart';

class JobPostingsCard extends StatelessWidget {
  const JobPostingsCard({
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.w(context)),
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.disabled),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyDisabled.withOpacity(.2),
            offset: const Offset(0, 2),
            spreadRadius: 1,
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkillChip(
                  text:
                      '${jobPostings.savedApplications?.length ?? '0'} right swipes'),
              Row(
                children: [
                  const GreenDot(),
                  const HorizontalSpace(),
                  Text(
                    jobPostings.status == null
                        ? ''
                        : StringHandler.capitalizeFirstLetterOfWord(
                            jobPostings.status!),
                    style: AppTextThemes.smallText(context),
                  ),
                ],
              ),
            ],
          ),
          const VerticalSpace(),
          jobTitle(context),
          // Row(
          //   children: [
          //     Text(
          //       jobPostings.title ?? '',
          //       style: AppTextThemes.bodyTextStyle(context).copyWith(
          //         fontWeight: FontWeight.w300,
          //       ),
          //     ),
          //     const HorizontalSpace(space: 12),
          //
          //     Text(
          //       '${jobPostings.postedBy?.name ?? ''}',
          //       style: AppTextThemes.bodyTextStyle(context),
          //     ),
          //   ],
          // ),
          const VerticalSpace(),
          Row(
            children: [
              textWidget(
                context,
                'Hiring Manager: ',
                color: AppColors.greyDisabled,
              ),
              textWidget(context, jobPostings.postedBy?.name ?? ''),
            ],
          ),
          const VerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  textWidget(
                    context,
                    'Openings: ',
                    color: AppColors.greyDisabled,
                  ),
                  textWidget(context,
                      '${jobPostings.savedApplications?.length ?? '0'}'),
                ],
              ),
              const VerticalSpace(),
              Row(
                children: [
                  textWidget(
                    context,
                    'Accepted: ',
                    color: AppColors.greyDisabled,
                  ),
                  textWidget(context,
                      '${jobPostings.savedApplications?.length ?? '0'}'),
                ],
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              Flexible(
                child: ButtonOutline(
                  btnText: 'Edit Job Posting',
                  height: 38.h(context),
                  onPressed: () {
                    Get.to(
                      EditJobPostingScreen(
                        jobPostingsController: jobPostingsController,
                        jobPostings: jobPostings,
                        index: index,
                      ),
                    );
                  },
                  textStyle: AppTextThemes.buttonTextStyle(context).copyWith(
                    fontSize: 13,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              const HorizontalSpace(),
              Flexible(
                child: ButtonPrimary(
                  btnText: 'View applicants',
                  btnColor: AppColors.primaryDark,
                  height: 38.h(context),
                  onPressed: () {
                    Get.to(ApplicantsScreen(
                      jobPostingsController: jobPostingsController,
                      jobPostings: jobPostings,
                      index: index,
                    ));
                  },
                  textStyle: AppTextThemes.buttonTextStyle(context)
                      .copyWith(fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text textWidget(BuildContext context, String text, {Color? color}) {
    return Text(
      text,
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontSize: 13.5,
        color: color ?? AppColors.textPrimary,
      ),
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      jobPostings.title ?? 'Unknown job title',
      style: AppTextThemes.subtitleStyle(context),
    );
  }
}
