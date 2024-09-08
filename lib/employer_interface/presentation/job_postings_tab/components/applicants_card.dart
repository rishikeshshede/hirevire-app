import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/models/job_application_model.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/components/section_title.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../../common/widgets/video_player_widget.dart';
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
    final radarData = jobPostingsController.prepareRadarData(
        jobApplicant.jobPostId, jobApplicant);
    final skillNames = jobApplicant.requiredSkills
        ?.map((skill) => skill.skill?.name ?? '')
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                applicantNameAndProfilePic(context),
                lastUpdated(context),
              ],
            ),
          ),
          const VerticalSpace(),
          Stack(
            children: [
              videoFrame(context),
              showUserTrending(context),
              chatWidget(context),
            ],
          ),
          const VerticalSpace(),
          headline(context),
          jobApplicant.appliedBy?.bio != null ? bio(context) : const SizedBox(),
          jobApplicant.jobPostId != null &&
                  jobApplicant.jobPostId!.location != null
              ? jobLocation(context)
              : const SizedBox(),
          const SectionTitle(title: 'Recent Experience'),
          jobSeekerExperience(context),
          const VerticalSpace(),
          if (jobApplicant.requiredSkills != null &&
              jobApplicant.requiredSkills!.isNotEmpty)
            const SectionTitle(title: 'Skills Match'),
          if (jobApplicant.requiredSkills != null &&
              jobApplicant.requiredSkills!.isNotEmpty)
            RadarChartComponent(
              jobPostData: radarData[0],
              applicantData: radarData[1],
              skillNames: skillNames,
            ),
          const SectionTitle(title: 'Social Handles'),
          socialHandles(context),
          const VerticalSpace(space: 40),
          ActionButtons(
            onAccept: () {
              jobPostingsController.shortListApplicant(
                  jobPostingsController.jobApplicant[index]);
            },
            onReject: () {
              jobPostingsController
                  .rejectApplicant(jobPostingsController.jobApplicant[index]);
            },
            onSkip: () {
              ToastWidgit.bottomToast("Skipped");
            },
          ),
          const VerticalSpace(space: 40),
        ],
      ),
    );
  }

  Widget applicantNameAndProfilePic(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CustomImageView(
              imagePath: jobApplicant.appliedBy != null &&
                      jobApplicant.appliedBy!.profilePicUrl != null
                  ? jobApplicant.appliedBy!.profilePicUrl
                  : '',
              height: 28,
              width: 28,
              imageType: ImageType.network,
              showLoader: false,
              padding: 0,
            ),
          ),
          const HorizontalSpace(),
          Text(
            jobApplicant.appliedBy != null &&
                    jobApplicant.appliedBy?.name != null
                ? jobApplicant.appliedBy!.name!
                : 'Unknown Applicant',
            style: AppTextThemes.mediumTextStyle(context).copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget lastUpdated(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Last updated',
          style: AppTextThemes.smallText(context).copyWith(
            color: AppColors.greyDisabled,
          ),
        ),
        Text(
          jobApplicant.appliedBy != null &&
                  jobApplicant.appliedBy!.updatedTime != null
              ? DatetimeUtil.timeAgo(jobApplicant.appliedBy!.updatedTime!)
              : 'Never',
          style: AppTextThemes.smallText(context).copyWith(
            color: AppColors.greyDisabled,
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
      ),
    );
  }

  Widget showUserTrending(BuildContext context) {
    return Positioned(
      left: 12.w(context),
      top: 12.w(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: jobApplicant.appliedBy!.totalProfileViewCount! >=
                    GlobalConstants.trendingProfileMinViewCount
                ? ImageConstant.fireIcon
                : ImageConstant.iceIcon,
            height: 20,
          ),
          const HorizontalSpace(),
          Text(
            jobApplicant.appliedBy!.totalProfileViewCount! >=
                    GlobalConstants.trendingProfileMinViewCount
                ? "Trending"
                : 'Not trending',
            style: AppTextThemes.buttonTextStyle(context),
          )
        ],
      ),
    );
  }

  Positioned chatWidget(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 8,
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: CustomImageView(
            imagePath: ImageConstant.chatButtonIcon,
            height: 32,
            imageType: ImageType.png,
          ),
        ),
      ),
    );
  }

  Text headline(BuildContext context) {
    return Text(
      jobApplicant.appliedBy?.headline ?? 'Missing Job Title',
      style: AppTextThemes.screenTitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text bio(BuildContext context) {
    return Text(
      jobApplicant.appliedBy!.bio!,
      style: AppTextThemes.mediumTextStyle(context).copyWith(
        fontSize: 14.w(context),
      ),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
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

  String calculateExperience(List<Experience>? experiences) {
    if (experiences == null || experiences.isEmpty) {
      return 'No Experience';
    }

    DateTime latestStartDate = DateTime.now();
    DateTime earliestEndDate = DateTime(0);

    for (var experience in experiences) {
      if (experience.startDate != null &&
          experience.startDate!.isBefore(latestStartDate)) {
        latestStartDate = experience.startDate!;
      }
      if (experience.endDate != null &&
          experience.endDate!.isAfter(earliestEndDate)) {
        earliestEndDate = experience.endDate!;
      } else if (experience.stillWorking == true) {
        earliestEndDate = DateTime.now();
      }
    }

    int totalMonths = (earliestEndDate.year - latestStartDate.year) * 12 +
        earliestEndDate.month -
        latestStartDate.month;
    int years = totalMonths ~/ 12;
    int months = totalMonths % 12;

    return '${years > 0 ? '$years years' : ''}${years > 0 && months > 0 ? ', ' : ''}${months > 0 ? '$months months' : ''}';
  }

  Text jobSeekerExperience(BuildContext context) {
    return Text(
      jobApplicant.appliedBy != null &&
              jobApplicant.appliedBy?.experience != null &&
              jobApplicant.appliedBy!.experience!.isNotEmpty
          ? calculateExperience(jobApplicant.appliedBy?.experience ?? [])
          : 'No Experience',
      style: AppTextThemes.secondaryTextStyle(context),
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

  Text ctcDetails(BuildContext context) {
    return Text(
      jobApplicant.jobPostId?.ctc == null
          ? ''
          : '${jobApplicant.jobPostId?.ctc ?? ''} LPA',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Row socialHandles(BuildContext context) {
    return Row(
      children: List.generate(
        jobApplicant.appliedBy!.socialUrls!.length,
        (index) => SocialIconWidget(
          socialMedia: jobApplicant.appliedBy!.socialUrls![index],
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
        SizedBox(
          width: 70.0,
          height: 70.0,
          child: FloatingActionButton(
            heroTag: 'skipTag1',
            onPressed: onSkip,
            tooltip: 'Skip / Next',
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: CustomImageView(
              imagePath: ImageConstant.next,
              height: 28.w(context),
              width: 28.w(context),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: 'rejectTag1',
                onPressed: onReject,
                tooltip: 'Reject',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                backgroundColor: AppColors.primary,
                child: CustomImageView(
                  imagePath: ImageConstant.cross,
                  height: 18,
                  width: 18,
                ),
              ),
              FloatingActionButton(
                heroTag: 'shortTag1',
                onPressed: onAccept,
                tooltip: 'Shortlist',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                backgroundColor: AppColors.primary,
                child: CustomImageView(
                  imagePath: ImageConstant.tickWhite,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RadarChartComponent extends StatelessWidget {
  final List<RadarEntry> jobPostData;
  final List<RadarEntry> applicantData;
  final List<String>? skillNames;

  const RadarChartComponent({
    super.key,
    required this.jobPostData,
    required this.applicantData,
    required this.skillNames,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: RadarChart(
        RadarChartData(
          radarTouchData: RadarTouchData(enabled: true),
          dataSets: [
            RadarDataSet(
              fillColor: Colors.blue.withOpacity(1),
              borderColor: Colors.blue,
              borderWidth: 2,
              entryRadius: 2,
              dataEntries: jobPostData,
            ),
            RadarDataSet(
              fillColor: Colors.orange.withOpacity(0.2),
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
          titleTextStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          radarShape: RadarShape.circle,
          getTitle: (index, angle) {
            if (skillNames != null && index < skillNames!.length) {
              if (skillNames![index].startsWith('Dummy Skill')) {
                return RadarChartTitle(
                    text: '', angle: angle); // Skip dummy skill title
              }
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

class SocialIconWidget extends StatelessWidget {
  const SocialIconWidget({
    super.key,
    required this.socialMedia,
  });

  final SocialUrl socialMedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: open link socialMedia.url
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath:
                  GlobalConstants.socialProfileTypesMap[socialMedia.platform],
              height: 35.w(context),
            ),
            Text(
              socialMedia.platform ?? 'Other',
              style: AppTextThemes.extraSmallText(context),
            ),
          ],
        ),
      ),
    );
  }
}
