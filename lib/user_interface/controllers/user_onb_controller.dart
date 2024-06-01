import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/professional_details/bio_section.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/personal_details.dart/name_dob_section.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/personal_details.dart/phone_number.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/professional_details/experience_section.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/professional_details/location_section.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/professional_details/skills_section.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/professional_details/social_urls_section.dart';
import 'package:hirevire_app/user_interface/routes/app_routes.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/validation_util.dart';
import 'package:image_picker/image_picker.dart';

class UserOnbController extends GetxController {
  RxBool isEmailValid = false.obs;
  RxBool isOtpLengthValid = false.obs;
  RxInt currentProgressIndex = 0.obs;
  RxBool isDobValid = false.obs;
  RxString errorMsg = ''.obs;
  RxBool isStep1Valid = false.obs;
  RxBool isNumberValid = false.obs;
  RxBool isHeadlineValid = false.obs;
  RxBool skillsAdded = false.obs;
  RxBool addingExp = false.obs;
  RxBool expAdded = false.obs;
  RxBool isSigningUp = false.obs;
  RxString searchQuery = ''.obs;
  RxList<String> selectedSkills = <String>[].obs;
  RxList<String> filteredSuggestions = <String>[].obs;
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
  TextEditingController emailController = TextEditingController();
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  TextEditingController nameController = TextEditingController();
  final List<TextEditingController> dobControllers =
      List.generate(3, (_) => TextEditingController());
  TextEditingController numberController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController expTitleController = TextEditingController();
  TextEditingController expDescriptionController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyLocationController = TextEditingController();
  TextEditingController socialUrlController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Text Focus nodes

  FocusNode emailFocusNode = FocusNode();
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());
  FocusNode nameFocusNode = FocusNode();
  final List<FocusNode> dobFocusNodes = List.generate(3, (_) => FocusNode());
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

  @override
  void onInit() {
    super.onInit();
    // Bind the filteredSuggestions to changes in searchQuery
    debounce(searchQuery, (_) => updateSkillsSuggestions(),
        time: const Duration(milliseconds: 300));
  }

  // ----------------- Methods -----------------

  List<Widget> sectionWidgets() {
    return [
      const NameDobSection(),
      const NumberSection(),
      const BioSection(),
      const SkillsSection(),
      const ExperienceSection(),
      const SocialUrlsSection(),
      const LocationSection(),
    ];
  }

  bool validateEmail({String? email}) {
    String emailToValidate = email ?? emailController.text.trim();
    bool isValid = ValidationUtil.validateEmail(emailToValidate);

    isEmailValid.value = isValid;

    return isValid;
  }

  Future<void> sendOtp() async {
    // SEND OTP
  }

  void validateOtpLength() {
    String otp =
        otpControllers.map((controller) => controller.text.trim()).join();
    isOtpLengthValid.value = otp.length == 6;
  }

  Future<void> verifyOTP() async {
    // SHOW LOADER
    navigateToIntroScreen();
  }

  validateName() {
    bool isNameValid = nameController.value.text.trim().isNotEmpty;
    if (!isNameValid) {
      isStep1Valid.value = false;
    }
    return isNameValid;
  }

  bool validateDobValues(int index, String value) {
    int intValue = value.isNotEmpty ? int.parse(value) : 0;
    bool isValueValid = false;
    switch (index) {
      case 0:
        if (value.length == 2) {
          isValueValid = intValue > 0 && intValue <= 31;
          errorMsg.value = isValueValid ? "" : "*Invalid date";
        }
        break;
      case 1:
        if (value.length == 2) {
          isValueValid = intValue > 0 && intValue <= 12;
          errorMsg.value = isValueValid ? "" : "*Invalid month";
        }
        break;
      case 2:
        if (value.length == 4) {
          isValueValid =
              intValue > 1930 && intValue <= 2015; // hardcoded for now
          errorMsg.value = isValueValid ? "" : "*Invalid year";
        }
        break;
    }
    isDataProvided();
    return isValueValid;
  }

  bool isDobCorrect() {
    String dob = '';
    List<String> errorMessages = [
      'Invalid date',
      'Invalid month',
      'Invalid year'
    ];
    List<int> maxValues = [31, 12, 2015];
    List<int> minValues = [1, 1, 1930];

    for (int i = 0; i < dobControllers.length; i++) {
      String value = dobControllers[i].text.trim();
      if (value.isEmpty) {
        isDobValid.value = false;
        errorMsg.value = errorMessages[i];
        return false;
      }

      int intValue = int.parse(value);
      if (intValue < minValues[i] || intValue > maxValues[i]) {
        isDobValid.value = false;
        errorMsg.value = errorMessages[i];
        return false;
      }

      // Pad day and month with '0' if necessary
      if (i < 2) {
        value = value.padLeft(2, '0');
      }
      dob += value;
    }

    if (dob.length == 8) {
      isDobValid.value = true;
      errorMsg.value = '';
      return true;
    } else {
      isDobValid.value = false;
      errorMsg.value = '*Invalid date of birth';
      return false;
    }
  }

  isDataProvided() {
    String dob = dobControllers.map((controller) {
      String text = controller.text.trim();
      if (text.length == 1) {
        text = text.padLeft(2, '0');
      }
      return text;
    }).join();

    isStep1Valid.value = dob.length == 8 && validateName();
  }

  validateStep1() {
    isStep1Valid.value = validateName() && isDobCorrect();
  }

  DateTime? getDob() {
    try {
      String day = dobControllers[0].text.trim().padLeft(2, '0');
      String month = dobControllers[1].text.trim().padLeft(2, '0');
      String year = dobControllers[2].text.trim();

      DateTime dob = DatetimeUtil.getDateTimeFromString(day, month, year);
      return dob;
    } catch (e) {
      return null;
    }
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
      errorMsg.value = "";
      isNumberValid.value = true;
      numberFocusNode.unfocus();
      moveToNextStep();
    } else {
      isNumberValid.value = false;
      errorMsg.value = "*Invalid number";
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

  void updateSkillsSuggestions() {
    if (searchQuery.isEmpty) {
      filteredSuggestions.value = [];
    } else {
      filteredSuggestions.value = GlobalConstants.suggestions
          .where((skill) =>
              skill.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void addSkill(String skill) {
    if (!selectedSkills.contains(skill)) {
      selectedSkills.add(skill);
    }
  }

  void removeSkill(String skill) {
    selectedSkills.remove(skill);
  }

  searchExpTitle() {}

  searchCompany() {}

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
        'title': expTitleController.value.text.trim(),
        'company': companyNameController.value.text.trim(),
        'location': companyLocationController.value.text.trim(),
        'description': expDescriptionController.value.text.trim(),
        'employmentType': employmentType.value == "Please select"
            ? null
            : employmentType.value,
        'locationType':
            locationType.value == "Please select" ? null : locationType.value,
        'startDate': "$startMonth $startYear",
        'endDate': stillWorking.value ? "Present" : "$endMonth $endYear",
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

  signup() async {
    isSigningUp.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      isSigningUp.value = false;
      navigateToBaseNav();
    });
  }

  // ----------------- Navigations -----------------

  navigateToOtpScreen() {
    Get.toNamed(AppRoutes.otpScreen);
  }

  navigateToIntroScreen() {
    Get.toNamed(AppRoutes.introScreen);
  }

  navigateToBaseNav() {
    Get.toNamed(AppRoutes.userBaseNavigator);
  }
}
