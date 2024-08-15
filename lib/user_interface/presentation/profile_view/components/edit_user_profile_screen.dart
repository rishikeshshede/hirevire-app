import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/profile_upload_widget.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/user_interface/models/job_seeker_profile.dart';
import 'package:hirevire_app/user_interface/presentation/profile_view/controllers/profile_view_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../../common/widgets/button_primary.dart';
import '../../../../common/widgets/chip_widget.dart';
import '../../../../common/widgets/dropdown_widget.dart';
import '../../../../common/widgets/error_text_widget.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../constants/global_constants.dart';
import '../../../../themes/text_theme.dart';
import 'package:get/get.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({
    super.key,
    required this.profileViewController,
    required this.jobSeeker,
  });

  final ProfileViewController profileViewController;
  final JobSeekerProfile jobSeeker;

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  @override
  void initState() {
    super.initState();
    widget.profileViewController.setJobTitle(widget.jobSeeker.name);
    widget.profileViewController.setEmail(widget.jobSeeker.email);
    widget.profileViewController.setPhone(widget.jobSeeker.phone);
    widget.profileViewController.setBio(widget.jobSeeker.bio);
    // widget.profileViewController.setSocialGithub(widget.jobSeeker.socialUrls);
    // widget.profileViewController.setSocialLinkedIn(widget.jobSeeker.socialUrls);
    // widget.profileViewController.setSocialTwitter(widget.jobSeeker.socialUrls);
    widget.profileViewController.setHeadline(widget.jobSeeker.headline);
    widget.profileViewController.setLocation(widget.jobSeeker.location);
    widget.profileViewController
        .setJobMode(widget.jobSeeker.preferredJobModes ?? []);
    widget.profileViewController
        .setRecruiterVideoThumbnail(widget.jobSeeker.profilePicUrl);
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      screenTitle: "Edit Profile",
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileUploadWidget(
                    onFileSelected:
                        widget.profileViewController.onFilesSelected,
                    profileImageUrl: widget.jobSeeker.profilePicUrl,
                    selectedProfileFile:
                        widget.profileViewController.selectedProfileFile,
                    titleText: 'Upload Profile Picture',
                  ),
                  VerticalSpace(space: 20.h(context)),

                  CustomTextField(
                    titleText: 'Name',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode:
                        widget.profileViewController.jobseekernameFocusNode,
                    controller:
                        widget.profileViewController.jobseekerNameController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.jobseekernameFocusNode
                          .unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.emailFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                          text: widget.profileViewController
                              .errorMsgJobSeekerName.value,
                        ),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Email',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.profileViewController.emailFocusNode,
                    controller:
                        widget.profileViewController.jobseekerEmailController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.emailFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.phoneFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                          text:
                              widget.profileViewController.errorMsgEmail.value,
                        ),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Phone',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.profileViewController.phoneFocusNode,
                    controller:
                        widget.profileViewController.jobseekerPhoneController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.phoneFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.headlineFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                          text:
                              widget.profileViewController.errorMsgPhone.value,
                        ),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Headline',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.profileViewController.headlineFocusNode,
                    controller: widget
                        .profileViewController.jobseekerHeadlineController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.headlineFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.bioFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                          text: widget
                              .profileViewController.errorMsgHeadline.value,
                        ),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Bio',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 2000,
                    maxLines: 5,
                    focusNode: widget.profileViewController.bioFocusNode,
                    controller:
                        widget.profileViewController.jobseekerBioController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.bioFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.addressLine1FocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text:
                                widget.profileViewController.errorMsgBio.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Address Line 1',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 100,
                    maxLines: 1,
                    focusNode:
                        widget.profileViewController.addressLine1FocusNode,
                    controller: widget
                        .profileViewController.jobseekerAddressLine1Controller,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.addressLine1FocusNode
                          .unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.addressLine2FocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text:
                                widget.profileViewController.errorMsgBio.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Address Line 2',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 100,
                    maxLines: 1,
                    focusNode:
                        widget.profileViewController.addressLine2FocusNode,
                    controller: widget
                        .profileViewController.jobseekerAddressLine2Controller,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.addressLine2FocusNode
                          .unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.locationCityFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text:
                                widget.profileViewController.errorMsgBio.value),
                      ],
                    ),
                  ),

                  VerticalSpace(space: 8.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        titleText: 'City',
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        focusNode:
                            widget.profileViewController.locationCityFocusNode,
                        controller:
                            widget.profileViewController.locationCityController,
                        onChanged: (String value) {},
                        onEditingComplete: () {
                          widget.profileViewController.locationCityFocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(widget
                              .profileViewController.locationCountryFocusNode);
                        },
                      ),
                      const HorizontalSpace(space: 4),
                      CustomTextField(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        titleText: 'State',
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        focusNode:
                            widget.profileViewController.locationStateFocusNode,
                        controller: widget
                            .profileViewController.locationStateController,
                        onChanged: (String value) {},
                        onEditingComplete: () {
                          widget.profileViewController.locationStateFocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(widget
                              .profileViewController.locationCountryFocusNode);
                        },
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .profileViewController.errorMsgLocation.value),
                      ],
                    ),
                  ),
                  VerticalSpace(space: 8.h(context)),

                  CustomTextField(
                    titleText: 'Country',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 100,
                    maxLines: 1,
                    focusNode:
                        widget.profileViewController.locationCountryFocusNode,
                    controller:
                        widget.profileViewController.locationCountryController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.locationCountryFocusNode
                          .unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.githubFocusNode);
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text:
                                widget.profileViewController.errorMsgBio.value),
                      ],
                    ),
                  ),

                  VerticalSpace(space: 8.h(context)),

                  Obx(
                    () => DropdownWidget(
                      controller: widget.profileViewController,
                      title: 'Job mode',
                      list: GlobalConstants.locationTypes,
                      initialValue:
                          widget.profileViewController.jobModeController.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          widget.profileViewController.jobModeController.value =
                              value;
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ErrorTextWidget(
                            text: widget
                                .profileViewController.errorMsgJobMode.value),
                      ],
                    ),
                  ),

                  VerticalSpace(space: 8.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Social Profiles',
                        style: AppTextThemes.subtitleStyle(context)
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const VerticalSpace(),
                  CustomTextField(
                    titleText: 'Github',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.profileViewController.githubFocusNode,
                    controller:
                        widget.profileViewController.tDaysPlanController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.githubFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.linkedinFocusNode);
                    },
                  ),
                  // Obx(
                  //   () => Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       ErrorTextWidget(
                  //           text: widget.profileViewController
                  //               .errorMsgGrowthPlanThi.value),
                  //     ],
                  //   ),
                  // ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                    titleText: 'LinkedIn',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: widget.profileViewController.linkedinFocusNode,
                    controller:
                        widget.profileViewController.sDaysPlanController,
                    onChanged: (String value) {},
                    onEditingComplete: () {
                      widget.profileViewController.linkedinFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                          widget.profileViewController.twitterFocusNode);
                    },
                  ),
                  // Obx(
                  //   () => Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       ErrorTextWidget(
                  //           text: widget.profileViewController
                  //               .errorMsgGrowthPlanSix.value),
                  //     ],
                  //   ),
                  // ),
                  VerticalSpace(space: 8.h(context)),
                  CustomTextField(
                      titleText: 'Twitter',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: widget.profileViewController.twitterFocusNode,
                      controller:
                          widget.profileViewController.nDaysPlanController,
                      onChanged: (String value) {},
                      onEditingComplete: () {
                        widget.profileViewController.twitterFocusNode.unfocus();
                      }),
                  // Obx(
                  //   () => Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       ErrorTextWidget(
                  //           text: widget.profileViewController
                  //               .errorMsgGrowthPlan3Mon.value),
                  //     ],
                  //   ),
                  // ),
                  VerticalSpace(space: 8.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Preferred Skills',
                        style: AppTextThemes.subtitleStyle(context)
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  VerticalSpace(space: 4.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      requiredSkills(),
                    ],
                  ),

                  // VerticalSpace(space: 4.h(context)),
                  // Obx(() => SwitchListTile(
                  //       title: const Text('Close Status'),
                  //       value:
                  //           widget.profileViewController.isClosedStatus.value,
                  //       onChanged: (bool value) {
                  //         widget.profileViewController.isClosedStatus.value =
                  //             value;
                  //       },
                  //     )),

                  const VerticalSpace(space: 20),
                  Obx(
                    () => ButtonPrimary(
                      btnText: 'Update',
                      onPressed: () {
                        widget.profileViewController
                            .updateUserProfile(widget.jobSeeker);
                      },
                      showLoading:
                          widget.profileViewController.isCreatingJobPost.value,
                    ),
                  ),
                  const VerticalSpace(space: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Wrap requiredSkills() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        widget.jobSeeker.skills?.length ?? 0,
        (index) => SkillChip(
            text: widget.jobSeeker.skills?[index].skill?.name ?? 'No skill'),
      ),
    );
  }
}
