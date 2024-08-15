import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
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
                  // First section with purple color
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
                  const VerticalSpace(
                    space: 40,
                  ),
                  Container(
                    //color: AppColors.disabled,
                    padding: const EdgeInsets.only(top: 20, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() {
                          return userName(context);
                        }),
                        const VerticalSpace(
                          space: 0,
                        ),
                        Obx(() {
                          return userHeadline(context);
                        }),
                        const VerticalSpace(
                          space: 0,
                        ),
                        Obx(() {
                          return jobLocation(context);
                        }),
                        const VerticalSpace(
                          space: 0,
                        ),
                        if (profileViewController.jobSeekerProfile.value.bio !=
                                null &&
                            profileViewController
                                .jobSeekerProfile.value.bio!.isNotEmpty)
                          const SectionTitle(title: 'About'),
                        const VerticalSpace(
                          space: 0,
                        ),
                        Obx(() {
                          return userBio(context);
                        }),
                        const VerticalSpace(
                          space: 8,
                        ),
                        if (profileViewController
                                .jobSeekerProfile.value.experience !=
                            null)
                          const SectionTitle(title: 'Experience'),
                        const VerticalSpace(
                          space: 4,
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
                                bool isLastItem =
                                    index == experiences.length - 1;

                                return Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Expanded(
                                    child:
                                        ExperienceCard(experience: experience),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     // Column(
                                  //     //   children: [
                                  //     //     //Timeline dots

                                  //     //     // if (!isLastItem)
                                  //     //     //   Container(
                                  //     //     //     height: 10,
                                  //     //     //     width: 10,
                                  //     //     //     decoration: const BoxDecoration(
                                  //     //     //       color: AppColors.primary,
                                  //     //     //       shape: BoxShape.circle,
                                  //     //     //     ),
                                  //     //     //   ),
                                  //     //     // Container(
                                  //     //     //   //height: 40,
                                  //     //     //   width: 2,
                                  //     //     //   color: AppColors.primary,
                                  //     //     // ),
                                  //     //     // if (isLastItem)
                                  //     //     //   Container(
                                  //     //     //     height: 10,
                                  //     //     //     width: 10,
                                  //     //     //     decoration: const BoxDecoration(
                                  //     //     //       color: AppColors.primary,
                                  //     //     //       shape: BoxShape.circle,
                                  //     //     //     ),
                                  //     //     //   ),

                                  //     //     CircleAvatar(
                                  //     //       backgroundImage: NetworkImage(
                                  //     //           experience.company?.data
                                  //     //                   ?.logoUrl ??
                                  //     //               ''),
                                  //     //       radius: 20,
                                  //     //     ),
                                  //     //   ],
                                  //     // ),
                                  //     Expanded(
                                  //         child: ExperienceCard(
                                  //             experience: experience)),
                                  //   ],
                                  // ),
                                  //),
                                );
                              },
                            );
                          } else {
                            return const SizedBox
                                .shrink(); // Empty space if no experiences
                          }
                        }),
                        const VerticalSpace(
                          space: 8,
                        ),
                        const SectionTitle(title: 'Social Handles'),
                        if (profileViewController
                                .jobSeekerProfile.value.socialUrls !=
                            null)
                          socialHandles(context),
                      ],
                    ),
                  ),
                  const VerticalSpace(
                    space: 40,
                  ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background, // Background color
                        border: Border.all(
                          // Adding the border
                          color: AppColors
                              .background, // Replace with the desired color
                          width: 4.0, // Width of the border
                        ),
                        borderRadius: BorderRadius.circular(
                            4.0), // Optional: Add border radius for rounded corners
                      ),
                      child: CustomImageView(
                        height: 24.0,
                        width: 24.0,
                        imagePath: ImageConstant.arrowLeft,
                        //padding: 16,
                        fit: BoxFit.contain,
                      ),
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
                  width: 150,
                  height: 38.h(context),
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
                  radius: 46,
                  backgroundColor: Colors.white,
                  child: Obx(
                    () => CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                        "${profileViewController.jobSeekerProfile.value.profilePicUrl ?? ''}",
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

  Text userName(BuildContext context) {
    return Text(
      profileViewController.jobSeekerProfile.value.name ?? '',
      style: AppTextThemes.screenTitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20.w(context),
      ),
    );
  }

  Text userHeadline(BuildContext context) {
    return Text(
      profileViewController.jobSeekerProfile.value.headline ?? '',
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text:
                "${profileViewController.jobSeekerProfile.value.location?.city ?? ''}, ",
          ),
          TextSpan(
            text: profileViewController
                    .jobSeekerProfile.value.location?.country ??
                '',
          ),
        ],
      ),
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }

  Text userBioHeading(BuildContext context) {
    return Text(
      "About",
      style: AppTextThemes.subtitleStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Text userBio(BuildContext context) {
    return Text(
      profileViewController.jobSeekerProfile.value.bio ?? '',
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.w(context),
      ),
    );
  }

  Text userExperience(BuildContext context) {
    return Text(
      profileViewController.jobSeekerProfile.value.experience != null
          ? "Experience"
          : "",
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Row socialHandles(BuildContext context) {
    return Row(
      children: List.generate(
        profileViewController.jobSeekerProfile.value.socialUrls!.length,
        (index) => SocialIconWidget(
          socialMedia:
              profileViewController.jobSeekerProfile.value.socialUrls![index],
        ),
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime? date) {
      if (date == null) return '';
      return DateFormat.yMMMd().format(date);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.gradientProfielCard,
            stops: AppColors.gradientPrimaryStops,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(experience.company?.data?.logoUrl ?? ''),
                    radius: 28,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.gradientProfielCard,
                    stops: AppColors.gradientPrimaryStops,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.title?.name ?? '',
                      style: AppTextThemes.bodyTextStyle(context).copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w(context),
                      ),
                    ),
                    Text(
                      '${experience.company?.name ?? ''}, ${experience.employmentType ?? ''}',
                      style: AppTextThemes.bodyTextStyle(context).copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w(context),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${formatDate(experience.startDate)} - ${experience.stillWorking == true ? "Present" : formatDate(experience.endDate)}',
                          style: AppTextThemes.secondaryTextStyle(context)
                              .copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.w(context),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${experience.location?.city ?? ''}, ${experience.location?.state ?? ''}, ${experience.location?.country ?? ''}',
                          style: AppTextThemes.secondaryTextStyle(context)
                              .copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.w(context),
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpace(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        '${experience.title?.data?.description ?? ''}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        style: AppTextThemes.bodyTextStyle(context).copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w(context),
                        ),
                      ),
                    ),
                    const VerticalSpace(),
                    Row(
                      children: [
                        CustomImageView(
                          width: 16.0,
                          height: 16.0,
                          imagePath: ImageConstant.bagIcon,
                          fit: BoxFit.contain,
                        ),
                        HorizontalSpace(),
                        Text(
                          '${experience.skills?.join(', ') ?? ''}',
                          style: AppTextThemes.bodyTextStyle(context).copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.w(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
