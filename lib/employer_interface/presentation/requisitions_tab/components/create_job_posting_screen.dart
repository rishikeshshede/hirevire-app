import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../common/widgets/video_upload_widget.dart';
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

    return PaddedContainer(
      screenTitle: "Create Job Posting",
      child: SingleChildScrollView(
        child: Column(
          children: [
            VideoUploadWidget(
                onFilesSelected: requisitionsController.onFilesSelected),
            VerticalSpace(space: 40.h(context)),

            // TODO: Add focus nodes in all text fields
            CustomTextField(
              titleText: 'Job Title',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: requisitionsController.jobTitleFocusNode,
              controller: requisitionsController.jobTitleController,
              onChanged: (String value) {
                // TODO: Add null check validation method in controller for all text fields
              },
              onEditingComplete: () {
                requisitionsController.jobTitleFocusNode.unfocus();
                FocusScope.of(context)
                    .requestFocus(requisitionsController.descFocusNode);

                // TODO: add such onEditingComplete everywhere (to handle focus of NON readOnly fields)
              },
            ),
            const VerticalSpace(),
            CustomTextField(
              titleText: 'Description',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLength: 2000,
              maxLines: 5,
              controller: requisitionsController.descController,
              onChanged: (String value) {},
            ),
            SizedBox(height: 8.h(context)),
            CustomTextField(
              titleText: 'Required Skills',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: requisitionsController.reqSkillsController,
              onChanged: (String value) {},
            ),
            const VerticalSpace(),
            CustomTextField(
              titleText: 'Location',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: requisitionsController.locationController,
              onChanged: (String value) {},
            ),
            const VerticalSpace(),
            CustomTextField(
              titleText: 'Job Mode',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction
                  .done, // TODO: use correct textInputAction (next / done)
              controller: requisitionsController.jobModeController,
              onChanged: (String value) {},
              readOnly: true,
            ),
            SizedBox(
                height: 8.h(
                    context)), // TODO: use already existing widgets like (VerticalSpace()) or create new, dont't repeat code
            // CustomTextField(
            //   titleText: 'Video Requirement',
            //   textInputType: TextInputType.text,
            //   textInputAction: TextInputAction.done,
            //   controller: requisitionsController.vidReqController,
            //   onChanged: (String value) {},
            // ),
            // SizedBox(height: 8.h(context)),
            CustomTextField(
              titleText: 'Opening Count',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: requisitionsController.openingCountController,
              onChanged: (String value) {},
              readOnly: true,
            ),
            SizedBox(height: 8.h(context)),
            CustomTextField(
              titleText: 'Perks',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 4,
              controller: requisitionsController.perksController,
              onChanged: (String value) {},
            ),
            SizedBox(height: 8.h(context)),
            CustomTextField(
              titleText: 'CTC',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: requisitionsController.ctcController,
              onChanged: (String value) {},
              // readOnly: true,
            ),
            const VerticalSpace(space: 15),
            ButtonPrimary(
              btnText: 'Submit',
              onPressed: () {
                requisitionsController.createJobApplication(requisition);
              },
            ),
            const VerticalSpace(space: 30),
          ],
        ),
      ),
    );
  }
}
