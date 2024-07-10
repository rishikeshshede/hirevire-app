import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/title_textbox.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/color_constants.dart';
import '../controllers/requisitions_controller.dart';

class CreateJobPostingScreen extends StatelessWidget {
  const CreateJobPostingScreen({
    super.key,
    required this.requisitionsController,
    required this.requisition,
    required this.index,
  });

  final RequisitionsController requisitionsController;
  final Requisition requisition;
  final int index;


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
              child: Column(
                children: [
                  VideoUploadWidget(),

                  SizedBox(height: 40.h(context)),
                  Row(
                    children: [
                      const TextboxTitle(title: "Job Title"),
                      SizedBox(width: 4.h(context)),
                      TextboxTitle(title: requisition.title ?? ''),
                    ],
                  ),
                  SizedBox(height: 8.h(context)),

                  Row(
                    children: [
                      const TextboxTitle(title: "Location"),
                      SizedBox(width: 4.h(context)),
                      TextboxTitle(title: requisition.requestedBy?.company?.locations?[0].country ?? ''),
                    ],
                  ),
                  SizedBox(height: 8.h(context)),

                  Row(
                    children: [
                      const TextboxTitle(title: "Job mode"),
                      SizedBox(width: 4.h(context)),
                      TextboxTitle(title: requisition.jobMode ?? ''),
                    ],
                  ),
                  SizedBox(height: 8.h(context)),

                  Row(
                    children: [
                      const TextboxTitle(title: "Description"),
                      SizedBox(width: 4.h(context)),
                      TextboxTitle(title: requisition.description ?? ''),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonPrimary(
                btnText: 'Submit',
                onPressed: () {
                  requisitionsController.createJobApplication(requisition);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}