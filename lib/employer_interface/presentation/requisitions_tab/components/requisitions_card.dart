import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/components/create_job_posting_screen.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/controllers/requisitions_controller.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/button_outline.dart';

class RequisitionsCard extends StatelessWidget {
  const RequisitionsCard({
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.w(context)),
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.disabled),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          jobTitle(context),
          const VerticalSpace(space: 3),
          Row(
            children: [
              Text(
                requisition.department == null
                    ? ''
                    : '${requisition.department},',
                style: AppTextThemes.bodyTextStyle(context).copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const HorizontalSpace(),
              Text(
                requisition.jobMode?[0].toUpperCase() ?? '',
                style: AppTextThemes.bodyTextStyle(context).copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              Text(
                'Openings:',
                style: AppTextThemes.secondaryTextStyle(context),
              ),
              const HorizontalSpace(),
              Text(
                '${requisition.openingsCount ?? 'Not specified'}',
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              Text(
                'Job Budget:',
                style: AppTextThemes.secondaryTextStyle(context),
              ),
              const HorizontalSpace(),
              Text(
                '${requisition.budgetAllocation ?? 'Not specified'}',
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              Flexible(
                child: ButtonPrimary(
                  btnText: 'Create Job Posting',
                  btnColor: AppColors.primaryDark,
                  onPressed: () {
                    Get.to(
                      CreateJobPostingScreen(
                        requisitionsController: requisitionsController,
                        requisition: requisition,
                        index: index,
                      ),
                    );
                  },
                  textStyle: AppTextThemes.buttonTextStyle(context),
                ),
              ),
              const HorizontalSpace(),
              Flexible(
                child: ButtonOutline(
                  btnText: 'View Job Postings',
                  onPressed: () {
                    //TODO: same screen as list of job postings tab
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      requisition.title ?? 'Unknown job title',
      style: AppTextThemes.subtitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
