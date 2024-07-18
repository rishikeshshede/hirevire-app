import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/endpoint_constants.dart';
import 'package:hirevire_app/constants/error_constants.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/log_handler.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import 'package:hirevire_app/utils/validation_util.dart';

import '../../utils/profile_complete_validator.dart';

class UserOnbController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxBool isEmailValid = false.obs;
  RxBool isOtpLengthValid = false.obs;
  RxBool isDobValid = false.obs;
  RxBool basicDetailsValid = false.obs;
  RxString errorMsg = ''.obs;
  RxBool isSigningUp = false.obs;

  // Text Controllers
  TextEditingController emailController = TextEditingController();
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  TextEditingController nameController = TextEditingController();
  final List<TextEditingController> dobControllers =
      List.generate(3, (_) => TextEditingController());

  // Text Focus nodes
  FocusNode emailFocusNode = FocusNode();
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());
  FocusNode nameFocusNode = FocusNode();
  final List<FocusNode> dobFocusNodes = List.generate(3, (_) => FocusNode());

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
  }

  // ----------------- Methods -----------------

  showBottomToast(String message) {
    ToastWidgit.bottomToast(message);
  }

  void validateEmail({String? email}) {
    String emailToValidate = email ?? emailController.text.trim();
    isEmailValid.value = ValidationUtil.validateEmail(emailToValidate);
  }

  Future<void> sendOtp({bool navigate = true}) async {
    emailFocusNode.unfocus();
    isLoading.value = true;
    String endpoint = Endpoints.sendOtp;
    Map<String, dynamic> body = {"email": emailController.text.trim()};

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);

      if (response['success']) {
        if (navigate) {
          navigateToOtpScreen();
        } else {
          showBottomToast("OTP sent successfully");
        }
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
      isLoading.value = false;
    }
  }

  void validateOtpLength() {
    String otp =
        otpControllers.map((controller) => controller.text.trim()).join();
    isOtpLengthValid.value = otp.length == 6;
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    String endpoint = Endpoints.verifyOTP;

    String otp =
        otpControllers.map((controller) => controller.text.trim()).join();
    Map<String, dynamic> body = {
      "email": emailController.text.trim(),
      "otp": otp,
    };

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);

      if (response['success']) {
        PersistenceHandler.setBool(PersistenceKeys.isNew, false);

        String token = response['body']['token'];
        String name = response['body']['data']['name'];

        PersistenceHandler.setString(PersistenceKeys.authToken, token);
        PersistenceHandler.setString(PersistenceKeys.name, name);
        PersistenceHandler.setBool(PersistenceKeys.isSignedIn, true);

        if (ProfileCompleteValidator().validate(response['body']['data'])) {
          PersistenceHandler.setBool(PersistenceKeys.isProfileComplete, true);
        }

        bool accountExist = response['body']['accountExist'];
        if (accountExist) {
          navigateToBaseNav();
        } else {
          navigateToNameScreen();
        }
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
      isLoading.value = false;
    }
  }

  validateName() {
    bool isNameValid = nameController.value.text.trim().isNotEmpty;
    if (!isNameValid) {
      basicDetailsValid.value = false;
    }
    return isNameValid;
  }

  bool validateDobValues(int index, String value) {
    int intValue = value.isNotEmpty ? int.parse(value) : 0;
    bool isValueValid = false;
    bool shiftFocus = false;
    switch (index) {
      case 0:
        if (value.length <= 2) {
          isValueValid = intValue > 0 && intValue <= 31;
          shiftFocus = isValueValid && value.length == 2;
          errorMsg.value = isValueValid ? "" : "*Invalid date";
        }
        break;
      case 1:
        if (intValue == 2) {
          int date = int.parse(dobControllers[0].text);
          isValueValid = date > 0 && date <= 29;
          errorMsg.value = isValueValid ? "" : "*Invalid date";
        } else if (value.length <= 2) {
          isValueValid = intValue > 0 && intValue <= 12;
          errorMsg.value = isValueValid ? "" : "*Invalid month";
        }
        break;
      case 2:
        if (value.length == 4) {
          bool isLeap = isLeapYear(intValue);
          int validMinMaxYear = DateTime.now().year - 18;
          int date = int.parse(dobControllers[0].text);
          int month = int.parse(dobControllers[1].text);

          if (intValue > validMinMaxYear) {
            errorMsg.value = "*You must be over 18";
          } else if (month == 2 && !isLeap) {
            isValueValid = date > 0 && date <= 28;
            errorMsg.value = isValueValid ? "" : "*Invalid date";
          } else {
            isValueValid =
                intValue > 1930 && intValue <= validMinMaxYear; // min age: 18
            errorMsg.value = isValueValid ? "" : "*Invalid year";
          }
        }
        break;
    }
    isDataProvided();
    return shiftFocus;
  }

  bool isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true; // Divisible by 400
        } else {
          return false; // Divisible by 100 but not by 400
        }
      } else {
        return true; // Divisible by 4 but not by 100
      }
    } else {
      return false; // Not divisible by 4
    }
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

    basicDetailsValid.value = dob.length == 8 && validateName();
  }

  validateNameDob() {
    basicDetailsValid.value = validateName() && isDobCorrect();
  }

  DateTime getDob() {
    try {
      String day = dobControllers[0].text.trim().padLeft(2, '0');
      String month = dobControllers[1].text.trim().padLeft(2, '0');
      String year = dobControllers[2].text.trim();

      DateTime dob = DatetimeUtil.getDateTimeFromString(day, month, year);
      return dob;
    } catch (e) {
      return DateTime.now();
    }
  }

  signup() async {
    isSigningUp.value = true;

    String endpoint = Endpoints.signup;
    String dob = getDob().toIso8601String();
    String email = emailController.value.text.trim().isEmpty
        ? await PersistenceHandler.getString(PersistenceKeys.email)
        : emailController.value.text.trim();

    Map<String, dynamic> body = {
      "name": nameController.value.text.trim(),
      "email": email,
      "phone": '',
      "birthDate": dob,
    };
    LogHandler.debug(body);

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);
      LogHandler.debug(response);

      if (response['success']) {
        String token = response['body']['token'];
        String name = response['body']['data']['name'];

        PersistenceHandler.setString(PersistenceKeys.authToken, token);
        PersistenceHandler.setString(PersistenceKeys.name, name);
        PersistenceHandler.setBool(PersistenceKeys.isSignedIn, true);
        PersistenceHandler.setBool(PersistenceKeys.isUserRegistered, true);

        List<String> nameSplit = name.split(' ');
        navigateToBaseNav();
        showBottomToast("Welcome ${nameSplit[0]}!");
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

  // ----------------- Navigations -----------------

  navigateToOtpScreen() {
    Get.toNamed(AppRoutes.otpScreen);
  }

  navigateToNameScreen() {
    PersistenceHandler.setBool(PersistenceKeys.isEmployer, false);
    PersistenceHandler.setBool(PersistenceKeys.isEmailVerified, true);
    PersistenceHandler.setString(
        PersistenceKeys.email, emailController.text.trim());
    Get.toNamed(AppRoutes.nameScreen);
  }

  navigateToBaseNav() {
    PersistenceHandler.setBool(PersistenceKeys.isSignedIn, true);
    Get.toNamed(AppRoutes.userBaseNavigator);
  }
}
