import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/button_circular.dart';
import '../../../../common/widgets/loader_circular.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../common/widgets/title_textbox.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_constants.dart';
import '../../../models/job_model.dart';
import '../controllers/jobs_controller.dart';

class JobApplicationForm extends StatelessWidget {
  const JobApplicationForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final jobsController = args['jobsController'];
    final job = args['job'];
    final index = args['index'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w(context)),
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40.h(context)),
          const TextboxTitle(title: "Your strength(%)"),
          CustomTextField(
            autofocus: true,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: jobsController.nameController,
            focusNode: jobsController.nameFocusNode,
            onChanged: (String value) {

            },
            onEditingComplete: () {
              jobsController.nameFocusNode.unfocus();
            },
          ),


          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonCircular(
                  icon: ImageConstant.tickIcon,
                  onPressed: () {
                    jobsController.submitJobApplication();
                  },
                  isActive: true,
              ),
            ],
          ),
          SizedBox(height: 16.h(context)),
        ],
    ),
    );
  }

}