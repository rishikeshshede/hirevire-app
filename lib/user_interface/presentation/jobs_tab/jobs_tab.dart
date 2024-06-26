import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/components/job_card.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';

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
        ],
      ),
      body: Stack(
        children: List.generate(
          jobsController.jobs.length,
          (index) => JobCard(
            jobsController: jobsController,
            job: jobsController.jobs[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
