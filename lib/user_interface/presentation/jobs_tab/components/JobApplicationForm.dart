import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/body_text_widget.dart';
import '../../../../common/widgets/button_circular.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/custom_chip.dart';
import '../../../../common/widgets/error_text_widget.dart';
import '../../../../common/widgets/heading_large.dart';
import '../../../../common/widgets/loader_circular.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../common/widgets/title_textbox.dart';
import '../../../../common/widgets/video_upload_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_constants.dart';
import '../../../../themes/text_theme.dart';
import '../../../models/job_model.dart';
import '../../profile/professional_details/skills_section.dart';
import '../controllers/jobs_controller.dart';

class JobApplicationForm extends StatelessWidget {
  const JobApplicationForm({
    super.key,
    required this.jobsController,
    required this.job,
    required this.index,
  });

  final JobsController jobsController;
  final JobModel job;
  final int index;


  @override
  Widget build(BuildContext context) {
    // final args = Get.arguments as Map<String, dynamic>;
    // final jobsController = args['jobsController'];
    // final job = args['job'];
    // final index = args['index'];

    return PaddedContainer(
      screenTitle: 'Job Application Form',
      child: Container(
        padding: EdgeInsets.all(16.w(context)),
        color: AppColors.background,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Upload you video resume", style: AppTextThemes.bodyTextStyle(context).copyWith(
                fontWeight: FontWeight.w400,
              ),),
              SizedBox(height: 10.h(context)),
              VideoUploadWidget(onFilesSelected: jobsController.onFilesSelected),

              SizedBox(height: 40.h(context)),

              Text("Your strength(%)", style: AppTextThemes.bodyTextStyle(context).copyWith(
                fontWeight: FontWeight.w400,
              ),),
              SizedBox(height: 10.h(context)),

              // CustomTextField(
              //   titleText: "Provide Ratings for Skills",
              //   textInputType: TextInputType.text,
              //   textInputAction: TextInputAction.done,
              //   controller: jobsController.skillsSearchController,
              //   focusNode: jobsController.searchFocusNode,
              //   maxLines: 3,
              //   onChanged: (value) {
              //     jobsController.skillsSearchQuery.value = value;
              //   },
              //   onEditingComplete: () {
              //     if (jobsController.skillsSearchController.value.text.isNotEmpty) {
              //       jobsController.addSkill({
              //         "_id": jobsController.defaultItemId,
              //         "name": jobsController.skillsSearchController.value.text.trim(),
              //       });
              //       jobsController.skillsSearchQuery.value = '';
              //     }
              //   },
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  textAlign: TextAlign.start,
                  'Provide Ratings for Skills',
                  style: AppTextThemes.smallText(context)
                      .copyWith(fontSize: 12.5.adaptSize(context)),
                ),
              ),
              SizedBox(height: 10.h(context)),

              Row(
                children: [
                  Text(
                    'Java',
                    style: AppTextThemes.bodyTextStyle(context)
                        .copyWith(fontSize: 14.adaptSize(context)),
                  ),
                  const HorizontalSpace(),
                  Slider(
                    value: jobsController.skillsRatings.value[1.0] ?? 1.0,
                    min: 1,
                    max: 10,
                    //divisions: 9,
                    label: (jobsController.skillsRatings.value[1.0] ?? 1.0).round().toString(),
                    onChanged: (value) {
                      //jobsController.updateSkillRating(5.0, value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h(context)),

              Row(
                children: [
                  Text(
                    'Python',
                    style: AppTextThemes.bodyTextStyle(context)
                        .copyWith(fontSize: 14.adaptSize(context)),
                  ),
                  const HorizontalSpace(),
                  Slider(
                    value: jobsController.skillsRatings.value[1.0] ?? 1.0,
                    min: 1,
                    max: 10,
                    //divisions: 9,
                    label: (jobsController.skillsRatings.value[1.0] ?? 1.0).round().toString(),
                    onChanged: (value) {
                      //jobsController.updateSkillRating(5.0, value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h(context)),

              Row(
                children: [
                  Text(
                    'Flutter',
                    style: AppTextThemes.bodyTextStyle(context)
                        .copyWith(fontSize: 14.adaptSize(context)),
                  ),
                  const HorizontalSpace(),
                  Slider(
                    value: jobsController.skillsRatings.value[1.0] ?? 1.0,
                    min: 1,
                    max: 10,
                    //divisions: 9,
                    label: (jobsController.skillsRatings.value[1.0] ?? 1.0).round().toString(),
                    onChanged: (value) {
                      //jobsController.updateSkillRating(5.0, value);
                    },
                  ),
                ],
              ),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const HeadingLarge(heading: "Add skills"),
              //     SizedBox(height: 10.h(context)),
              //     const BodyTextWidget(
              //       text:
              //       "Your skills will help us suggest the best job matches to you.",
              //     ),
              //     SizedBox(height: 30.h(context)),
              //     CustomTextField(
              //       titleText: "Skills",
              //       textInputType: TextInputType.text,
              //       textInputAction: TextInputAction.done,
              //       controller: jobsController.skillsSearchController,
              //       focusNode: jobsController.searchFocusNode,
              //       onChanged: (value) {
              //         jobsController.skillsSearchQuery.value = value;
              //       },
              //       onEditingComplete: () {
              //         if (jobsController.skillsSearchController.value.text.isNotEmpty) {
              //           jobsController.addSkill({
              //             "_id": jobsController.defaultItemId,
              //             "name": jobsController.skillsSearchController.value.text.trim(),
              //           });
              //           jobsController.skillsSearchQuery.value = '';
              //         }
              //       },
              //     ),
              //     Obx(() {
              //       if (jobsController.filteredSkillsSuggestions.isEmpty) {
              //         return Container();
              //       }
              //       return ConstrainedBox(
              //         constraints: BoxConstraints(maxHeight: 180.h(context)),
              //         child: Container(
              //           margin: const EdgeInsets.only(top: 6),
              //           decoration: BoxDecoration(
              //             borderRadius: const BorderRadius.all(Radius.circular(8)),
              //             border: Border.all(color: Colors.grey[350]!),
              //             color: AppColors.disabled.withOpacity(.6),
              //           ),
              //           child: SingleChildScrollView(
              //             child: Column(
              //               mainAxisSize: MainAxisSize.min,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: jobsController.filteredSkillsSuggestions
              //                   .map((suggestion) => ListTile(
              //                 dense: true,
              //                 title: Text(suggestion['name'] ?? ''),
              //                 onTap: () {
              //                   jobsController.addSkill(suggestion);
              //                   jobsController.skillsSearchQuery.value = '';
              //                 },
              //               ))
              //                   .toList(),
              //             ),
              //           ),
              //         ),
              //       );
              //     }),
              //     Obx(
              //           () => ErrorTextWidget(text: jobsController.errorMsg.value),
              //     ),
              //     SizedBox(height: 15.h(context)),
              //     Obx(
              //           () => Wrap(
              //         spacing: 8,
              //         runSpacing: 8,
              //         children: List.generate(
              //           jobsController.selectedSkills.length,
              //               (index) {
              //             var skill = jobsController.selectedSkills[index];
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 CustomChip(
              //                   text: skill['name'],
              //                   onRemove: () {
              //                     jobsController.removeSkill(skill);
              //                   },
              //                 ),
              //                 Obx(
              //                       () => Slider(
              //                     value: jobsController.skillsRatings.value[skill['_id']] ?? 5.0,
              //                     min: 1,
              //                     max: 10,
              //                     //divisions: 9,
              //                     label: (jobsController.skillsRatings.value[skill['_id']] ?? 5.0).round().toString(),
              //                     onChanged: (value) {
              //                       jobsController.updateSkillRating(skill['_id'], value);
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),


              SizedBox(height: 40.h(context)),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonPrimary(
                  btnText: 'Apply',
                  onPressed: () {
                    jobsController.submitJobApplication();
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