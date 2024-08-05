import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/MyApplication.dart';
import 'package:hirevire_app/user_interface/my_applications_tab/controllers/my_applications_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:hirevire_app/utils/string_handler.dart';

class MyApplicationsCard extends StatelessWidget {
  const MyApplicationsCard({
    super.key,
    required this.myApplicationsController,
    required this.myApplications,
    required this.index,
  });
  final MyApplicationsController myApplicationsController;
  final MyApplication myApplications;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkillChip(
                  text:
                      '${myApplications.jobPostId?.savedApplications?.length ?? '0'} applied'),
              Row(
                children: [
                  const GreenDot(),
                  const HorizontalSpace(),
                  Text(
                    myApplications.status == null
                        ? ''
                        : StringHandler.capitalizeFirstLetterOfWord(
                            myApplications.status!),
                    style: AppTextThemes.smallText(context),
                  ),
                ],
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              textWidget(
                context,
                'Company Name: ',
                color: AppColors.greyDisabled,
              ),
              textWidget(context, myApplications.jobPostId?.postedBy?.name ?? ''),
            ],
          ),
          const VerticalSpace(),
          jobTitle(context),
          const VerticalSpace(),
          Row(
            children: [
              myApplications.jobPostId?.location == null ? const SizedBox() : jobLocation(context),
              myApplications.jobPostId?.ctc == null ? const SizedBox() : ctcDetails(context),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       jobPostings.title ?? '',
          //       style: AppTextThemes.bodyTextStyle(context).copyWith(
          //         fontWeight: FontWeight.w300,
          //       ),
          //     ),
          //     const HorizontalSpace(space: 12),
          //
          //     Text(
          //       '${jobPostings.postedBy?.name ?? ''}',
          //       style: AppTextThemes.bodyTextStyle(context),
          //     ),
          //   ],
          // ),
          const VerticalSpace(),
          Row(
            children: [
              textWidget(
                context,
                'Hiring Manager: ',
                color: AppColors.greyDisabled,
              ),
              textWidget(context, myApplications.jobPostId?.requestedBy?.name ?? ''),
            ],
          ),
          const VerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  textWidget(
                    context,
                    'Openings: ',
                    color: AppColors.greyDisabled,
                  ),
                  textWidget(context,
                      '${myApplications.jobPostId?.savedApplications?.length ?? '0'}'),
                ],
              ),
              const VerticalSpace(),
              Row(
                children: [
                  textWidget(
                    context,
                    'Accepted: ',
                    color: AppColors.greyDisabled,
                  ),
                  textWidget(context,
                      '${myApplications.jobPostId?.savedApplications?.length ?? '0'}'),
                ],
              ),
            ],
          ),
          const VerticalSpace(),
          // Row(
          //   children: [
          //     Flexible(
          //       child: ButtonOutline(
          //         btnText: 'Edit Job Posting',
          //         height: 38.h(context),
          //         onPressed: () {
          //           Get.to(
          //             // EditJobPostingScreen(
          //             //   jobPostingsController: jobPostingsController,
          //             //   jobPostings: jobPostings,
          //             //   index: index,
          //             // ),
          //           );
          //         },
          //         textStyle: AppTextThemes.buttonTextStyle(context).copyWith(
          //           fontSize: 13,
          //           color: AppColors.primaryDark,
          //         ),
          //       ),
          //     ),
          //     const HorizontalSpace(),
          //     Flexible(
          //       child: ButtonPrimary(
          //         btnText: 'View applicants',
          //         btnColor: AppColors.primaryDark,
          //         height: 38.h(context),
          //         onPressed: () {
          //           Get.to(ApplicantsScreen(
          //             jobPostingsController: jobPostingsController,
          //             jobPostings: jobPostings,
          //             index: index,
          //           ));
          //         },
          //         textStyle: AppTextThemes.buttonTextStyle(context)
          //             .copyWith(fontSize: 13),
          //       ),
          //     ),
          //   ],
          //),
        ],
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: "${myApplications.jobPostId?.location!.country}, ",
          ),
          TextSpan(
            text: myApplications.jobPostId?.location!.city,
          ),
        ],
      ),
      style: AppTextThemes.secondaryTextStyle(context).copyWith(fontSize: 13.5,),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      '  ·  ${myApplications.jobPostId?.ctc} LPA',
      style: AppTextThemes.secondaryTextStyle(context).copyWith(fontSize: 13.5,),
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
      myApplications.jobPostId?.title ?? 'Unknown job title',
      style: AppTextThemes.subtitleStyle(context),
    );
  }
}
