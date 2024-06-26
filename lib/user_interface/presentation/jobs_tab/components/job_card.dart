import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_model.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

class JobCard extends StatelessWidget {
  const JobCard({
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w(context)),
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: job.companyLogoUrl,
                      height: 24,
                      imageType: ImageType.network,
                      showLoader: false,
                    ),
                    const HorizontalSpace(),
                    Text(
                      job.companyName ?? '',
                      style: AppTextThemes.bodyTextStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  jobsController.getPostTime(job.postedOn ?? DateTime.now()),
                  style: AppTextThemes.smallText(context),
                ),
              ],
            ),
            const VerticalSpace(),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: Responsive.height(context, .6),
                      minWidth: Responsive.width(context, 1),
                    ),
                    child: CustomImageView(
                      imagePath: job.videoUrl,
                      fit: BoxFit.fitWidth,
                      padding: 0,
                      imageType: ImageType.network,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const GreenDot(),
                      const HorizontalSpace(),
                      Text(
                        '${job.applicants} applicants',
                        style: AppTextThemes.buttonTextStyle(context),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: Responsive.width(context, 1) -
                            (8.w(context) * 2) -
                            20,
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
                                  job.recruiter ?? 'Unknown',
                                  style: AppTextThemes.screenTitleStyle(context)
                                      .copyWith(
                                    color: AppColors.background,
                                  ),
                                ),
                                Text(
                                  job.recruiterDesignation ?? 'Recruiter',
                                  style:
                                      AppTextThemes.smallText(context).copyWith(
                                    color: AppColors.background,
                                  ),
                                ),
                              ],
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.chatButtonIcon,
                              height: 32,
                              imageType: ImageType.png,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpace(),
            Text(
              job.jobTitle ?? 'Unknown job title',
              style: AppTextThemes.titleStyle(context).copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 22.w(context),
              ),
            ),
            Row(
              children: [
                Text(
                  job.location ?? '',
                  style: AppTextThemes.secondaryTextStyle(context),
                ),
                Text(
                  job.ctc == null ? '' : '  ·  ${job.ctc} LPA',
                  style: AppTextThemes.secondaryTextStyle(context),
                ),
              ],
            ),
            if (job.skills!.isNotEmpty)
              const SectionTitle(title: 'Required Skills'),
            if (job.skills!.isNotEmpty)
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  job.skills!.length,
                  (index) => SkillChip(skill: job.skills![index]),
                ),
              ),
            if (job.growthPlan!.isNotEmpty)
              const SectionTitle(title: 'Growth Plan'),
            if (job.growthPlan!.isNotEmpty)
              Obx(
                () => ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 400),
                  dividerColor: AppColors.greyDisabled,
                  elevation: 0,
                  expandedHeaderPadding:
                      const EdgeInsets.symmetric(vertical: 0),
                  children: List.generate(
                    job.growthPlan!.length,
                    (index) => planWidget(
                      context,
                      job.growthPlan![index],
                      index,
                    ),
                  ),
                  expansionCallback: (index, isOpen) =>
                      jobsController.toggleGrowthPlan(index, isOpen),
                ),
              ),
            const VerticalSpace(),
            const SectionTitle(title: 'Perks'),
            Text(
              job.perks ?? 'Not mentioned',
              style: AppTextThemes.bodyTextStyle(context),
            ),
            const SectionTitle(title: 'Social Handles'),
            Row(
              children: List.generate(
                job.socialHandles!.length,
                (index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImageView(
                        imagePath: GlobalConstants.socialProfileTypesMap[
                            job.socialHandles![index].platform],
                        height: 30.w(context),
                      ),
                      Text(
                        job.socialHandles![index].platform ?? 'Other',
                        style: AppTextThemes.extraSmallText(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalSpace(space: 20),
          ],
        ),
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
      isExpanded: jobsController.isOpen[index],
      canTapOnHeader: true,
      backgroundColor: AppColors.background,
    );
  }
}

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.skill,
  });

  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(skill),
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
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class GreenDot extends StatelessWidget {
  const GreenDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.green,
      ),
    );
  }
}
