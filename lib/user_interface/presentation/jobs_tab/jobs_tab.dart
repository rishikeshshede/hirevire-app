import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/components/job_card.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';

import '../../../common/widgets/loader_circular_with_bg.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/responsive.dart';
import 'components/job_application_form.dart';

class JobsTab extends StatelessWidget {
  const JobsTab({super.key});
  static final JobsController jobsController = Get.find(tag: 'jobsController');

  @override
  Widget build(BuildContext context) {
    jobsController.fetchLocalData();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: Obx(
          () => Text(
            'Hi ${jobsController.name.split(' ')[0]}',
            style: AppTextThemes.subtitleStyle(context).copyWith(fontSize: 17),
          ),
        ),
        actions: [
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     margin: EdgeInsets.only(
          //         right: GlobalConstants.screenHorizontalPadding),
          //     padding: const EdgeInsets.all(3),
          //     height: 35,
          //     width: 35,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.settingsIcon,
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.userProfile);
            },
            child: Container(
              margin: EdgeInsets.only(
                  right: GlobalConstants.screenHorizontalPadding),
              padding: const EdgeInsets.all(3),
              height: 35,
              width: 35,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Obx(
                  () => jobsController.jobSeekerProfile.value.profilePicUrl !=
                              null &&
                          jobsController
                              .jobSeekerProfile.value.profilePicUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 38,
                          backgroundImage: NetworkImage(
                            jobsController
                                    .jobSeekerProfile.value.profilePicUrl ??
                                '',
                          ),
                        )
                      : CustomImageView(
                          imagePath: ImageConstant.userIcon,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          return jobsController.isLoading.value
              ? Container(
                  alignment: Alignment.center,
                  height: Responsive.height(context, 1),
                  child: const LoaderCircularWithBg(),
                )
              : jobsController.jobs.isEmpty
                  ? const Center(
                      child: Text('No jobs available'),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: CardSwiper(
                              cardsCount: jobsController.jobs.length,
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                final job = jobsController.jobs[index];
                                return JobCard(
                                  jobsController: jobsController,
                                  job: job,
                                  index: index,
                                );
                              },
                              onSwipe: (index, percentThresholdX, direction) {
                                if (direction == CardSwiperDirection.right) {
                                  if (!jobsController.isProfileComplete.value) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Please complete your profile',
                                            style: AppTextThemes.subtitleStyle(
                                                    context)
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                Get.toNamed(
                                                    AppRoutes.completeProfile);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Not Now'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return false; // Prevent the card from being swiped away
                                  }
                                  // jobsController
                                  //     .applyJob(jobsController.jobs[index]);
                                  // ToastWidgit.bottomToast("Accepted");

                                  final job = jobsController.jobs[index];

                                  jobsController.fetchUserProfile();
                                  Get.to(
                                    () => JobApplicationForm(
                                      jobsController: jobsController,
                                      job: job,
                                      index: index,
                                    ),
                                  )?.then((value) => {
                                        if (value == true)
                                          {
                                            jobsController
                                                .fetchRecommendedJobs()
                                          }
                                      });
                                } else if (direction ==
                                    CardSwiperDirection.left) {
                                  jobsController
                                      .rejectJob(jobsController.jobs[index]);
                                  ToastWidgit.bottomToast("Rejected");
                                }

                                debugPrint(
                                    jobsController.jobs.length.toString());
                                return true; // Allow the swipe
                              },
                              allowedSwipeDirection:
                                  const AllowedSwipeDirection.symmetric(
                                      horizontal: true),
                              scale: 1,
                              numberOfCardsDisplayed: 1,
                              maxAngle: 60.0,
                              padding: EdgeInsets.zero,
                              isLoop: false,
                            ),
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}
