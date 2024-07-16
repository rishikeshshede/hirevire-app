import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/employer_interface/models/job_posting.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/controllers/job_postings_controller.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/button_outline.dart';

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
      //margin: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6.w(context)),
      margin: const EdgeInsets.all(12),
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.disabled,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkillChip(skill:'${jobPostings.savedApplications?.length ?? '0'} right swipes'),

              Row(
                children: [
                  const GreenDot(),
                  const HorizontalSpace(),
                  Text(
                    jobPostings.status ?? '',
                    style: AppTextThemes.bodyTextStyle(context),
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
              Text(
                'Hiring Manager',
                style: AppTextThemes.secondaryTextStyle(context),
              ),
              const HorizontalSpace(),
              Text(
                '${jobPostings.postedBy?.name ?? ''}',
                style: AppTextThemes.bodyTextStyle(context).copyWith(
                      fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Openings',
                    style: AppTextThemes.secondaryTextStyle(context),
                  ),
                  const HorizontalSpace(),
                  Text(
                    '${jobPostings.savedApplications?.length ?? '0'}',
                    style: AppTextThemes.bodyTextStyle(context),
                  ),
                ],
              ),
              const VerticalSpace(),
              Row(
                children: [
                  Text(
                    'Accepted',
                    style: AppTextThemes.secondaryTextStyle(context),
                  ),
                  const HorizontalSpace(),
                  Text(
                    '${jobPostings.savedApplications?.length ?? '0'}',
                    style: AppTextThemes.bodyTextStyle(context),
                  ),
                ],
              ),
            ],
          ),
          const VerticalSpace(),

          Row(
            children: [
              Flexible(
                child:  ButtonOutline(
                  btnText: 'View applicants',
                  onPressed: () {},
                  textStyle: AppTextThemes.genericTextStyle(
                    context,
                    customFontSize: 14.0,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      jobPostings.title ?? 'Unknown job title',
      style: AppTextThemes.subtitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
      ),

    );
  }

}
