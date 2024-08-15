import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/employer_interface/models/job_posting.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';

import '../../../../constants/endpoint_constants.dart';
import '../../../../constants/error_constants.dart';
import '../../../../constants/global_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/capitalize_first_letter.dart';
import '../../../../utils/log_handler.dart';
import '../../../models/job_seeker_profile.dart';
import '../../../models/job_seeker_profile.dart' as jobLocation;

class ProfileViewController extends GetxController {
  late ApiClient apiClient;

  TextEditingController filterController = TextEditingController();

  RxList<String> selectedSpecializations = <String>[].obs;

  RxBool isLoading = false.obs;
  RxBool isCreatingJobPost = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;
  RxBool isClosedStatus = false.obs;
  RxBool matchesFetched = false.obs;

  RxString selectedProfileFileUrl = ''.obs;
  File? selectedProfileFile = File('');

  Rx<JobSeekerProfile> jobSeekerProfile = JobSeekerProfile().obs;

  TextEditingController jobseekerNameController = TextEditingController();
  TextEditingController jobseekerEmailController = TextEditingController();
  TextEditingController jobseekerPhoneController = TextEditingController();
  TextEditingController jobseekerHeadlineController = TextEditingController();
  TextEditingController locationCityController = TextEditingController();
  TextEditingController locationCountryController = TextEditingController();
  TextEditingController locationStateController = TextEditingController();
  RxString jobModeController = GlobalConstants.locationTypes[0].obs;
  TextEditingController vidReqController = TextEditingController();
  TextEditingController reqSkillsController = TextEditingController();
  TextEditingController jobseekerBioController = TextEditingController();
  TextEditingController jobseekerAddressLine1Controller =
      TextEditingController();
  TextEditingController jobseekerAddressLine2Controller =
      TextEditingController();
  TextEditingController openingCountController = TextEditingController();
  TextEditingController minCtcController = TextEditingController();
  TextEditingController maxCtcController = TextEditingController();
  TextEditingController tDaysPlanController = TextEditingController();
  TextEditingController sDaysPlanController = TextEditingController();
  TextEditingController nDaysPlanController = TextEditingController();
  TextEditingController qOneController = TextEditingController();
  TextEditingController qTwoController = TextEditingController();

  // Focus nodes
  FocusNode jobseekernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode locationCityFocusNode = FocusNode();
  FocusNode locationCountryFocusNode = FocusNode();
  FocusNode locationStateFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  FocusNode addressLine1FocusNode = FocusNode();
  FocusNode addressLine2FocusNode = FocusNode();
  FocusNode headlineFocusNode = FocusNode();
  FocusNode minCtcFocusNode = FocusNode();
  FocusNode githubFocusNode = FocusNode();
  FocusNode linkedinFocusNode = FocusNode();
  FocusNode twitterFocusNode = FocusNode();
  FocusNode qOneFocusNode = FocusNode();
  FocusNode qTwoFocusNode = FocusNode();

  RxString errorMsgJobSeekerName = ''.obs;
  RxString errorMsgLocation = ''.obs;
  RxString errorMsgEmail = ''.obs;
  RxString errorMsgPhone = ''.obs;
  RxString errorMsgBio = ''.obs;
  RxString errorMsgHeadline = ''.obs;
  RxString errorMsgJobMode = ''.obs;
  RxString errorMsgGithub = ''.obs;
  RxString errorMsgLinkedin = ''.obs;
  RxString errorMsgTwitter = ''.obs;

  void setRecruiterVideoThumbnail(String? profileUrl) {
    selectedProfileFileUrl.value = profileUrl ?? '';
  }

  void setJobTitle(String? jobTitle) {
    jobseekerNameController.text = jobTitle ?? '';
  }

  void setEmail(String? email) {
    jobseekerEmailController.text = email ?? '';
  }

  void setPhone(String? phone) {
    jobseekerPhoneController.text = phone ?? '';
  }

  void setLocation(jobLocation.Location? location) {
    locationCityController.text = location?.city ?? '';
    locationCountryController.text = location?.country ?? '';
    locationStateController.text = location?.state ?? '';
    jobseekerAddressLine1Controller.text = location?.address?.line1 ?? '';
    jobseekerAddressLine2Controller.text = location?.address?.line2 ?? '';
  }

  void setBio(String? perks) {
    jobModeController.value = jobseekerBioController.text = perks ?? '';
  }

  void setSocialGithub(String? growthPlan) {
    tDaysPlanController.text = growthPlan ?? '';
  }

  void setSocialLinkedIn(String? growthPlan) {
    sDaysPlanController.text = growthPlan ?? '';
  }

  void setSocialTwitter(String? growthPlan) {
    nDaysPlanController.text = growthPlan ?? '';
  }

  void setHeadline(String? headline) {
    jobseekerHeadlineController.text = headline ?? '';
  }

  void setJobMode(List<String>? jobMode) {
    if (jobMode == null || jobMode.isEmpty) {
      jobModeController.value = GlobalConstants.locationTypes[0];
    } else {
      jobModeController.value = capitalizeFirstLetter(
          jobMode?[0] ?? GlobalConstants.locationTypes[0]);
    }
  }

  void onFilesSelected(File? imageFile) {
    selectedProfileFile = imageFile;
  }

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchUserProfile();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
  }

  fetchUserProfile() async {
    String endpoint = EndpointService.getUserProfile;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);

      if (response['success']) {
        jobSeekerProfile.value =
            JobSeekerProfile.fromMap(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        ToastWidgit.bottomToast(errorMsg);
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      ToastWidgit.bottomToast(
          'Unknown error occurred while getting Job recommendations');
      LogHandler.error(error);
    }
  }

  updateUserProfile(JobSeekerProfile jobseeker) async {
    isCreatingJobPost.value = true;
    RxBool isError = false.obs;

    if (jobseekerNameController.text.isEmpty) {
      errorMsgJobSeekerName.value = 'name is required';
      //ToastWidgit.bottomToast('job title is required');
      isError.value = true;
    }

    if (locationCityController.text.isEmpty) {
      errorMsgLocation.value = 'city and country location is required';
      isError.value = true;
    }
    if (locationCountryController.text.isEmpty) {
      errorMsgLocation.value = 'city and country location is required';
      isError.value = true;
    }
    if (jobseekerBioController.text.isEmpty) {
      errorMsgBio.value = 'job bio is required';
      isError.value = true;
    }
    if (jobModeController.value == GlobalConstants.locationTypes[0]) {
      errorMsgJobMode.value = 'Select Job mode';
    }
    // if (minCtcController.text.isEmpty) {
    //   errorMsgHeadline.value = 'CTC range is required';
    //   isError.value = true;
    // }

    if (jobseekerEmailController.text.isEmpty) {
      errorMsgPhone.value = 'Email is required';
      isError.value = true;
    }
    if (jobseekerPhoneController.text.isEmpty) {
      errorMsgPhone.value = 'Phone is required';
      isError.value = true;
    }
    if (jobseekerHeadlineController.text.isEmpty) {
      errorMsgPhone.value = 'Headline is required';
      isError.value = true;
    }
    // if (tDaysPlanController.text.isEmpty) {
    //   errorMsgGithub.value = '30 days growth plan is required';
    //   isError.value = true;
    // }
    // if (sDaysPlanController.text.isEmpty) {
    //   errorMsgLinkedin.value = '60 days growth plan is required';
    //   isError.value = true;
    // }
    // if (nDaysPlanController.text.isEmpty) {
    //   errorMsgTwitter.value = '90 days growth plan is required';
    //   isError.value = true;
    // }

    if (isError.value) {
      isCreatingJobPost.value = false;
      //return;
    }

    String endpoint = EndpointService.updateUserProfile;

    Map<String, dynamic> body = {
      "name": jobseeker.name,
      "email": jobseeker.email ?? '',
      "phone": jobseeker.phone ?? '',
      "headline": jobseekerNameController.text.trim(),
      "bio": jobseeker.bio,
      "location": {
        "country": locationCountryController.text.trim(),
        "state": locationStateController.text.trim(),
        "city": locationCityController.text.trim(),
        "address": {
          "line1": jobseekerAddressLine1Controller.text.trim(),
          "line2": jobseekerAddressLine2Controller.text.trim()
        },
      },
      "preferredJobModes": [jobModeController.value],
      'socialUrls': [
        {
          "GitHub": tDaysPlanController.text.trim(),
        },
        {
          "LinkedIn": sDaysPlanController.text.trim(),
        },
        {
          "Twitter": nDaysPlanController.text.trim(),
        }
      ],
      "skills": jobseeker.skills?.map((s) => s.toMap()).toList(),
    };

    LogHandler.debug(body);

    try {
      if (selectedProfileFile != null && selectedProfileFile!.path.isNotEmpty) {
        await apiClient
            .uploadImageOrVideo(
          Endpoints.uploadUserMedia,
          selectedProfileFile!,
          //  thumbnailFile: selectedThumbnailFile!,
        )
            .then((response) async {
          if (response['success']) {
            // Handle success
            LogHandler.debug('Upload successful: $response');
            // videoUrl.value = response['body']['videoURL'][0];
            // thumbnailUrl.value = response['body']['thumbnailURL'].length > 0
            //     ? response['body']['thumbnailURL'][0]
            //     : '';

            // body['media'] = {
            //   'url': videoUrl.value,
            //   "type": "video",
            //   "thumbnail": thumbnailUrl.value
            // };
            // LogHandler.debug(body);

            Map<String, dynamic> responsePut =
                await apiClient.put(endpoint, body);

            LogHandler.debug(responsePut);

            if (responsePut['success']) {
              await fetchUserProfile();
              ToastWidgit.bottomToast('Updated profile');
              Get.back();
            } else {
              String errorMsg =
                  responsePut['error']['message'] ?? Errors.somethingWentWrong;
              LogHandler.error(errorMsg);
              ToastWidgit.bottomToast('Error updating profile');
            }
          } else {
            // Handle error
            debugPrint('Upload failed: ${response['error']}');
          }
        });
      } else {
        Map<String, dynamic> response = await apiClient.put(endpoint, body);
        LogHandler.debug(response);

        if (response['success']) {
          await fetchUserProfile();
          ToastWidgit.bottomToast('Profile updated successfully');
          Get.back();
        } else {
          String errorMsg =
              response['error']['message'] ?? Errors.somethingWentWrong;
          LogHandler.error(errorMsg);
        }
      }
    } catch (error) {
      LogHandler.error(error);
    } finally {
      isCreatingJobPost.value = false;
    }
  }
}
