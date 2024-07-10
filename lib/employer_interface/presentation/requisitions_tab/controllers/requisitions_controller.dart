import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/employer_interface/models/requisition.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';

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

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchRequisitions();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name);
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

  createJobApplication(Requisition req) async {

    String endpoint = EndpointService.createJobPostings;

    Map<String, dynamic> body = {
      'postedBy': "",
      'requestedBy': req.requestedBy?.id,
      'jobRequisition': req.id,
      'title': req.title,
      'location': {
        'country': req.requestedBy?.company?.locations?[0].country,   //hardcoded index
        'city': req.requestedBy?.company?.locations?[0].city, //hardcoded index
      },
      'jobMode': req.jobMode,
      'description': req.description,
      'questions': [],
      'requiredSkills': req.skills?.map((skill) => skill.id).toList(),
      'media': [],
      'endsOn': req.createdAt, //data unknown
      'savedApplications': [],
      '_id': req.id,
      'createdAt': req.createdAt,
      'updatedAt': req.updatedAt,
      '__v': req.version,
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

