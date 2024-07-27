import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/models/JobApplication.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_recommendations.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/VideoPlayerWidget.dart';
import '../../../models/job_posting.dart';
import '../controllers/job_postings_controller.dart';
import '../controllers/view_applicants_controller.dart';
import 'package:fl_chart/fl_chart.dart';
class ApplicantsCard extends StatelessWidget {
  const ApplicantsCard({
    super.key,
    required this.jobPostingsController,
    required this.jobApplicant,
    required this.index,
  });
  final ViewApplicantsController jobPostingsController;
  final JobApplication jobApplicant;
  final int index;

  @override
  Widget build(BuildContext context) {
    final radarData = jobPostingsController.prepareRadarData(jobApplicant.jobPostId, jobApplicant);
    final skillNames = jobApplicant.requiredSkills?.map((skill) => skill.skill?.name ?? '').toList();


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
                applicantName(context),
                //companyDetails(context),
                //jobPostingDate(context),
              ],
            ),
            const VerticalSpace(),
            Stack(
              children: [
                videoFrame(context),
                //applicantsCount(context),
                aplicantDetails(context),
              ],
            ),
            const VerticalSpace(),
            jobTitle(context),
            Row(
              children: [
                jobLocation(context),
                //ctcDetails(context),
              ],
            ),
            const VerticalSpace(),
            Row(
              children: [
                //jobLocation(context),
                ctcDetails(context),
              ],
            ),
            const VerticalSpace(),
            if (jobApplicant.requiredSkills != null && jobApplicant.requiredSkills!.isNotEmpty)
              const SectionTitle(title: 'Skills Match'),
            if (jobApplicant.requiredSkills != null && jobApplicant.requiredSkills!.isNotEmpty)
              RadarChartComponent(
                jobPostData: radarData[0],
                applicantData: radarData[1],
                skillNames: skillNames,
              ),
            const VerticalSpace(),
            ActionButtons(
              onAccept: () {
                jobPostingsController.shortListApplicant(jobPostingsController.jobApplicant[index]);
              },
              onReject: () {
                jobPostingsController.rejectApplicant(jobPostingsController.jobApplicant[index]);
              },
              onSkip: () {
                ToastWidgit.bottomToast("Skipped");
              },
            ),
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
          imagePath: jobApplicant.jobPostId?.postedBy?.socialUrls?[0].url ?? '',
          height: 24,
          imageType: ImageType.network,
          showLoader: false,
        ),
        const HorizontalSpace(),
        Text(
          jobApplicant.jobPostId?.postedBy?.name ?? '',
          style: AppTextThemes.bodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
        child: jobApplicant.media == null
            ? const Center(
                child: Text('No video available'),
              )
            : VideoPlayerWidget(videoUrl: jobApplicant.media![0].url ?? ''),
        // CustomImageView(
        //   imagePath: job.videoUrl,
        //   fit: BoxFit.fitWidth,
        //   padding: 0,
        //   imageType: ImageType.network,
        // ),
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
          const GreenDot(),
          const HorizontalSpace(),
          Text(
            '${jobApplicant.jobPostId?.savedApplications?.length ?? '0'} applicants',
            style: AppTextThemes.buttonTextStyle(context),
          ),
        ],
      ),
    );
  }

  Positioned aplicantDetails(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: Responsive.width(context, 1) - (8.w(context) * 2) - 20,
              padding: const EdgeInsets.all(8.0),
              color: Colors.black.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  chatWithRecruiter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned applicantName(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath:
            jobApplicant.appliedBy != null && jobApplicant.appliedBy?.profilePicUrl != null && jobApplicant.appliedBy!.profilePicUrl != null ? jobApplicant.appliedBy!.profilePicUrl ?? '' : '',
            height: 35,
            imageType: ImageType.network,
            showLoader: false,
          ),
          HorizontalSpace(),
      Text(
        jobApplicant.appliedBy != null && jobApplicant.appliedBy?.name != null && jobApplicant.appliedBy!.name != null ? jobApplicant.appliedBy!.name ?? '' : '',
              style: AppTextThemes.screenTitleStyle(context).copyWith(
                color: AppColors.black,
              ),
            ),

        ],
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
      jobApplicant.jobPostId?.title ?? 'Unknown job title',
      style: AppTextThemes.titleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text(
      jobApplicant.jobPostId != null && jobApplicant.jobPostId?.location != null
          ? '${jobApplicant.jobPostId?.location!.country ?? ''}, ${jobApplicant.jobPostId?.location!.city ?? ''} · ${jobApplicant.jobPostId?.jobMode?[0] ?? ''}'
          : 'No location',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      jobApplicant.jobPostId?.ctc == null ? '' : '${jobApplicant.jobPostId?.ctc ?? ''} LPA',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  // Wrap requiredSkills() {
  //   return Wrap(
  //     alignment: WrapAlignment.start,
  //     spacing: 8,
  //     runSpacing: 8,
  //     children: List.generate(
  //       jobPostings.requiredSkills!.length,
  //       (index) =>
  //           SkillChip(text: jobPostings.requiredSkills![index]. ?.name ?? ''),
  //     ),
  //   );
  // }


  Text perks(BuildContext context) {
    return Text(
      jobApplicant.jobPostId?.perks ?? 'Not mentioned',
      style: AppTextThemes.bodyTextStyle(context),
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

class ActionButtons extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onSkip;

  const ActionButtons({
    super.key,
    required this.onAccept,
    required this.onReject,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        FloatingActionButton(
          onPressed: onSkip,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: CustomImageView(
            imagePath: ImageConstant.next,
            height: 28,
            width: 28,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: onReject,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              backgroundColor: AppColors.primary,
              child:  CustomImageView(
                imagePath: ImageConstant.cross,
                height: 24,
                width: 24,
              ),
            ),

            FloatingActionButton(
              onPressed: onAccept,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              backgroundColor: AppColors.primary,
              child: CustomImageView(
                imagePath: ImageConstant.tickWhite,
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RadarChartComponent extends StatelessWidget {
  final List<RadarEntry> jobPostData;
  final List<RadarEntry> applicantData;
  final List<String>? skillNames;

  RadarChartComponent({
    required this.jobPostData,
    required this.applicantData,
    required this.skillNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: RadarChart(
        RadarChartData(
          radarTouchData: RadarTouchData(enabled: true),
          dataSets: [
            RadarDataSet(
              fillColor: Colors.blue.withOpacity(0.5),
              borderColor: Colors.blue,
              borderWidth: 2,
              entryRadius: 2,
              dataEntries: jobPostData,
            ),
            RadarDataSet(
              fillColor: Colors.orange.withOpacity(0.5),
              borderColor: Colors.orange,
              borderWidth: 2,
              entryRadius: 2,
              dataEntries: applicantData,
            ),
          ],
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.transparent),
          titlePositionPercentageOffset: 0.1,
          titleTextStyle: TextStyle(color: Colors.grey, fontSize: 14),
          getTitle: (index, angle) {
            if (skillNames != null && index < skillNames!.length) {
              return RadarChartTitle(
                text: skillNames![index],
                angle: angle,
              );
            }
            return RadarChartTitle(text: '', angle: angle);
          },
        ),
      ),
    );
  }
}
