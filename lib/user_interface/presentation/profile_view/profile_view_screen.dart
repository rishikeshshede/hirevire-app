import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/shimmer_widgets.dart';
import 'package:hirevire_app/common/widgets/social_icon_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/models/job_seeker_profile.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/components/section_title.dart';
import 'package:hirevire_app/user_interface/presentation/profile_view/components/edit_user_profile_screen.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../common/widgets/button_outline.dart';
import '../../../common/widgets/spacing_widget.dart';
import '../../../themes/text_theme.dart';
import '../../../utils/responsive.dart';
import 'controllers/profile_view_controller.dart';
import 'package:intl/intl.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  static final ProfileViewController profileViewController =
      Get.find(tag: 'profileViewController');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.lavenderLight, // Set the status bar color
        statusBarIconBrightness:
            Brightness.dark, // Set the status bar icons to black
      ));
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.gradientProfielCard,
                        stops: AppColors.gradientPrimaryStops,
                      ),
                    ),
                  ),
                  const VerticalSpace(space: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        return userName(context);
                      }),
                      Obx(() {
                        return userHeadline(context);
                      }),
                      const VerticalSpace(space: 8),
                      Obx(() {
                        return jobLocation(context);
                      }),
                      const SectionDivider(),
                      if (profileViewController.jobSeekerProfile.value.bio !=
                              null &&
                          profileViewController
                              .jobSeekerProfile.value.bio!.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: SectionTitle(
                              title: 'About', marginBottom: 5, marginTop: 0),
                        ),
                      Obx(() {
                        return userBio(context);
                      }),
                      const SectionDivider(),
                      if (profileViewController
                              .jobSeekerProfile.value.experience !=
                          null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 12),
                          child: SectionTitle(
                            title: 'Experience',
                            marginBottom: 5,
                            marginTop: 0,
                          ),
                        ),
                      Obx(() {
                        var experiences = profileViewController
                                .jobSeekerProfile.value.experience ??
                            [];
                        if (experiences.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: experiences.length,
                            itemBuilder: (context, index) {
                              var experience = experiences[index];
                              bool isLast = index == experiences.length - 1;
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Expanded(
                                  child: ExperienceCard(
                                      experience: experience, isLast: isLast),
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox
                              .shrink(); // Empty space if no experiences
                        }
                      }),
                      const SectionDivider(),
                      Obx(
                        () => profileViewController
                                    .jobSeekerProfile.value.socialUrls !=
                                null
                            ? const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: SectionTitle(
                                  title: 'Social Handles',
                                  marginBottom: 5,
                                  marginTop: 0,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => profileViewController
                                    .jobSeekerProfile.value.socialUrls !=
                                null
                            ? socialHandles(context)
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const VerticalSpace(space: 40),
                ],
              ),
              Positioned(
                //top: 12,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomImageView(
                      height: 24.0,
                      width: 24.0,
                      imagePath: ImageConstant.arrowLeft,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 132,
                right: 16,
                child: ButtonOutline(
                  borderRadius: 18,
                  btnText: 'Edit Profile',
                  width: 100.w(context),
                  height: 34.h(context),
                  onPressed: () {
                    Get.to(() => EditUserProfileScreen(
                        profileViewController: profileViewController,
                        jobSeeker:
                            profileViewController.jobSeekerProfile.value));
                  },
                  textStyle: AppTextThemes.buttonTextStyle(context).copyWith(
                    fontSize: 12,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 16,
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: Obx(
                    () => CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                        profileViewController
                                .jobSeekerProfile.value.profilePicUrl ??
                            '',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding userName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12),
      child: Text(
        profileViewController.jobSeekerProfile.value.name ?? '',
        style: AppTextThemes.screenTitleStyle(context).copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Padding userHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        profileViewController.jobSeekerProfile.value.headline ?? '',
        style: AppTextThemes.mediumTextStyle(context).copyWith(fontSize: 14),
      ),
    );
  }

  Widget jobLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text:
                  "${profileViewController.jobSeekerProfile.value.location?.city ?? ''}, ",
            ),
            TextSpan(
              text: profileViewController
                          .jobSeekerProfile.value.location?.state ==
                      null
                  ? ''
                  : "${profileViewController.jobSeekerProfile.value.location?.state}, ",
            ),
            TextSpan(
              text: profileViewController
                      .jobSeekerProfile.value.location?.country ??
                  '',
            ),
          ],
        ),
        style: AppTextThemes.smallText(context).copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget userBioHeading(BuildContext context) {
    return Text(
      "About",
      style: AppTextThemes.subtitleStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Widget userBio(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        profileViewController.jobSeekerProfile.value.bio ?? '',
        style: AppTextThemes.bodyTextStyle(context),
      ),
    );
  }

  Widget socialHandles(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: List.generate(
          profileViewController.jobSeekerProfile.value.socialUrls!.length,
          (index) => SocialIconWidget(
            socialMedia:
                profileViewController.jobSeekerProfile.value.socialUrls![index],
          ),
        ),
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 6,
      color: AppColors.disabled,
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const ExperienceCard(
      {super.key, required this.experience, required this.isLast});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime? date) {
      if (date == null) return '';
      return DateFormat.yMMMd().format(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: experience.company?.data?.logoUrl ?? '',
                width: 36,
                height: 36,
                fit: BoxFit.contain,
                placeholderWidget: Shimmers.box(
                  context,
                  width: 36,
                  height: 36,
                ),
              ),
              const HorizontalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.title?.name ?? '',
                    style: AppTextThemes.mediumTextStyle(context).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${experience.company?.name ?? ''}, ${experience.employmentType ?? ''}',
                    style: AppTextThemes.smallText(context),
                  ),
                  Row(
                    children: [
                      Text(
                        '${formatDate(experience.startDate)} - ${experience.stillWorking == true ? "Present" : formatDate(experience.endDate)}',
                        style: AppTextThemes.smallText(context).copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${experience.location?.city ?? ''}, ${experience.location?.state ?? ''}, ${experience.location?.country ?? ''}',
                        style: AppTextThemes.smallText(context).copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpace(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: Text(
                      experience.title?.data?.description ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      style: AppTextThemes.smallText(context),
                    ),
                  ),
                  const VerticalSpace(),
                  if (experience.skills!.isNotEmpty)
                    Row(
                      children: [
                        CustomImageView(
                          width: 16.0,
                          height: 16.0,
                          imagePath: ImageConstant.bagIcon,
                          fit: BoxFit.contain,
                        ),
                        const HorizontalSpace(),
                        SizedBox(
                          height: 20.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: experience.skills?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(experience.skills?[index].name ==
                                        null
                                    ? ''
                                    : index == experience.skills!.length - 1
                                        ? "${experience.skills?[index].name}"
                                        : "${experience.skills?[index].name},"),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          if (!isLast)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Divider(
                thickness: .2,
                color: AppColors.textSecondary,
              ),
            ),
          if (isLast) const SizedBox(height: 10),
        ],
      ),
    );
  }
}
