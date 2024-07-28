import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/endpoint_constants.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:hirevire_app/utils/show_toast_util.dart';
import '../../../../constants/error_constants.dart';
import '../../../../constants/global_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/capitalize_first_letter.dart';
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

  File? selectedVideoFile;
  File? selectedThumbnailFile = File('');

  void onFilesSelected(File? videoFile, File? thumbnailFile) {
    selectedVideoFile = videoFile;
    selectedThumbnailFile = thumbnailFile;
  }

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  //TextEditingController jobModeController = TextEditingController();
  RxString jobModeController = GlobalConstants.locationTypes[0].obs;
  TextEditingController vidReqController = TextEditingController();
  TextEditingController reqSkillsController = TextEditingController();
  TextEditingController perksController = TextEditingController();
  TextEditingController openingCountController = TextEditingController();
  TextEditingController ctcController = TextEditingController();
  TextEditingController tDaysPlanController = TextEditingController();
  TextEditingController sDaysPlanController = TextEditingController();
  TextEditingController nDaysPlanController = TextEditingController();
  TextEditingController qOneController = TextEditingController();
  TextEditingController qTwoController = TextEditingController();

  // Focus nodes
  FocusNode jobTitleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode reqSkillsFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode jobModelFocusNode = FocusNode();
  FocusNode openingCountFocusNode = FocusNode();
  FocusNode perksFocusNode = FocusNode();
  FocusNode ctcFocusNode = FocusNode();
  FocusNode tDaysFocusNode = FocusNode();
  FocusNode sDaysFocusNode = FocusNode();
  FocusNode nDaysFocusNode = FocusNode();
  FocusNode qOneFocusNode = FocusNode();
  FocusNode qTwoFocusNode = FocusNode();

  RxString videoUrl = ''.obs;
  RxString thumbnailUrl = ''.obs;

  void setJobTitle(String? jobTitle) {
    jobTitleController.text = jobTitle ?? '';
  }

  void setOpeningCount(int openingCount) {
    openingCountController.text = openingCount.toString();
  }

  void setJobMode(List<String>? jobMode) {
    jobModeController.value =
        capitalizeFirstLetter(jobMode?[0] ?? GlobalConstants.locationTypes[0]);
  }

  void setDescription(String? desc) {
    descController.text = desc ?? '';
  }

  void setReqSkills(List<RequiredSkill>? skills) {
    final skillsList = skills ?? [];
    final skillsString = skillsList
        .map((skill) => skill.skill?.name)
        .where((name) => name != null)
        .join(', ');

    reqSkillsController.text = skillsString;
  }

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchRequisitions();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
  }

  fetchRequisitions() async {
    isLoading.value = true;
    String endpoint = EndpointService.getRequisitions;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {
        requisitions.value = Requisition.fromJsonList(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        ToastWidgit.bottomToast(errorMsg);
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      ToastWidgit.bottomToast(
          'Unknown error occured while getting Job requisitions');
      LogHandler.error(error);
    } finally {
      isLoading.value = false;
    }
  }

  String getPostTime(DateTime date) {
    return DatetimeUtil.timeAgo(date);
  }

  // Future<Map<String, dynamic>?> uploadFiles() async {
  //   if (selectedVideoFile == null) {
  //     ToastWidgit.bottomToast('please upload video, it is required');
  //   }
  //
  //   try {
  //     await apiClient
  //         .uploadVideoWithThumbnail(
  //       Endpoints.uploadVideoWithThumbnail,
  //       selectedVideoFile!,
  //       selectedThumbnailFile!,
  //     )
  //         .then((response) {
  //       if (response['success']) {
  //         // Handle success
  //         debugPrint('Upload successful: ${response['body']}');
  //         return response;
  //       } else {
  //         // Handle error
  //         debugPrint('Upload failed: ${response['error']}');
  //         return response;
  //       }
  //     });
  //   } catch (error) {
  //     LogHandler.error(error);
  //   }
  //
  //   return null;
  // }

  // List<Map<String, dynamic>> prepareSkillsForPosting(List<RequiredSkill>? existingSkills, TextEditingController reqSkillsController) {
  //   List<String> newSkillNames = reqSkillsController.text.split(',').map((s) => s.trim()).toList();
  //   Map<String, RequiredSkill> existingSkillsMap = {for (var skill in existingSkills ?? []) skill.skill?.name ?? '': skill};
  //
  //   List<Map<String, dynamic>> skillsToPost = [];
  //
  //   for (var skillName in newSkillNames) {
  //     if (existingSkills != null && existingSkillsMap.containsKey(skillName)) {
  //       skillsToPost.add({
  //         'data': existingSkillsMap[skillName]!.id,
  //         'name': skillName,
  //         'rating': existingSkillsMap[skillName]!.rating,
  //       });
  //     }
  //   }
  //
  //   return skillsToPost;
  // }

  createJobApplication(Requisition req) async {
    RxBool isError = false.obs;
    if (selectedVideoFile == null) {
      ToastWidgit.bottomToast('please upload video, it is required');
      return;
    }
    if (jobTitleController.text.isEmpty) {
      errorMsgJobTitle.value = 'job title is required';
      //ToastWidgit.bottomToast('job title is required');
      isError.value = true;
    }
    if (descController.text.isEmpty) {
      errorMsgDescription.value = 'job description is required';
      //ToastWidgit.bottomToast('job description is required');
      isError.value = true;
    }
    if (locationController.text.isEmpty) {
      errorMsgLocation.value = 'location is required';

      // ToastWidgit.bottomToast('location is required');
      isError.value = true;
    }
    if (perksController.text.isEmpty) {
      errorMsgPerks.value = 'job description is required';

      // ToastWidgit.bottomToast('perks are required');
      isError.value = true;
    }
    if (jobModeController.value == GlobalConstants.locationTypes[0]) {
      errorMsgJobMode.value = 'Select Job mode';
    }
    if (ctcController.text.isEmpty) {
      errorMsgCtc.value = 'CTC is required';

      // ToastWidgit.bottomToast('CTC is required');
      isError.value = true;
    }
    if (openingCountController.text.isEmpty) {
      errorMsgOpeningCount.value = 'Opening count is required';

      // ToastWidgit.bottomToast('CTC is required');
      isError.value = true;
    }
    if (tDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlanThi.value = '30 days growth plan is required';

      //ToastWidgit.bottomToast('30 days growth plan is required');
      isError.value = true;
    }
    if (sDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlanSix.value = '60 days growth plan is required';

      // ToastWidgit.bottomToast('60 days growth plan is required');
      isError.value = true;
    }
    if (nDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlan3Mon.value = '90 days growth plan is required';

      // ToastWidgit.bottomToast('90 days growth plan is required');
      isError.value = true;
    }
    // if (qOneController.text.isEmpty) {
    //   ToastWidgit.bottomToast('Question 1 is required');
    //   return;
    // }
    // if (qTwoController.text.isEmpty) {
    //   ToastWidgit.bottomToast('Question 2 is required');
    //   return;
    // }

    if (isError.value) {
      return;
    }

    String endpoint = EndpointService.createJobPostings;

    String countryLocation = 'India'; //hardcoded
    String cityLocation = 'Pune'; //hardcoded

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
      'jobMode': [jobModeController.value],
      'description': descController.text.isEmpty
          ? req.description
          : descController.text.trim(),
      'videoRequirement': '',
      'ctc': ctcController.text.trim(),
      'questions': [
        {"content": qOneController.text.trim(), "type": "text"},
        {"content": qTwoController.text.trim(), "type": "text"}
      ],
      'growth_plan': [
        {
          "title": "30 Days",
          "description": tDaysPlanController.text.trim(),
        },
        {
          "title": "60 Days",
          "description": sDaysPlanController.text.trim(),
        },
        {
          "title": "3 Months",
          "description": nDaysPlanController.text.trim(),
        }
      ],
      'perks': perksController.text.trim(),
      'requiredSkills': req.requiredSkills?.map((skill) {
        return {
          'data': skill.skill?.id ?? '',
          'name': skill.skill?.name ?? '',
          'rating': skill.rating ?? 0,
        };
      }).toList(),
      'media': {
        'url': videoUrl.value,
        'type': "video",
        'thumbnail': thumbnailUrl.value
      },
      'endsOn': DatetimeUtil.getCurrentDateTime().toIso8601String(),
    };

    LogHandler.debug(body);

    try {
      await apiClient
          .uploadVideoWithThumbnail(
        Endpoints.uploadVideoWithThumbnail,
        selectedVideoFile!,
        selectedThumbnailFile!,
      )
          .then((response) async {
        if (response['success']) {
          // Handle success
          LogHandler.debug('Upload successful: $response');
          videoUrl.value = response['body']['videoURL'][0];
          thumbnailUrl.value = response['body']['thumbnailURL'][0];

          body['media'] = {
            'url': response['body']['videoURL'][0],
            "type": "video",
            "thumbnail": response['body']['thumbnailURL'][0]
          };

          Map<String, dynamic> responseRec =
              await apiClient.post(endpoint, body);
          LogHandler.debug(responseRec);

          if (responseRec['success']) {
            Get.back();
          } else {
            String errorMsg =
                responseRec['error']['message'] ?? Errors.somethingWentWrong;
            LogHandler.error(errorMsg);
          }
        } else {
          // Handle error
          debugPrint('Upload failed: ${response['error']}');
        }
      });
    } catch (error) {
      LogHandler.error(error);
      ToastWidgit.bottomToast('Unknown error occurred');
    }
  }
}
