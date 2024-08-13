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
  TextEditingController openingCountController = TextEditingController();
  TextEditingController minCtcController = TextEditingController();
  TextEditingController maxCtcController = TextEditingController();
  TextEditingController tDaysPlanController = TextEditingController();
  TextEditingController sDaysPlanController = TextEditingController();
  TextEditingController nDaysPlanController = TextEditingController();
  TextEditingController qOneController = TextEditingController();
  TextEditingController qTwoController = TextEditingController();

  // Focus nodes
  FocusNode jobTitleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode locationCityFocusNode = FocusNode();
  FocusNode locationCountryFocusNode = FocusNode();
  FocusNode openingCountFocusNode = FocusNode();
  FocusNode perksFocusNode = FocusNode();
  FocusNode maxCtcFocusNode = FocusNode();
  FocusNode minCtcFocusNode = FocusNode();
  FocusNode tDaysFocusNode = FocusNode();
  FocusNode sDaysFocusNode = FocusNode();
  FocusNode nDaysFocusNode = FocusNode();
  FocusNode qOneFocusNode = FocusNode();
  FocusNode qTwoFocusNode = FocusNode();

  RxString errorMsgJobTitle = ''.obs;
  RxString errorMsgLocation = ''.obs;
  RxString errorMsgDescription = ''.obs;
  RxString errorMsgOpeningCount = ''.obs;
  RxString errorMsgPerks = ''.obs;
  RxString errorMsgCtc = ''.obs;
  RxString errorMsgJobMode = ''.obs;
  RxString errorMsgGrowthPlanThi = ''.obs;
  RxString errorMsgGrowthPlanSix = ''.obs;
  RxString errorMsgGrowthPlan3Mon = ''.obs;

  void setRecruiterVideoThumbnail(String? profileUrl) {
    selectedProfileFileUrl.value = profileUrl ?? '';
  }

  void setJobTitle(String? jobTitle) {
    jobseekerNameController.text = jobTitle ?? '';
  }

  void setEmail(String? email) {
    jobModeController.value = jobseekerBioController.text = email ?? '';
  }

  void setPhone(String? phone) {
    jobModeController.value = jobseekerBioController.text = phone ?? '';
  }

  void setLocation(jobLocation.Location? location) {
    locationCityController.text = location?.city ?? '';
    locationCountryController.text = location?.country ?? '';
  }

  void setBio(String? perks) {
    jobModeController.value = jobseekerBioController.text = perks ?? '';
  }

  void setSocialGithub(String? growthPlan) {
    print(growthPlan);
    tDaysPlanController.text = growthPlan ?? '';
  }

  void setSocialLinkedIn(String? growthPlan) {
    sDaysPlanController.text = growthPlan ?? '';
  }

  void setSocialTwitter(String? growthPlan) {
    nDaysPlanController.text = growthPlan ?? '';
  }

  void setHeadline(String? headline) {
    minCtcController.text = headline ?? '';
  }

  void setJobMode(List<String>? jobMode) {
    if (jobMode == null || jobMode.isEmpty) {
      jobModeController.value = GlobalConstants.locationTypes[0];
    } else {
      jobModeController.value = capitalizeFirstLetter(
          jobMode?[0] ?? GlobalConstants.locationTypes[0]);
    }
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

  updateUserProfile(JobSeekerProfile jobPosting) async {
    isCreatingJobPost.value = true;
    RxBool isError = false.obs;

    if (jobseekerNameController.text.isEmpty) {
      errorMsgJobTitle.value = 'name is required';
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
      errorMsgPerks.value = 'job bio is required';
      isError.value = true;
    }
    if (jobModeController.value == GlobalConstants.locationTypes[0]) {
      errorMsgJobMode.value = 'Select Job mode';
    }
    // if (minCtcController.text.isEmpty) {
    //   errorMsgCtc.value = 'CTC range is required';
    //   isError.value = true;
    // }
    if (maxCtcController.text.isEmpty) {
      errorMsgCtc.value = 'CTC is required';
      isError.value = true;
    }
    if (openingCountController.text.isEmpty) {
      errorMsgOpeningCount.value = 'Opening count is required';
      isError.value = true;
    }
    if (tDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlanThi.value = '30 days growth plan is required';
      isError.value = true;
    }
    if (sDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlanSix.value = '60 days growth plan is required';
      isError.value = true;
    }
    if (nDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlan3Mon.value = '90 days growth plan is required';
      isError.value = true;
    }

    if (isError.value) {
      isCreatingJobPost.value = false;
      return;
    }

    String endpoint = EndpointService.updateUserProfile;

    Map<String, dynamic> body = {
      "name": jobPosting.name,
      "email": jobPosting.email ?? '',
      "phone": jobPosting.phone ?? '',
      "headline": jobseekerNameController.text.trim(),
      "bio": jobPosting.bio,
      "location": {
        "country": locationCountryController.text.trim(),
        "state": locationCityController.text.trim(),
        "city": locationCityController.text.trim(),
        "address": {"line1": "123 Market St", "line2": "Suite 400"},
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
      "skills": jobPosting.skills?.map((s) => s.toMap()).toList(),
    };

    LogHandler.debug(body);

    var url = '$endpoint/${jobPosting.id}';

    try {
      if (selectedProfileFile != null) {
        await apiClient
            .uploadVideoWithThumbnail(
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

            Map<String, dynamic> responsePut = await apiClient.put(url, body);

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
        Map<String, dynamic> response = await apiClient.put(url, body);
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
