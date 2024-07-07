import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/controllers/job_postings_controller.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/controllers/requisitions_controller.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_model.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/VideoPlayerWidget.dart';
import '../../../../common/widgets/button_outline.dart';

class JobPostingsCard extends StatelessWidget {
  const JobPostingsCard({
    super.key,
    required this.jobPostingsController,
    required this.jobPostings,
    required this.index,
  });
  final JobPostingsController jobPostingsController;
  final JobModel jobPostings;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.w(context)),
      padding: EdgeInsets.all(8.w(context)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkillChip(skill:'${jobPostings.applicants ?? ''} right swipes'),

              Row(
                children: [
                  const GreenDot(),
                  const HorizontalSpace(),
                  Text(
                    'in-progress', //TODO: application status hardcoded
                    style: AppTextThemes.bodyTextStyle(context),
                  ),
                ],
              ),
            ],
          ),

          jobTitle(context),
          const VerticalSpace(space: 4,),
          Row(
            children: [
              Text(
                jobPostings.companyName ?? '',
                style: AppTextThemes.bodyTextStyle(context).copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const HorizontalSpace(space: 12),

              Text(
                '${jobPostings.recruiter ?? ''}',
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ],
          ),

          const VerticalSpace(),
          Row(
            children: [
              Text(
                'Recruiter',
                style: AppTextThemes.secondaryTextStyle(context),
              ),
              const HorizontalSpace(),
              Text(
                '${jobPostings.recruiter ?? ''}',
                style: AppTextThemes.bodyTextStyle(context),
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
                    '${jobPostings.applicants ?? ''}',
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
                    '${jobPostings.applicants ?? ''}',
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

  Row companyDetails(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(
          imagePath: jobPostings.companyLogoUrl,
          height: 24,
          imageType: ImageType.network,
          showLoader: false,
        ),
        const HorizontalSpace(),
        Text(
          jobPostings.companyName ?? '',
          style: AppTextThemes.bodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Text jobPostingDate(BuildContext context) {
    return Text(
      jobPostingsController.getPostTime(jobPostings.postedOn ?? DateTime.now()),
      style: AppTextThemes.smallText(context),
    );
  }


  Positioned applicantsCount(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GreenDot(),
          const HorizontalSpace(),
          Text(
            '${jobPostings.applicants} applicants',
            style: AppTextThemes.buttonTextStyle(context),
          ),
        ],
      ),
    );
  }

  Positioned recruiterDetails(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: Responsive.width(context, 1) - (8.w(context) * 2) - 20,
            padding: const EdgeInsets.all(8.0),
            color: Colors.black.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobPostings.recruiter ?? 'Unknown',
                      style: AppTextThemes.screenTitleStyle(context).copyWith(
                        color: AppColors.background,
                      ),
                    ),
                    Text(
                      jobPostings.recruiterDesignation ?? 'Recruiter',
                      style: AppTextThemes.smallText(context).copyWith(
                        color: AppColors.background,
                      ),
                    ),
                  ],
                ),
                chatWithRecruiter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomImageView chatWithRecruiter() {
    return CustomImageView(
      imagePath: ImageConstant.chatButtonIcon,
      height: 32,
      imageType: ImageType.png,
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      jobPostings.jobTitle ?? 'Unknown job title',
      style: AppTextThemes.titleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text(
      jobPostings.location ?? '',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      jobPostings.ctc == null ? '' : '  ·  ${jobPostings.ctc} LPA',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Wrap requiredSkills() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        jobPostings.skills!.length,
        (index) => SkillChip(skill: jobPostings.skills![index]),
      ),
    );
  }

  ExpansionPanel planWidget(BuildContext context, GrowthPlan plan, int index) {
    return ExpansionPanel(
      headerBuilder: (c, isOpen) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Text(
            plan.title ?? 'Plan $index',
            style: AppTextThemes.subtitleStyle(context),
          ),
        );
      },
      body: Text(
        plan.description ?? 'No plan provided',
        style: AppTextThemes.bodyTextStyle(context),
      ),
      isExpanded: jobPostingsController.isOpen[index],
      canTapOnHeader: true,
      backgroundColor: AppColors.background,
    );
  }

  Text perks(BuildContext context) {
    return Text(
      jobPostings.perks ?? 'Not mentioned',
      style: AppTextThemes.bodyTextStyle(context),
    );
  }

  Row socialHandles(BuildContext context) {
    return Row(
      children: List.generate(
        jobPostings.socialHandles!.length,
        (index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          margin: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: GlobalConstants
                    .socialProfileTypesMap[jobPostings.socialHandles![index].platform],
                height: 30.w(context),
              ),
              Text(
                jobPostings.socialHandles![index].platform ?? 'Other',
                style: AppTextThemes.extraSmallText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: AppTextThemes.screenTitleStyle(context).copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
