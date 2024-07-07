import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/color_constants.dart';

class CreateJobPostingScreen extends StatelessWidget {
  const CreateJobPostingScreen({
    super.key,
    // required this.requisitionsController,
    // required this.requisition,
    // required this.index,
  });

  // final RequisitionsController requisitionsController;
  // final JobModel requisition;
  // final int index;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryDark,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: const Text('Create job Posting'),
        actions: [
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: VideoUploadWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonPrimary(
                btnText: 'Upload Video',
                onPressed: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}