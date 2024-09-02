import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/MyApplication.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/size_util.dart';
import 'package:hirevire_app/utils/string_handler.dart';

import '../controllers/my_applications_controller.dart';

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
              Row(
                children: [
                  Text(
                    DatetimeUtil.formatToDateOnlyString(
                        myApplications.updatedAt),
                    style: AppTextThemes.secondaryTextStyle(context)
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  myApplications.status!.toLowerCase() == 'rejected'
                      ? const DotWidget(color: AppColors.red)
                      : const DotWidget(),
                  const HorizontalSpace(),
                  Text(
                    myApplications.status == null
                        ? ''
                        : StringHandler.capitalizeFirstLetterOfWord(
                            myApplications.status!),
                    style: AppTextThemes.smallText(context).copyWith(
                      color: myApplications.status!.toLowerCase() == 'rejected'
                          ? AppColors.red
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const VerticalSpace(),
          jobTitle(context),
          const VerticalSpace(),
          Row(
            children: [
              // textWidget(
              //   context,
              //   'Company Name: ',
              //   color: AppColors.greyDisabled,
              // ),
              Text(
                myApplications.jobPostId?.postedBy?.name ?? 'Unknown company',
                style: AppTextThemes.bodyTextStyle(context).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              myApplications.jobPostId?.location == null
                  ? const SizedBox()
                  : jobLocation(context),
              myApplications.jobPostId?.ctc == null
                  ? const SizedBox()
                  : ctcDetails(context),
            ],
          ),
          myApplications.jobPostId?.postedBy?.name == null
              ? const SizedBox()
              : const VerticalSpace(),
          myApplications.jobPostId?.postedBy?.name == null
              ? const SizedBox()
              : Row(
                  children: [
                    textWidget(
                      context,
                      'Recruiter: ',
                      color: AppColors.greyDisabled,
                    ),
                    textWidget(context,
                        myApplications.jobPostId?.postedBy?.name ?? ''),
                  ],
                ),
          myApplications.jobPostId?.postedBy?.name == null
              ? const SizedBox()
              : const VerticalSpace(),
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
      style: AppTextThemes.secondaryTextStyle(context).copyWith(
        fontSize: 13.5,
      ),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      '  ·  ${myApplications.jobPostId?.ctc} LPA',
      style: AppTextThemes.secondaryTextStyle(context).copyWith(
        fontSize: 13.5,
      ),
    );
  }

  Text textWidget(BuildContext context, String text, {Color? color}) {
    return Text(
      text,
      style: AppTextThemes.bodyTextStyle(context).copyWith(
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
