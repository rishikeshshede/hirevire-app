import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_recommendations.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/VideoPlayerWidget.dart';
import '../../../models/job_posting.dart';
import '../controllers/job_postings_controller.dart';

class ApplicantsCard extends StatelessWidget {
  const ApplicantsCard({
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
                recruiterName(context),
                //companyDetails(context),
                //jobPostingDate(context),
              ],
            ),
            const VerticalSpace(),
            Stack(
              children: [
                videoFrame(context),
                //applicantsCount(context),
                recruiterDetails(context),
              ],
            ),
            const VerticalSpace(),
            jobTitle(context),
            Row(
              children: [
                jobLocation(context),
                ctcDetails(context),
              ],
            ),
            const VerticalSpace(),
            if (jobPostings.requiredSkills != null && jobPostings.requiredSkills!.isNotEmpty)
              const SectionTitle(title: 'Skills Match'),
            if (jobPostings.requiredSkills != null && jobPostings.requiredSkills!.isNotEmpty)
              //requiredSkills(),
            const VerticalSpace(),
            ActionButtons(
              onAccept: () {
                //jobsController.applyJob(jobsController.jobs[index]);
                ToastWidgit.bottomToast("Accepted");
              },
              onReject: () {
                //jobsController.rejectJob(jobsController.jobs[index]);
                ToastWidgit.bottomToast("Rejected");
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
          imagePath: jobPostings.postedBy?.profilePicUrl,
          height: 24,
          imageType: ImageType.network,
          showLoader: false,
        ),
        const HorizontalSpace(),
        Text(
          jobPostings.postedBy?.name ?? '',
          style: AppTextThemes.bodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Text jobPostingDate(BuildContext context) {
    return Text(
      jobPostingsController.getPostTime(jobPostings.createdAt ?? DateTime.now()),
      style: AppTextThemes.smallText(context),
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
        child: jobPostings.media == null
            ? const Center(
                child: Text('No video available'),
              )
            : VideoPlayerWidget(videoUrl: jobPostings.media![0].url ?? ''),
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
            '${jobPostings.savedApplications?.length ?? '0'} applicants',
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       job.requestedBy != null && job.requestedBy!.name != null ? job.requestedBy!.name ?? '' : '',
                //       style: AppTextThemes.screenTitleStyle(context).copyWith(
                //         color: AppColors.background,
                //       ),
                //     ),
                //     Text(
                //       'Recruiter',
                //       style: AppTextThemes.smallText(context).copyWith(
                //         color: AppColors.background,
                //       ),
                //     ),
                //   ],
                // ),
                chatWithRecruiter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned recruiterName(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CustomImageView(
            imagePath:
            "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
            height: 35,
            imageType: ImageType.network,
            showLoader: false,
          ),
          HorizontalSpace(),
      Text(
              jobPostings.postedBy != null && jobPostings.postedBy!.name != null ? jobPostings.postedBy!.name ?? '' : '',
              style: AppTextThemes.screenTitleStyle(context).copyWith(
                color: AppColors.background,
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
      jobPostings.title ?? 'Unknown job title',
      style: AppTextThemes.titleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text(
      jobPostings.location != null
          ? '${jobPostings.location!.country ?? ''},${jobPostings.location!.city ?? ''}'
          : 'No location',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      jobPostings.ctc == null ? '' : '  ·  ${jobPostings.ctc} LPA',
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
      jobPostings.perks ?? 'Not mentioned',
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
          child: CustomImageView(
            imagePath: ImageConstant.next,
            height: 35,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: onReject,
              backgroundColor: AppColors.primary,
              child:  CustomImageView(
                imagePath: ImageConstant.cross,
                height: 24,
              ),
            ),

            FloatingActionButton(
              onPressed: onAccept,
              backgroundColor: AppColors.primary,
              child: CustomImageView(
                imagePath: ImageConstant.tickWhite,
                height: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
