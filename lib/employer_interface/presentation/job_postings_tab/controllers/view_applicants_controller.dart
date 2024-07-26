import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import '../../../../constants/error_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/log_handler.dart';
import '../../../models/JobApplication.dart';

class ViewApplicantsController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;
  RxBool isClosedStatus = false.obs;

  RxList<JobApplication> jobPostings = <JobApplication>[].obs;
  var status = ''.obs; // Status text
  var statusColor = Colors.transparent.obs; // Status color

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchJobPostings();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
  }

  fetchJobPostings() async {
    isLoading.value = true;
    String endpoint = EndpointService.getJobApplications;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {
        jobPostings.value =
            JobApplication.fromJsonList(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        ToastWidgit.bottomToast(errorMsg);
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      ToastWidgit.bottomToast(
          'Unknown error occured while getting Job postings');
      LogHandler.error(error);
    } finally {
      isLoading.value = false;
    }
  }
}