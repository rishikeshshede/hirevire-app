import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import '../../../../constants/error_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/log_handler.dart';
import '../../../models/job_application_model.dart';

class ViewApplicantsController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;
  RxBool isClosedStatus = false.obs;

  String applicationJobId;

  RxList<JobApplication> jobApplicant = <JobApplication>[].obs;
  var status = ''.obs; // Status text
  var statusColor = Colors.transparent.obs; // Status color

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  ViewApplicantsController(this.applicationJobId);

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchJobApplications();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
  }

  void shortListApplicant(JobApplication job) async {
    jobApplicant.remove(job);
    status.value = 'Shortlisted';
    statusColor.value = Colors.red;

    //isLoading.value = true;
    String endpoint = EndpointService.rightSwipeApplicant;

    Map<String, dynamic> body = {
      'feedback': '',
      'applicationId': job.id,
    };

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);
      LogHandler.debug(response);

      if (response['success']) {
        LogHandler.debug(response['body']['message']);
        ToastWidgit.bottomToast("Shortlisted");
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      // ToastWidgit.bottomToast(
      //     'Unknown error occurred');
      LogHandler.error(error);
    } finally {
      //isLoading.value = false;
    }
  }

  void rejectApplicant(JobApplication job) async {
    jobApplicant.remove(job);
    status.value = 'Rejected';
    statusColor.value = Colors.red;

    //isLoading.value = true;
    String endpoint = EndpointService.leftSwipeApplicant;

    Map<String, dynamic> body = {
      'feedback': '',
      'applicationId': job.id,
    };

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);
      LogHandler.debug(response);

      if (response['success']) {
        LogHandler.debug(response['body']['message']);
        ToastWidgit.bottomToast("Rejected");
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      // ToastWidgit.bottomToast(
      //     'Unknown error occurred');
      LogHandler.error(error);
    } finally {
      //isLoading.value = false;
    }
  }

  List<List<RadarEntry>> prepareRadarData(
      JobPostId? jobPost, JobApplication applicant) {
    final Map<String, int> jobPostSkills = jobPost?.requiredSkills != null
        ? {
            for (var skill in jobPost!.requiredSkills!)
              skill.skill?.name ?? '': skill.rating ?? 0
          }
        : {};

    final Map<String, int> applicantSkills = applicant.requiredSkills != null
        ? {
            for (var skill in applicant.requiredSkills!)
              skill.skill?.name ?? '': skill.rating ?? 0
          }
        : {};

    final allSkills = <String>{}
      ..addAll(jobPostSkills.keys)
      ..addAll(applicantSkills.keys);

    final jobPostEntries = allSkills.map((skill) {
      return RadarEntry(value: jobPostSkills[skill]?.toDouble() ?? 0.0);
    }).toList();

    final applicantEntries = allSkills.map((skill) {
      return RadarEntry(value: applicantSkills[skill]?.toDouble() ?? 0.0);
    }).toList();

    return [jobPostEntries, applicantEntries];
  }

  fetchJobApplications() async {
    isLoading.value = true;
    String endpoint = '${EndpointService.getJobApplications}/$applicationJobId';

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {
        jobApplicant.value =
            JobApplication.fromJsonList(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        // ToastWidgit.bottomToast(errorMsg);
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
