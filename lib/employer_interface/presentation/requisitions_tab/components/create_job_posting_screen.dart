
import 'package:flutter/material.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/text_field.dart';
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

    requisitionsController.setJobTitle(requisition.title);
    requisitionsController.setJobMode(requisition.jobMode);
    requisitionsController.setDescription(requisition.description ?? '');
    requisitionsController.setReqSkills(requisition.requiredSkills ?? []);
    requisitionsController.setOpeningCount(requisition.openingsCount ?? 0);

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    VideoUploadWidget(onFilesSelected: requisitionsController.onFilesSelected),

                    SizedBox(height: 40.h(context)),
                    CustomTextField(
                      titleText: 'Job Title',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.jobTitleController,
                      onChanged: (String value) {

                      },
                      readOnly: true,
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Location',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.locationController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Job Mode',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.jobModeController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Description',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.descController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Video Requirement',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.vidReqController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Required Skills',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.reqSkillsController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Opening Count',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.openingCountController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'Perks',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.perksController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),

                    CustomTextField(
                      titleText: 'CTC',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: requisitionsController.ctcController,
                      onChanged: (String value) {

                      },
                    ),
                    SizedBox(height: 8.h(context)),


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
      ),
    );
  }

}