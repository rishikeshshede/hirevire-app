import 'dart:ui';
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
      margin: EdgeInsets.all(12.w(context)),
      padding: EdgeInsets.all(8.w(context)),
      decoration: BoxDecoration(
        color: AppColors.disabled,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            jobTitle(context),
            const VerticalSpace(space: 4,),
            Row(
              children: [
                Text(
                  requisition.department ?? '',
                  style: AppTextThemes.bodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  ',',
                  style: AppTextThemes.bodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const HorizontalSpace(),
                Text(
                  requisition.jobMode?[0].toUpperCase() ?? '',
                  style: AppTextThemes.bodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const VerticalSpace(),
            Row(
              children: [
                Text(
                  'Openings',
                  style: AppTextThemes.secondaryTextStyle(context),
                ),
                const HorizontalSpace(),
                Text(
                  '${requisition.openingsCount ?? '0'}',
                  style: AppTextThemes.bodyTextStyle(context),
                ),
              ],
            ),
            const VerticalSpace(),
            Row(
              children: [
                Text(
                  'Job Budget',
                  style: AppTextThemes.secondaryTextStyle(context),
                ),
                const HorizontalSpace(),
                Text(
                  '${requisition.budgetAllocation ?? '0'}',
                  style: AppTextThemes.bodyTextStyle(context),
                ),
              ],
            ),

            const VerticalSpace(),
            // Row(
            //   children: [
            //     Text(
            //       'Recruiter',
            //       style: AppTextThemes.secondaryTextStyle(context),
            //     ),
            //     const HorizontalSpace(),
            //     Text(
            //       '${requisition.recruiter ?? ''}',
            //       style: AppTextThemes.bodyTextStyle(context),
            //     ),
            //   ],
            // ),
            // const VerticalSpace(),

            Row(
              children: [
                Flexible(
                  child: ButtonPrimary(
                    btnText: 'Create Job Posting',
                    btnColor: AppColors.primaryDark,
                    onPressed: () {
                      Get.to(CreateJobPostingScreen(requisitionsController: requisitionsController, requisition: requisition, index: index));
                      //Get.toNamed(AppRoutes.createJobPosting);
                    },
                    textStyle: AppTextThemes.genericTextStyle(
                      context,
                      color: AppColors.background,
                    ),
                  ),
                ),
                const HorizontalSpace(space: 8),
                Flexible(
                  child:  ButtonOutline(
                    btnText: 'View Job Posting',
                    onPressed: () {},
                    textStyle: AppTextThemes.genericTextStyle(
                      context,
                      customFontSize: 14.0,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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

