import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_outline.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/radar_chart_widget.dart';
import 'package:hirevire_app/common/widgets/social_icon_widget.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_recommendations.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/components/section_title.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/video_player_widget.dart';

class JobCard extends StatelessWidget {
  const JobCard({
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
    final radarData = jobsController.prepareRadarData(
        jobsController.jobSeekerProfile.value, job);
    final skillNames =
        job.requiredSkills?.map((skill) => skill.skill?.name ?? '').toList();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: GlobalConstants.screenHorizontalPadding * .5),
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                companyDetails(context),
                jobPostingDate(context),
              ],
            ),
            const VerticalSpace(),
            Stack(
              children: [
                videoFrame(context),
                applicantsCount(context),
                recruiterDetails(context),
              ],
            ),
            const VerticalSpace(),
            jobTitle(context),
            Row(
              children: [
                job.location == null ? const SizedBox() : jobLocation(context),
                job.ctc == null ? const SizedBox() : ctcDetails(context),
              ],
            ),
            if (job.requiredSkills != null && job.requiredSkills!.isNotEmpty)
              const SectionTitle(title: 'Required Skills'),
            if (job.requiredSkills != null && job.requiredSkills!.isNotEmpty)
              requiredSkills(),
            const VerticalSpace(space: 22),
            Obx(() {
              return jobsController.isRadarChartVisible.value
                  ? Stack(
                      children: [
                        SizedBox(
                          //width: 200,
                          child: RadarChartComponent(
                            jobPostData: radarData[0],
                            applicantData: radarData[1],
                            skillNames: skillNames,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                              jobsController.toggleRadarChart();
                            },
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: 200,
                      child: ButtonOutline(
                        btnText: 'Match Me',
                        onPressed: () {
                          if (job.requiredSkills != null &&
                              job.requiredSkills!.isNotEmpty) {
                            jobsController.toggleRadarChart();
                          }
                        },
                      ),
                    );
            }),
            //const VerticalSpace(space: 4),
            if (job.growthPlan != null && job.growthPlan!.isNotEmpty)
              const SectionTitle(title: 'Growth Plan', marginBottom: 0),
            if (job.growthPlan != null && job.growthPlan!.isNotEmpty)
              growthPlans(context),
            const SectionTitle(title: 'Perks'),
            perks(context),
            if (job.postedBy != null &&
                job.postedBy!.socialUrls != null &&
                job.postedBy!.socialUrls!.isNotEmpty)
              const SectionTitle(title: 'Social Handles'),
            socialHandles(context),
            const VerticalSpace(space: 20),
          ],
        ),
      ),
    );
  }

  Row companyDetails(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(
          imagePath: job.postedBy?.profilePicUrl,
          height: 24,
          imageType: ImageType.network,
          showLoader: false,
        ),
        const HorizontalSpace(),
        Text(
          job.postedBy?.name ?? '',
          style: AppTextThemes.bodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Text jobPostingDate(BuildContext context) {
    return Text(
      jobsController.getPostTime(job.createdAt ?? DateTime.now()),
      style: AppTextThemes.smallText(context).copyWith(
        color: AppColors.greyDisabled,
      ),
    );
  }

  ClipRRect videoFrame(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Responsive.height(context, .64),
          minWidth: Responsive.width(context, 1),
        ),
        child: job.media == null
            ? const Center(
                child: Text('No video available'),
              )
            : VideoPlayerWidget(videoUrl: job.media![0].url ?? ''),
      ),
    );
  }

  Positioned applicantsCount(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DotWidget(),
          const HorizontalSpace(),
          Text(
            '${job.savedApplications?.length ?? '0'} applicants',
            style: AppTextThemes.smallText(context).copyWith(
              color: Colors.white,
            ),
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
                      job.requestedBy != null && job.requestedBy!.name != null
                          ? job.requestedBy!.name ?? ''
                          : '',
                      style: AppTextThemes.subtitleStyle(context).copyWith(
                        color: AppColors.background,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Recruiter',
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
      // imageType: ImageType.png,
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      job.title ?? 'Unknown Job Title',
      style: AppTextThemes.screenTitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: "${job.location!.country}, ",
          ),
          TextSpan(
            text: job.location!.city,
          ),
        ],
      ),
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      '  ·  ${job.ctc} LPA',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Wrap requiredSkills() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        job.requiredSkills!.length,
        (index) => SkillChip(
          text: job.requiredSkills![index].skill?.name ?? 'Unknown',
        ),
      ),
    );
  }

  Obx growthPlans(BuildContext context) {
    return Obx(
      () => ExpansionPanelList(
        animationDuration: const Duration(milliseconds: 400),
        dividerColor: AppColors.greyDisabled,
        elevation: 0,
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
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
    );
  }

  ExpansionPanel planWidget(BuildContext context, GrowthPlan plan, int index) {
    return ExpansionPanel(
      headerBuilder: (c, isOpen) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Text(
            plan.title ?? 'Plan $index',
            style: AppTextThemes.bodyTextStyle(context).copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      body: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          plan.description ?? 'No plan provided',
          style: AppTextThemes.bodyTextStyle(context),
          textAlign: TextAlign.left,
        ),
      ),
      isExpanded: jobsController.isOpen[index],
      canTapOnHeader: true,
      backgroundColor: AppColors.background,
    );
  }

  Text perks(BuildContext context) {
    return Text(
      job.perks ?? 'Not mentioned',
      style: AppTextThemes.bodyTextStyle(context),
    );
  }

  Row socialHandles(BuildContext context) {
    return Row(
      children: List.generate(
        job.postedBy == null ? 0 : job.postedBy!.socialUrls!.length,
        (index) => SocialIconWidget(
          socialMedia: job.postedBy!.socialUrls![index],
        ),
      ),
    );
  }
}
