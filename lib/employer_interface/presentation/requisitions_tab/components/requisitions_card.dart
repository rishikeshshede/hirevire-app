import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/common/widgets/chip_widget.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/green_dot.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/controllers/requisitions_controller.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_model.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../../../../common/widgets/VideoPlayerWidget.dart';
import '../../../../common/widgets/button_outline.dart';

class RequisitionsCard extends StatelessWidget {
  const RequisitionsCard({
    super.key,
    required this.requisitionsController,
    required this.requisition,
    required this.index,
  });
  final RequisitionsController requisitionsController;
  final JobModel requisition;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.w(context)),
      padding: EdgeInsets.all(8.w(context)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          jobTitle(context),
          const VerticalSpace(space: 4,),
          Text(
            requisition.companyName ?? '',
            style: AppTextThemes.bodyTextStyle(context).copyWith(
              fontWeight: FontWeight.w300,
            ),
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
                '${requisition.applicants ?? ''}',
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ],
          ),
          const VerticalSpace(),
          Row(
            children: [
              Text(
                'Hiring Manager',
                style: AppTextThemes.secondaryTextStyle(context),
              ),
              const HorizontalSpace(),
              Text(
                '${requisition.recruiter ?? ''}',
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ],
          ),

          const VerticalSpace(),
          Row(
            children: [
              Text(
                'Recruiter',
                style: AppTextThemes.secondaryTextStyle(context),
              ),
              const HorizontalSpace(),
              Text(
                '${requisition.recruiter ?? ''}',
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ],
          ),
          const VerticalSpace(),

          Row(
            children: [
              Flexible(
                child: ButtonPrimary(
                  btnText: 'Create job Posting',
                  btnColor: AppColors.primaryDark,
                  onPressed: () {
                    Get.toNamed(AppRoutes.createJobPosting);
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
                  btnText: 'View job Posting',
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
    );
  }

  Row companyDetails(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(
          imagePath: requisition.companyLogoUrl,
          height: 24,
          imageType: ImageType.network,
          showLoader: false,
        ),
        const HorizontalSpace(),
        Text(
          requisition.companyName ?? '',
          style: AppTextThemes.bodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Text jobPostingDate(BuildContext context) {
    return Text(
      requisitionsController.getPostTime(requisition.postedOn ?? DateTime.now()),
      style: AppTextThemes.smallText(context),
    );
  }


  Positioned applicantsCount(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GreenDot(),
          const HorizontalSpace(),
          Text(
            '${requisition.applicants} applicants',
            style: AppTextThemes.buttonTextStyle(context),
          ),
        ],
      ),
    );
  }

  Positioned recruiterDetails(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: Responsive.width(context, 1) - (8.w(context) * 2) - 20,
            padding: const EdgeInsets.all(8.0),
            color: Colors.black.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      requisition.recruiter ?? 'Unknown',
                      style: AppTextThemes.screenTitleStyle(context).copyWith(
                        color: AppColors.background,
                      ),
                    ),
                    Text(
                      requisition.recruiterDesignation ?? 'Recruiter',
                      style: AppTextThemes.smallText(context).copyWith(
                        color: AppColors.background,
                      ),
                    ),
                  ],
                ),
                chatWithRecruiter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomImageView chatWithRecruiter() {
    return CustomImageView(
      imagePath: ImageConstant.chatButtonIcon,
      height: 32,
      imageType: ImageType.png,
    );
  }

  Text jobTitle(BuildContext context) {
    return Text(
      requisition.jobTitle ?? 'Unknown job title',
      style: AppTextThemes.titleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text(
      requisition.location ?? '',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Text ctcDetails(BuildContext context) {
    return Text(
      requisition.ctc == null ? '' : '  ·  ${requisition.ctc} LPA',
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Wrap requiredSkills() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        requisition.skills!.length,
        (index) => SkillChip(skill: requisition.skills![index]),
      ),
    );
  }

  ExpansionPanel planWidget(BuildContext context, GrowthPlan plan, int index) {
    return ExpansionPanel(
      headerBuilder: (c, isOpen) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Text(
            plan.title ?? 'Plan $index',
            style: AppTextThemes.subtitleStyle(context),
          ),
        );
      },
      body: Text(
        plan.description ?? 'No plan provided',
        style: AppTextThemes.bodyTextStyle(context),
      ),
      isExpanded: requisitionsController.isOpen[index],
      canTapOnHeader: true,
      backgroundColor: AppColors.background,
    );
  }

  Text perks(BuildContext context) {
    return Text(
      requisition.perks ?? 'Not mentioned',
      style: AppTextThemes.bodyTextStyle(context),
    );
  }

  Row socialHandles(BuildContext context) {
    return Row(
      children: List.generate(
        requisition.socialHandles!.length,
        (index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          margin: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: GlobalConstants
                    .socialProfileTypesMap[requisition.socialHandles![index].platform],
                height: 30.w(context),
              ),
              Text(
                requisition.socialHandles![index].platform ?? 'Other',
                style: AppTextThemes.extraSmallText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: AppTextThemes.screenTitleStyle(context).copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
