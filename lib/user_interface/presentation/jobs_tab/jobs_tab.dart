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

import '../../../routes/app_routes.dart';
import '../profile/sliding_base.dart';

class JobsTab extends StatelessWidget {
  const JobsTab({super.key});
  static final JobsController jobsController = Get.find(tag: 'jobsController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: Obx(
          () => Text(
            'Hi ${jobsController.name}',
            style:
                AppTextThemes.screenTitleStyle(context).copyWith(fontSize: 18),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                  right: GlobalConstants.screenHorizontalPadding),
              padding: const EdgeInsets.all(3),
              height: 35,
              width: 35,
              child: CustomImageView(
                imagePath: ImageConstant.settingsIcon,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                  right: GlobalConstants.screenHorizontalPadding),
              padding: const EdgeInsets.all(3),
              height: 35,
              width: 35,
              child: CustomImageView(
                imagePath: ImageConstant.userIcon,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          return jobsController.jobs.value.isEmpty
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

                              // ToastWidgit.styledToast(
                              //     "Accepted",
                              //     context,
                              //     true
                              // );

                              if (jobsController.isProfileComplete.value ==
                                  false) {
                                Get.toNamed(AppRoutes.completeProfile);
                              } else {

                                jobsController
                                    .applyJob(jobsController.jobs[index]);
                                ToastWidgit.bottomToast("Accepted");

                                final job = jobsController.jobs[index];
                                Get.toNamed(
                                  AppRoutes.jobApplicationForm,
                                  arguments: {
                                    'jobsController': jobsController,
                                    'job': job,
                                    'index': index,
                                  },
                                );
                              }
                            } else if (direction == CardSwiperDirection.left) {
                              jobsController
                                  .rejectJob(jobsController.jobs[index]);

                              ToastWidgit.bottomToast("Rejected");
                              // ToastWidgit.styledToast(
                              //     "Rejected", context, false);
                            }
                            debugPrint(jobsController.jobs.length.toString());
                            return true;
                          },
                          //allowedSwipeDirection: AllowedSwipeDirection.horizontal,
                          scale: 0.9,
                          maxAngle: 30.0,
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
