import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/user_interface/presentation/profile_view/components/edit_job_posting_screen.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // First section with purple color
                  Container(
                    height: 70,
                    color: AppColors.primary,
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
                          space: 8,
                        ),
                        Obx(() {
                          return userHeadline(context);
                        }),
                        const VerticalSpace(
                          space: 4,
                        ),
                        Obx(() {
                          return jobLocation(context);
                        }),
                        const VerticalSpace(
                          space: 12,
                        ),
                        if (profileViewController.jobSeekerProfile.value.bio !=
                                null &&
                            profileViewController
                                .jobSeekerProfile.value.bio!.isNotEmpty)
                          userBioHeading(context),
                        const VerticalSpace(
                          space: 4,
                        ),
                        Obx(() {
                          return userBio(context);
                        }),
                        const VerticalSpace(
                          space: 8,
                        ),
                        Obx(() => userExperience(context)),
                        const VerticalSpace(
                          space: 4,
                        ),
                        // ExperienceSection(
                        //   profileViewController: profileViewController,
                        // ),
                        const VerticalSpace(
                          space: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 82,
              right: 16,
              child: ButtonOutline(
                btnText: 'Edit Profile',
                width: 150,
                height: 38.h(context),
                onPressed: () {
                  Get.to(() => EditUserProfileScreen(
                      profileViewController: profileViewController,
                      jobSeeker: profileViewController.jobSeekerProfile.value));
                },
                textStyle: AppTextThemes.buttonTextStyle(context).copyWith(
                  fontSize: 12,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 16,
              child: CircleAvatar(
                radius: 40,
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
    );
  }

  Text userName(BuildContext context) {
    return Text(
      profileViewController.jobSeekerProfile.value.name ?? '',
      style: AppTextThemes.screenTitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
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
      "User Bio",
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Text userBio(BuildContext context) {
    return Text(
      profileViewController.jobSeekerProfile.value.bio ?? '',
      style: AppTextThemes.secondaryTextStyle(context).copyWith(
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
}

// class ExperienceSection extends StatelessWidget {
//   const ExperienceSection({
//     super.key,
//     required this.profileViewController,
//   });

//   final ProfileViewController profileViewController;

//   String formatDate(DateTime? date) {
//     if (date == null) return '';
//     return DateFormat.yMMMd().format(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       var experienceList =
//           profileViewController.jobSeekerProfile.value.experience ?? [];

//       return SizedBox(
//         height: Responsive.height(context, 200),
//         child: ListView.builder(
//           shrinkWrap: true,
//           padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
//           itemCount: experienceList.length,
//           itemBuilder: (context, index) {
//             final experience = experienceList[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Timeline dot and line
//                   Column(
//                     children: [
//                       Container(
//                         height: 10,
//                         width: 10,
//                         decoration: BoxDecoration(
//                           color: AppColors.primary,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       if (index != experienceList.length - 1)
//                         Container(
//                           height: 50,
//                           width: 2,
//                           color: AppColors.primary,
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 20),
//                   // Experience card
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8.0),
//                       border: const Border(
//                         bottom:
//                             BorderSide(color: AppColors.primary, width: 2.0),
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             // Company logo
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                   experience.company?.data?.logoUrl ?? ''),
//                               radius: 20,
//                             ),
//                             const SizedBox(width: 10),
//                             // Title and company name
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   experience.title?.name ?? '',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16.0),
//                                 ),
//                                 Text(
//                                   experience.company?.name ?? '',
//                                   style: TextStyle(
//                                       fontSize: 14.0,
//                                       color: Colors.purple[600]),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                             // Employment type
//                             Text(
//                               experience.employmentType ?? '',
//                               style: TextStyle(
//                                   fontSize: 14.0, color: Colors.purple[600]),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         // Dates and location
//                         Row(
//                           children: [
//                             Text(
//                               '${formatDate(experience.startDate)} - ${experience.stillWorking == true ? "Present" : formatDate(experience.endDate)}',
//                               style: TextStyle(
//                                   fontSize: 14.0, color: Colors.purple[600]),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         // Location
//                         Text(
//                           experience.location?.city ?? '',
//                           style: TextStyle(
//                               fontSize: 14.0, color: Colors.purple[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     });
//   }
// }
