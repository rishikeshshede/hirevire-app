import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/controllers/view_applicants_controller.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';

import '../../../../common/widgets/loader_circular_with_bg.dart';
import '../../../../utils/responsive.dart';
import '../../../models/job_posting.dart';
import '../controllers/job_postings_controller.dart';
import 'applicants_card.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({
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

    final ViewApplicantsController viewApplicantsController =
    Get.put(ViewApplicantsController(jobPostings.id ?? ''));

    return PaddedContainer(
        screenTitle: 'Applicants',
      child: Obx(
            () {
          return viewApplicantsController.isLoading.value
              ? Container(
            alignment: Alignment.center,
            height: Responsive.height(context, 1),
            child: const LoaderCircularWithBg(),
          )
              :
          viewApplicantsController.jobApplicant.isEmpty
                ? const Center(
                    child: Text('No applicants found'),
                  )
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                    child: CardSwiper(
                      cardsCount: viewApplicantsController.jobApplicant.length,
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        final job = viewApplicantsController.jobApplicant[index];
                        return ApplicantsCard(
                          jobPostingsController: viewApplicantsController,
                          jobApplicant: job,
                          index: index,
                        );
                      },
                      onSwipe: (index, percentThresholdX, direction) {
                        if (direction == CardSwiperDirection.right) {
                          viewApplicantsController.shortListApplicant(viewApplicantsController.jobApplicant[index]);
                        } else if (direction == CardSwiperDirection.left) {
                          viewApplicantsController.rejectApplicant(viewApplicantsController.jobApplicant[index]);
                        }
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
