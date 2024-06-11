import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirevire_app/common/models/text_model.dart';
import 'package:hirevire_app/constants/endpoint_constants.dart';
import 'package:hirevire_app/constants/error_constants.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/log_handler.dart';

class TextController extends GetxController {
  late ApiClient apiClient;

  RxList<TextModel> texts = <TextModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    apiClient = ApiClient();
    fetchAppTexts();
  }

  Future<void> fetchAppTexts() async {
    String endpoint = Endpoints.getTexts;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);

      if (response['success']) {
        String responseList = json.encode(response['body']['data']);
        texts.value = TextModel().fromJsonList(responseList);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      LogHandler.error(error);
    }
  }

  // Method to get value by key
  String getText(String searchKey) {
    for (TextModel text in texts) {
      if (text.key == searchKey) {
        return text.value!;
      }
    }
    return '';
  }
}
