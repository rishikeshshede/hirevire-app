import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/components/job_card.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';

import '../../../../common/widgets/loader_circular_with_bg.dart';
import '../../../../utils/responsive.dart';
import 'applicants_card.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});
  static final JobsController jobsController = Get.put(JobsController());

  @override
  Widget build(BuildContext context) {

    jobsController.fetchLocalData();

    return PaddedContainer(
        screenTitle: 'Applicants',
      child: Obx(
            () {
          return jobsController.isLoading.value
              ? Container(
            alignment: Alignment.center,
            height: Responsive.height(context, 1),
            child: const LoaderCircularWithBg(),
          )
              :
          jobsController.jobs.isEmpty
              ? const Center(
            child: Text('No applicants found'),
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
                      return ApplicantsCard(
                        jobsController: jobsController,
                        job: job,
                        index: index,
                      );
                    },
                    onSwipe: (index, percentThresholdX, direction) {
                      if (direction == CardSwiperDirection.right) {

                        //jobsController.applyJob(jobsController.jobs[index]);
                        ToastWidgit.bottomToast("Accepted");

                        //final job = jobsController.jobs[index];


                      } else if (direction == CardSwiperDirection.left) {
                        //jobsController.rejectJob(jobsController.jobs[index]);
                        ToastWidgit.bottomToast("Rejected");
                      }

                      debugPrint(jobsController.jobs.length.toString());
                      return true; // Allow the swipe
                    },

                    //allowedSwipeDirection: AllowedSwipeDirection.horizontal,
                    scale: 1,
                    numberOfCardsDisplayed: 1,
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
