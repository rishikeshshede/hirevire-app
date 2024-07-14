import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/endpoint_constants.dart';
import 'package:hirevire_app/constants/error_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/user_interface/presentation/profile/professional_details/bio_section.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/name_dob_section.dart';
import 'package:hirevire_app/user_interface/presentation/profile/personal_details.dart/phone_number.dart';
import 'package:hirevire_app/user_interface/presentation/profile/professional_details/experience_section.dart';
import 'package:hirevire_app/user_interface/presentation/profile/professional_details/location_section.dart';
import 'package:hirevire_app/user_interface/presentation/profile/professional_details/skills_section.dart';
import 'package:hirevire_app/user_interface/presentation/profile/professional_details/social_urls_section.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/log_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/persistence_keys.dart';
import '../../utils/persistence_handler.dart';

class CompleteProfileController extends GetxController {
  late ApiClient apiClient;

  RxString name = ''.obs;
  RxString email = ''.obs;

  String country = "IN";
  String countryCode = "+91";
  String defaultItemId = "Other";

  RxBool isLoading = false.obs;
  RxInt currentProgressIndex = 0.obs;
  RxString errorMsg = ''.obs;
  RxBool isNumberValid = false.obs;
  RxBool isHeadlineValid = false.obs;
  RxBool skillsAdded = false.obs;
  RxBool addingExp = false.obs;
  RxBool expAdded = false.obs;
  RxBool isSigningUp = false.obs;
  RxString skillsSearchQuery = ''.obs;
  RxString titleSearchQuery = ''.obs;
  RxString companySearchQuery = ''.obs;
  RxMap<String, dynamic> headlineObj = <String, dynamic>{}.obs;
  RxMap<String, dynamic> companyJobTitleObj = <String, dynamic>{}.obs;
  RxMap<String, dynamic> companyObj = <String, dynamic>{}.obs;
  RxList<Map<String, dynamic>> selectedSkills = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredSkillsSuggestions =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredTitleSuggestions =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredCompanySuggestions =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> addedExp = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> socialProfiles = <Map<String, dynamic>>[].obs;
  RxString employmentType = GlobalConstants.employmentTypes[0].obs;
  RxString socialProfileType =
      GlobalConstants.socialProfileTypesMap.keys.first.obs;
  RxString preferredJobMode = GlobalConstants.locationTypes[0].obs;
  RxBool isAddingUrl = false.obs;
  RxString locationType = GlobalConstants.locationTypes[0].obs;
  RxBool stillWorking = true.obs;
  RxString startMonth = GlobalConstants.monthsMap.keys.first.obs;
  RxString startYear = GlobalConstants.years[0].obs;
  RxString endMonth = GlobalConstants.monthsMap.keys.first.obs;
  RxString endYear = GlobalConstants.years[0].obs;

  final imagePicker = ImagePicker();
  Rx<File?> profilePic = Rx<File?>(null);

  // Text Controllers

  final PageController pageController = PageController(initialPage: 0);
  TextEditingController numberController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController skillsSearchController = TextEditingController();
  TextEditingController expTitleController = TextEditingController();
  TextEditingController expDescriptionController = TextEditingController();
  TextEditingController companyIdController =
      TextEditingController(text: 'Other');
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyLocationController = TextEditingController();
  TextEditingController socialUrlController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Text Focus nodes

  FocusNode numberFocusNode = FocusNode();
  FocusNode headlineFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  final FocusNode searchFocusNode = FocusNode();
  final FocusNode expTitleFocusNode = FocusNode();
  final FocusNode expDescriptionFocusNode = FocusNode();
  final FocusNode companyNameFocusNode = FocusNode();
  final FocusNode companyLocationFocusNode = FocusNode();
  final FocusNode socialUrlFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();

  var skillsRatings = <String, double>{}.obs; // Map to store ratings for skills

  @override
  void onInit() async {
    super.onInit();
    apiClient = ApiClient();
    // Bind the filteredSuggestions to changes in searchQuery
    debounce(skillsSearchQuery, (_) => suggestSkills(),
        time: const Duration(milliseconds: 300));
    debounce(titleSearchQuery, (_) => suggestTitles(),
        time: const Duration(milliseconds: 300));
    debounce(companySearchQuery, (_) => suggestCompany(),
        time: const Duration(milliseconds: 300));

    await fetchLocalData();
  }

  // ----------------- Methods -----------------

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name);
    email.value = await PersistenceHandler.getString(PersistenceKeys.email);
  }

  showBottomToast(String message) {
    ToastWidgit.bottomToast(message);
  }

  List<Widget> sectionWidgets() {
    return [
      //const NameDobSection(),
      const NumberSection(),
      const BioSection(),
      const SkillsSection(),
      const ExperienceSection(),
      const SocialUrlsSection(),
      const LocationSection(),
    ];
  }

  Future<void> suggestTitles() async {
    if (titleSearchQuery.isEmpty) {
      filteredTitleSuggestions.value = [];
    } else {
      String endpoint = Endpoints.searchJobTitles;
      String searchQuery = "$endpoint/${titleSearchQuery.value}";

      try {
        Map<String, dynamic> response = await apiClient.get(searchQuery);
        if (response['success']) {
          List<Map<String, dynamic>> convertedList =
              List<Map<String, dynamic>>.from(response['body']['data']);
          filteredTitleSuggestions.value = convertedList;
        } else {
          String errorMsg =
              response['error']['message'] ?? Errors.somethingWentWrong;
          showBottomToast(errorMsg);
          LogHandler.error(errorMsg);
        }
      } catch (error) {
        showBottomToast(error.toString());
        LogHandler.error(error);
      }
    }
  }

  void setTitle(Map<String, dynamic> selectedTitle) {
    headlineController.text = selectedTitle['name'];
    titleSearchQuery.value = '';
    headlineObj.value = {
      'data': selectedTitle['_id'],
      'name': selectedTitle['name'],
    };
  }

  void moveToNextStep() {
    if (currentProgressIndex < sectionWidgets().length - 1) {
      errorMsg.value = '';
      currentProgressIndex += 1;
      pageController.animateToPage(
        currentProgressIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (currentProgressIndex.value == sectionWidgets().length - 1) {
      // signup
    }
  }

  validateNumber() {
    if (numberController.value.text.trim().length == 10) {
      // errorMsg.value = "";
      isNumberValid.value = true;
      numberFocusNode.unfocus();
      moveToNextStep();
    } else {
      isNumberValid.value = false;
      // errorMsg.value = "*Invalid number";
    }
  }

  validateHeadline() {
    if (headlineController.value.text.isNotEmpty) {
      isHeadlineValid.value = true;
      errorMsg.value = "";
      headlineFocusNode.unfocus();
      bioFocusNode.unfocus();
      moveToNextStep();
    } else {
      isHeadlineValid.value = false;
      errorMsg.value = "*No headline provided";
    }
  }

  validateSkillsSection() {
    if (selectedSkills.isNotEmpty) {
      skillsAdded.value = true;
      errorMsg.value = "";
      moveToNextStep();
    } else {
      skillsAdded.value = false;
      errorMsg.value = "No skills added";
    }
  }

  Future<void> suggestSkills() async {
    if (skillsSearchQuery.isEmpty) {
      filteredSkillsSuggestions.value = [];
    } else {
      String endpoint = Endpoints.searchSkills;
      String searchQuery = "$endpoint/${skillsSearchQuery.value}";

      try {
        Map<String, dynamic> response = await apiClient.get(searchQuery);

        if (response['success']) {
          List<Map<String, dynamic>> convertedList =
              List<Map<String, dynamic>>.from(response['body']['data']);
          filteredSkillsSuggestions.value = convertedList;
        } else {
          String errorMsg =
              response['error']['message'] ?? Errors.somethingWentWrong;
          showBottomToast(errorMsg);
          LogHandler.error(errorMsg);
        }
      } catch (error) {
        showBottomToast(error.toString());
        LogHandler.error(error);
      }
    }
  }

  // void addSkill(Map<String, dynamic> selectedSkill) {
  //   Map<String, dynamic> skillMap = {
  //     'data': selectedSkill['_id'],
  //     'name': selectedSkill['name'],
  //   };
  //
  //   bool skillExists = false;
  //
  //   if (selectedSkills.isEmpty) {
  //     selectedSkills.add(skillMap);
  //   } else {
  //     for (var i = 0; i < selectedSkills.length; i++) {
  //       var skill = selectedSkills[i];
  //       if (skill['name'].toString().toLowerCase() ==
  //           selectedSkill['name'].toString().toLowerCase()) {
  //         skillExists = true;
  //         return;
  //       }
  //     }
  //     if (!skillExists) {
  //       selectedSkills.add(skillMap);
  //     }
  //   }
  //   skillsSearchController.clear();
  // }

  void addSkill(Map<String, dynamic> selectedSkill) {
    Map<String, dynamic> skillMap = {
      '_id': selectedSkill['_id'],
      'name': selectedSkill['name'],
    };

    bool skillExists = false;

    if (selectedSkills.isEmpty) {
      selectedSkills.add(skillMap);
      skillsRatings[selectedSkill['_id']] = 5.0; // Default rating
    } else {
      for (var skill in selectedSkills) {
        if (skill['name'].toString().toLowerCase() ==
            selectedSkill['name'].toString().toLowerCase()) {
          skillExists = true;
          return;
        }
      }
      if (!skillExists) {
        selectedSkills.add(skillMap);
        skillsRatings[selectedSkill['_id']] = 5.0; // Default rating
      }
    }
    skillsSearchController.clear();
  }

  void updateSkillRating(String skillId, double rating) {
    skillsRatings[skillId] = rating;
  }

  void removeSkill(Map<String, dynamic> skill) {
    selectedSkills.remove(skill);
    skillsRatings.remove(skill['data']);
  }

  // void removeSkill(Map<String, dynamic> titleObj) {
  //   selectedSkills.removeWhere((skill) => skill['name'] == titleObj['name']);
  // }

  Future<void> suggestCompany() async {
    if (companySearchQuery.isEmpty) {
      filteredCompanySuggestions.value = [];
    } else {
      String endpoint = Endpoints.searchCompanies;
      String searchQuery = "$endpoint/${companySearchQuery.value}";

      try {
        Map<String, dynamic> response = await apiClient.get(searchQuery);

        if (response['success']) {
          List<Map<String, dynamic>> convertedList =
              List<Map<String, dynamic>>.from(response['body']['data']);
          filteredCompanySuggestions.value = convertedList;
        } else {
          String errorMsg =
              response['error']['message'] ?? Errors.somethingWentWrong;
          showBottomToast(errorMsg);
          LogHandler.error(errorMsg);
        }
      } catch (error) {
        showBottomToast(error.toString());
        LogHandler.error(error);
      }
    }
  }

  setCompanyJobTitle(Map<String, dynamic> selectedCompanyJobTitle) {
    expTitleController.text = selectedCompanyJobTitle['name'];
    titleSearchQuery.value = '';
    companyJobTitleObj.value = {
      'data': selectedCompanyJobTitle['_id'],
      'name': selectedCompanyJobTitle['name'],
    };
  }

  setCompanyName(Map<String, dynamic> selectedCompany) {
    companyNameController.text = selectedCompany['name'];
    companySearchQuery.value = '';
    companyObj.value = {
      'data': selectedCompany['_id'],
      'name': selectedCompany['name'],
    };
  }

  searchCompanyLocation() {}

  toggleStillWorkingValue() {
    stillWorking.value = !stillWorking.value;
  }

  saveExp() {
    bool isEndDateAdded;

    if (stillWorking.value) {
      isEndDateAdded = true;
    } else if (endMonth.value != 'Month' && endYear.value != 'Year') {
      isEndDateAdded = true;
    } else {
      isEndDateAdded = false;
    }

    if (expTitleController.value.text.isNotEmpty &&
        companyNameController.value.text.isNotEmpty &&
        startMonth.value != 'Month' &&
        startYear.value != 'Year' &&
        isEndDateAdded) {
      errorMsg.value = "";
      Map<String, dynamic> exp = {
        'title': companyJobTitleObj,
        'company': companyObj,
        "location": {
          "country": companyLocationController.value.text.trim(),
          "state": "",
          "city": "",
          "address": {"line1": "", "line2": ""}
        },
        'description': expDescriptionController.value.text.trim(),
        'employmentType': employmentType.value == "Please select"
            ? null
            : employmentType.value,
        'jobMode':
            locationType.value == "Please select" ? null : locationType.value,
        'startDate': DatetimeUtil.getDateTimeFromString(
          "01",
          GlobalConstants.monthsMap[startMonth.value]
              .toString()
              .padLeft(2, '0'),
          startYear.value,
        ).toIso8601String(),
        "stillWorking": stillWorking.value,
        'endDate': stillWorking.value
            ? null
            : DatetimeUtil.getDateTimeFromString(
                "28",
                GlobalConstants.monthsMap[endMonth.value]
                    .toString()
                    .padLeft(2, '0'),
                endYear.value,
              ).toIso8601String(),
        "skills": [],
        "media": [
          {
            "title": "Resume",
            "url": "https://example.com/project-a",
            "type": "image",
            "thumbnail": "https://example.com/project-a-thumbnail"
          }
        ],
      };
      addedExp.add(exp);
      clearExpControllers();
    } else {
      errorMsg.value = "*Add required fields";
    }
  }

  validateAddedExp() {
    if (addedExp.isNotEmpty) {
      expAdded.value = true;
      errorMsg.value = "";
      clearExpControllers();
      moveToNextStep();
    } else {
      expAdded.value = false;
      errorMsg.value = "*No experience added";
    }
  }

  void clearExpControllers() {
    addingExp.value = false;
    stillWorking.value = true;
    expTitleController.clear();
    companyNameController.clear();
    companyLocationController.clear();
    expDescriptionController.clear();
    employmentType.value = GlobalConstants.employmentTypes[0];
    locationType.value = GlobalConstants.locationTypes[0];
    startMonth.value = GlobalConstants.monthsMap.keys.first;
    startYear.value = GlobalConstants.years[0];
    endMonth.value = GlobalConstants.monthsMap.keys.first;
    endYear.value = GlobalConstants.years[0];
  }

  checkUrlStatus() {
    isAddingUrl.value = socialUrlController.value.text.trim().isNotEmpty &&
        socialProfileType.value.trim() != 'Select';
  }

  clearSocialControllers() {
    socialUrlController.clear();
    socialProfiles.clear();
    socialProfileType.value = GlobalConstants.socialProfileTypesMap.keys.first;
  }

  addSocialUrl() {
    checkUrlStatus();
    if (isAddingUrl.value) {
      socialProfiles.add({
        "platform": socialProfileType.value,
        "url": socialUrlController.value.text.trim()
      });
      socialUrlController.clear();
      errorMsg.value = '';
      checkUrlStatus();
    } else {
      if (socialUrlController.value.text.trim().isEmpty) {
        errorMsg.value = '*URL missing';
      } else if (socialProfileType.value.trim() == 'Select') {
        errorMsg.value = '*Select platform type';
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      profilePic.value = File(pickedFile.path);
    }
  }

  Future<void> uploadProfilePic() async {
    String endpoint = Endpoints.uploadProfilePicture;

    try {
      Map<String, dynamic> response =
          await apiClient.uploadImageOrVideo(endpoint, profilePic.value!);
      LogHandler.debug(response);

      if (response['success']) {
        // String url = response['body']['data'];
        // TODO: save URL in user model
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        showBottomToast(errorMsg);
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      showBottomToast(error.toString());
      LogHandler.error(errorMsg);
    }
  }

  List<Map<String, dynamic>> getSkillsData() {
    return selectedSkills.map((skill) {
      // Get the name of the skill
      String skillName = skill['name'];

      // Get the rating for the skill from the skillsRatings map
      double skillRating = skillsRatings[skillName] ?? 0.0;

      // Return the formatted skill data
      return {
        "data": skill['data'],
        "name": skillName,
        "rating": skillRating,
      };
    }).toList();
  }

  List<String> preferredJobModesList() {
    return [preferredJobMode.value];
  }

  updateProfile() async {
    isSigningUp.value = true;

    String endpoint = Endpoints.updateProfile;
    String? number;

    if (numberController.value.text.trim().length == 10) {
      number = "$countryCode ${numberController.value.text.trim()}";
    }

    Map<String, dynamic> body = {
      "name": name.value,
      "email": email.value,
      "phone": numberController.value.text.trim(),
      "headline": headlineController.value.text.trim(),
      "bio": bioController.value.text.trim(),
      "socialUrls": {
        "GitHub": socialUrlController.value.text.trim(),
        "LinkedIn": socialUrlController.value.text.trim(),
        "Twitter": socialUrlController.value.text.trim()
      },
      "skills": getSkillsData(),
      "location": {
        "country": locationController.value.text.trim(),
        "state": locationController.value.text.trim(),
        "city": locationController.value.text.trim(),
        "address": {
          "line1": companyLocationController.value.text.trim(),
          "line2": ''
        }
      },
      "preferredJobModes": preferredJobModesList(),
    };

    try {
      Map<String, dynamic> response = await apiClient.put(endpoint, body);

      if (response['success']) {
        // TODO: save user data to user model
        debugPrint(response.toString());

        if (profilePic.value != null) {
          await uploadProfilePic();
        }

        navigateToBaseNav();
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        showBottomToast(errorMsg);
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      showBottomToast(Errors.somethingWentWrong);
      LogHandler.error(error);
    } finally {
      isSigningUp.value = false;
    }
  }

  Future<void> saveProfileCompleteData(Map<String, dynamic> responseLogin) async {
    PersistenceHandler.setBool(PersistenceKeys.isProfileComplete, true);
  }

  // ----------------- Navigations -----------------

  navigateToOtpScreen() {
    Get.toNamed(AppRoutes.otpScreen);
  }

  navigateToIntroScreen() {
    Get.toNamed(AppRoutes.completeProfile);
  }

  navigateToBaseNav() {
    Get.toNamed(AppRoutes.userBaseNavigator);
  }
}
