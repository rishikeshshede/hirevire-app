import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/employer_interface/models/job_posting.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';

import '../../../../constants/endpoint_constants.dart';
import '../../../../constants/error_constants.dart';
import '../../../../constants/global_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/capitalize_first_letter.dart';
import '../../../../utils/log_handler.dart';
import '../../../models/MyApplication.dart';

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
        // jobSeekerProfile.value = JobSeekerProfile.fromMap(
        //     response['body']['data']); //get user profile model
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
}


