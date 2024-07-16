import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hirevire_app/constants/endpoint_constants.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';

import '../../../../constants/error_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/log_handler.dart';

class RequisitionsController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;

  RxList<Requisition> requisitions = <Requisition>[].obs;
  var status = ''.obs; // Status text
  var statusColor = Colors.transparent.obs; // Status color

  File? selectedVideoFile;
  File? selectedThumbnailFile = File('');

  void onFilesSelected(File? videoFile, File? thumbnailFile) {
    selectedVideoFile = videoFile;
    selectedThumbnailFile = thumbnailFile;
  }

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController jobModeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController vidReqController = TextEditingController();
  TextEditingController reqSkillsController = TextEditingController();
  TextEditingController perksController = TextEditingController();
  TextEditingController openingCountController = TextEditingController();
  TextEditingController ctcController = TextEditingController();

  void setJobTitle(String? jobTitle) {
    jobTitleController.text = jobTitle ?? '';
  }

  void setJobMode(List<String>? job) {
    jobModeController.text = job?.join(', ') ?? '';
  }
  void setOpeningCount(int openingCount) {
    openingCountController.text = openingCount.toString();
  }
  void setDescription(String? desc) {
    descController.text = desc ?? '';
  }
  void setReqSkills(List<RequiredSkill>? skills) {
    final skillsList = skills ?? [];
    final skillsString = skillsList.map((skill) => skill.skill?.name).where((name) => name != null).join(', ');

    reqSkillsController.text = skillsString ?? '';
  }

  FocusNode jobTitleFocusNode = FocusNode();

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchRequisitions();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name ?? '');
  }

  fetchRequisitions() async {
    String endpoint = EndpointService.getRequisitions;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {

        requisitions.value = Requisition.fromJsonList(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      LogHandler.error(error);
    }

  }

  String getPostTime(DateTime date) {
    return DatetimeUtil.timeAgo(date);
  }

  Future<Map<String, dynamic>?> uploadFiles() async {
    if (selectedVideoFile == null) {
      ToastWidgit.bottomToast('please upload video, it is required');
    }

    try {
      await apiClient.uploadVideoWithThumbnail(
        Endpoints.uploadVideoWithThumbnail,
        selectedVideoFile!,
        selectedThumbnailFile!,
      ).then((response) {
        if (response['success']) {
          // Handle success
          debugPrint('Upload successful: ${response['body']}');
          return response;
        } else {
          // Handle error
          debugPrint('Upload failed: ${response['error']}');
          return response;
        }
      });
    } catch (error) {
      LogHandler.error(error);
    }

    return null;
  }

  createJobApplication(Requisition req) async {

    if (vidReqController.text.isEmpty) {
      ToastWidgit.bottomToast('video requirement is required');
      return;
    }
    if (ctcController.text.isEmpty) {
      ToastWidgit.bottomToast('CTC is required');
      return;
    }
    if (perksController.text.isEmpty) {
      ToastWidgit.bottomToast('perks is required');
      return;
    }

    String endpoint = EndpointService.createJobPostings;

    String countryLocation = 'India'; //hardcoded
    String cityLocation = 'Pune'; //hardcoded

    var videoThumbRes = await uploadFiles();

    String vidUrl = videoThumbRes?['videoURL'] ?? '';
    String thumbnailURL = videoThumbRes?['thumbnailURL'] ?? '';


    Map<String, dynamic> body = {
      'jobRequisitionId': req.id,
      'postedBy': req.requestedBy?.id ?? "",
      'title': req.title,
      'department': req.department ?? "",
      'project': req.project ?? "",
      'openingsCount': int.parse(openingCountController.text.trim()),
      'location': {
        'country': countryLocation,
        'city': cityLocation,
      },
      'jobMode': req.jobMode ?? [],
      'description': descController.text.isEmpty ? req.description : descController.text.trim(),
      'videoRequirement': vidReqController.text.trim(),
      'ctc': ctcController.text.trim(),
      'questions': [],
      'growth_plan': [],
      'perks': perksController.text.trim(),
      'requiredSkills': req.requiredSkills?.map((skill) => {
        'data': skill.id,
        'name': skill.skill?.name ?? '',
        'rating': skill.rating
      }).toList() ?? [],
      'media': {
        'url': vidUrl,
        'type': "video",
        'thumbnail': thumbnailURL
      },
      'endsOn': '',
    };

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);
      LogHandler.debug(response);

      if (response['success']) {

        Get.back();
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      LogHandler.error(error);
    }
  }
}

