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


            CustomTextField(
              titleText: 'Job Title',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: requisitionsController.jobTitleFocusNode,
              controller: requisitionsController.jobTitleController,
              onChanged: (String value) {},
              onEditingComplete: () {
                requisitionsController.jobTitleFocusNode.unfocus();
                FocusScope.of(context)
                    .requestFocus(requisitionsController.descFocusNode);
                },
            ),
            const VerticalSpace(),
            CustomTextField(
              titleText: 'Description',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLength: 2000,
              maxLines: 5,
              focusNode: requisitionsController.descFocusNode,
              controller: requisitionsController.descController,
              onChanged: (String value) {},
              onEditingComplete: () {
                requisitionsController.descFocusNode.unfocus();
                FocusScope.of(context)
                    .requestFocus(requisitionsController.reqSkillsFocusNode);
                },
            ),
            VerticalSpace(space: 8.h(context)),
            CustomTextField(
              titleText: 'Required Skills',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: requisitionsController.reqSkillsFocusNode,
              controller: requisitionsController.reqSkillsController,
              onChanged: (String value) {},
              onEditingComplete: () {
                requisitionsController.reqSkillsFocusNode.unfocus();
                FocusScope.of(context)
                    .requestFocus(requisitionsController.locationFocusNode);
              },
            ),
            const VerticalSpace(),
            CustomTextField(
              titleText: 'Location',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              focusNode: requisitionsController.locationFocusNode,
              controller: requisitionsController.locationController,
              onChanged: (String value) {},
              onEditingComplete: () {
                requisitionsController.locationFocusNode.unfocus();
                FocusScope.of(context)
                    .requestFocus(requisitionsController.perksFocusNode);
              },
            ),
            const VerticalSpace(),
            CustomTextField(
              titleText: 'Job Mode',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction
                  .done,
              controller: requisitionsController.jobModeController,
              onChanged: (String value) {},
              readOnly: true,
            ),
            VerticalSpace(space: 8.h(context)),
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
            VerticalSpace(space: 8.h(context)), // CustomTextField(
            CustomTextField(
              titleText: 'Perks',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLines: 4,
              focusNode: requisitionsController.perksFocusNode,
              controller: requisitionsController.perksController,
              onChanged: (String value) {},
              onEditingComplete: () {
                requisitionsController.perksFocusNode.unfocus();
                FocusScope.of(context)
                    .requestFocus(requisitionsController.ctcFocusNode);
              },
            ),
            VerticalSpace(space: 8.h(context)), // CustomTextField(
            CustomTextField(
              titleText: 'CTC',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              focusNode: requisitionsController.ctcFocusNode,
              controller: requisitionsController.ctcController,
              onChanged: (String value) {},
              onEditingComplete: () {
                requisitionsController.ctcFocusNode.unfocus();
                requisitionsController.createJobApplication(requisition);
              },
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
