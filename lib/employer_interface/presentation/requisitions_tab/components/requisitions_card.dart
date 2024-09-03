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
import 'package:hirevire_app/utils/string_handler.dart';

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
        boxShadow: [
          BoxShadow(
            color: AppColors.greyDisabled.withOpacity(.2),
            offset: const Offset(0, 2),
            spreadRadius: 1,
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          jobTitle(context),
          const VerticalSpace(space: 3),
          Row(
            children: [
              textWidget(
                context,
                requisition.department == null
                    ? ''
                    : '${requisition.department}, ',
              ),
              textWidget(
                context,
                StringHandler.capitalizeFirstLetterOfWord(
                    requisition.jobMode![0]),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              textWidget(context, 'Openings: ', color: AppColors.greyDisabled),
              textWidget(
                  context, '${requisition.openingsCount ?? 'Not specified'}'),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              textWidget(
                context,
                'Job Budget: ',
                color: AppColors.greyDisabled,
              ),
              textWidget(context,
                  '${requisition.budgetAllocation ?? 'Not specified'}'),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              Flexible(
                child: ButtonPrimary(
                  btnText: 'Create Job Posting',
                  btnColor: AppColors.primaryDark,
                  height: 38.h(context),
                  onPressed: () {
                    Get.to(
                      () => CreateJobPostingScreen(
                        requisitionsController: requisitionsController,
                        requisition: requisition,
                        index: index,
                      ),
                    );
                  },
                  textStyle: AppTextThemes.buttonTextStyle(context)
                      .copyWith(fontSize: 13),
                ),
              ),
              // const HorizontalSpace(),
              // Flexible(
              //   child: ButtonOutline(
              //     btnText: 'View Job Postings',
              //     height: 38.h(context),
              //     onPressed: () {
              //       //TODO: same screen as list of job postings tab
              //     },
              //     textStyle: AppTextThemes.buttonTextStyle(context).copyWith(
              //       fontSize: 13,
              //       color: AppColors.primaryDark,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Text textWidget(BuildContext context, String text, {Color? color}) {
    return Text(
      text,
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontSize: 13.5,
        color: color ?? AppColors.textPrimary,
      ),
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      requisition.title ?? 'Unknown job title',
      style: AppTextThemes.subtitleStyle(context),
    );
  }
}
