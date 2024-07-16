import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/components/job_postings_card.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/controllers/job_postings_controller.dart';


class JobPostingsTab extends StatelessWidget {
  const JobPostingsTab({super.key});
  static final JobPostingsController jobPostingsController = Get.find(tag: 'jobPostingsController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: const CustomImageView(
            imagePath: "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
            height: 35,
            imageType: ImageType.network,
            showLoader: false,
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
                imagePath: ImageConstant.userIcon,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
          return
            jobPostingsController.jobPostings.value.isEmpty
          ?
            const Center(
                    child: Text('No job postings available'),
            )
          :
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  children: List.generate(
                    jobPostingsController.jobPostings.length,
                        (index) => JobPostingsCard(
                      index: index, jobPostingsController: jobPostingsController,
                      jobPostings: jobPostingsController.jobPostings[index],
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
