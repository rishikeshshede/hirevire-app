import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/endpoint_constants.dart';
import 'package:hirevire_app/constants/error_constants.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/employer_interface/models/emp_model.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/log_handler.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import 'package:hirevire_app/utils/validation_util.dart';

class EmpOnbController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxBool isEmailValid = false.obs;
  RxString errorMsg = ''.obs;
  Rx<EmployerModel> employer = EmployerModel().obs;

  // Text Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Text Focus nodes
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

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

  signin() async {
    isLoading.value = true;
    String endpoint = Endpoints.recruiterSignin;
    String email = emailController.value.text.trim();

    Map<String, dynamic> body = {
      "email": email,
      "password": passwordController.value.text.trim(),
    };
    LogHandler.debug(body);

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);
      LogHandler.debug(response);

      if (response['success']) {
        String token = response['body']['token'];
        PersistenceHandler.setString(PersistenceKeys.authToken, token);

        employer.value =
            EmployerModel().fromJson(json.encode(response['body']['data']));

        navigateToBaseNav();
        showBottomToast("Welcome!");
        // showBottomToast("Welcome ${nameSplit[0]}!");
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

  navigateToBaseNav() {
    PersistenceHandler.setBool(PersistenceKeys.isNew, false);
    PersistenceHandler.setBool(PersistenceKeys.isEmployer, true);
    PersistenceHandler.setBool(PersistenceKeys.isSignedIn, true);
    // Get.toNamed(AppRoutes.empBaseNavigator);
    Get.toNamed(AppRoutes.userBaseNavigator);
  }
}
