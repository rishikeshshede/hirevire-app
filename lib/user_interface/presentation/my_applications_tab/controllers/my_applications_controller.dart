import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../../../utils/log_handler.dart';
import '../../../models/my_application.dart';

class MyApplicationsController extends GetxController {
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

  RxList<MyApplication> myApplications = <MyApplication>[].obs;
  var status = ''.obs; // Status text
  var statusColor = Colors.transparent.obs; // Status color

  var filteredApplicationsOriginal = <MyApplication>[].obs;

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationCityController = TextEditingController();
  TextEditingController locationCountryController = TextEditingController();
  //TextEditingController jobModeController = TextEditingController();
  RxString jobModeController = GlobalConstants.locationTypes[0].obs;
  TextEditingController vidReqController = TextEditingController();
  TextEditingController reqSkillsController = TextEditingController();
  TextEditingController perksController = TextEditingController();
  TextEditingController openingCountController = TextEditingController();
  TextEditingController minCtcController = TextEditingController();
  TextEditingController maxCtcController = TextEditingController();
  TextEditingController tDaysPlanController = TextEditingController();
  TextEditingController sDaysPlanController = TextEditingController();
  TextEditingController nDaysPlanController = TextEditingController();
  TextEditingController qOneController = TextEditingController();
  TextEditingController qTwoController = TextEditingController();

  // Focus nodes
  FocusNode jobTitleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode locationCityFocusNode = FocusNode();
  FocusNode locationCountryFocusNode = FocusNode();
  FocusNode openingCountFocusNode = FocusNode();
  FocusNode perksFocusNode = FocusNode();
  FocusNode maxCtcFocusNode = FocusNode();
  FocusNode minCtcFocusNode = FocusNode();
  FocusNode tDaysFocusNode = FocusNode();
  FocusNode sDaysFocusNode = FocusNode();
  FocusNode nDaysFocusNode = FocusNode();
  FocusNode qOneFocusNode = FocusNode();
  FocusNode qTwoFocusNode = FocusNode();

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
  RxString selectedVideoFileUrl = ''.obs;
  RxString selectedThumbnailFileUrl = ''.obs;
  File? selectedThumbnailFile = File('');

  RxString videoUrl = ''.obs;
  RxString thumbnailUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    fetchMyApplications();
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
  }

  void onFilesSelected(File? videoFile, File? thumbnailFile) {
    selectedVideoFile = videoFile;
    selectedThumbnailFile = thumbnailFile;
  }

  void toggleSpecialization(String specialization) {
    if (selectedSpecializations.contains(specialization)) {
      selectedSpecializations.remove(specialization);
    } else {
      selectedSpecializations.add(specialization);
    }
  }

  void clearFilters() {
    selectedSpecializations.clear();

    myApplications.assignAll(filteredApplicationsOriginal);
  }

  applyFilter() async {
    matchesFetched.value = false;

    if (selectedSpecializations.isEmpty) {
      myApplications.value = filteredApplicationsOriginal;
    } else {
      myApplications.value = filteredApplicationsOriginal;

      myApplications.value = myApplications.where((application) {
        return selectedSpecializations.contains(application.status);
      }).toList();
    }

    matchesFetched.value = true;
  }

  fetchMyApplications() async {
    isLoading.value = true;
    String endpoint = EndpointService.getMyApplications;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {
        myApplications.value =
            MyApplication.fromJsonList(response['body']['data']);
        filteredApplicationsOriginal.value =
            MyApplication.fromJsonList(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        ToastWidgit.bottomToast(errorMsg);
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      ToastWidgit.bottomToast(
          'Unknown error occured while getting my applications');
      LogHandler.error(error);
    } finally {
      isLoading.value = false;
    }
  }

  String getPostTime(DateTime date) {
    return DatetimeUtil.timeAgo(date);
  }

  closeJobPosting(String jobPostId) async {
    String endpoint = EndpointService.closeJobPostings;

    Map<String, dynamic> body = {
      'status': 'closed',
    };
    LogHandler.debug(body);

    var url = '$endpoint/$jobPostId';

    try {
      Map<String, dynamic> response = await apiClient.put(url, body);
      LogHandler.debug(response);

      if (response['success']) {
        ToastWidgit.bottomToast('Job posting closed successfully');
        //Get.back();
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        LogHandler.error(errorMsg);
      }
    } catch (error) {
      LogHandler.error(error);
    }
  }

  updateJobPosting(JobPosting jobPosting) async {
    isCreatingJobPost.value = true;
    RxBool isError = false.obs;

    if (jobTitleController.text.isEmpty) {
      errorMsgJobTitle.value = 'job title is required';
      //ToastWidgit.bottomToast('job title is required');
      isError.value = true;
    }
    if (descController.text.isEmpty) {
      errorMsgDescription.value = 'job description is required';
      isError.value = true;
    }
    if (locationCityController.text.isEmpty) {
      errorMsgLocation.value = 'city and country location is required';
      isError.value = true;
    }
    if (locationCountryController.text.isEmpty) {
      errorMsgLocation.value = 'city and country location is required';
      isError.value = true;
    }
    if (perksController.text.isEmpty) {
      errorMsgPerks.value = 'job description is required';
      isError.value = true;
    }
    if (jobModeController.value == GlobalConstants.locationTypes[0]) {
      errorMsgJobMode.value = 'Select Job mode';
    }
    // if (minCtcController.text.isEmpty) {
    //   errorMsgCtc.value = 'CTC range is required';
    //   isError.value = true;
    // }
    if (maxCtcController.text.isEmpty) {
      errorMsgCtc.value = 'CTC is required';
      isError.value = true;
    }
    if (openingCountController.text.isEmpty) {
      errorMsgOpeningCount.value = 'Opening count is required';
      isError.value = true;
    }
    if (tDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlanThi.value = '30 days growth plan is required';
      isError.value = true;
    }
    if (sDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlanSix.value = '60 days growth plan is required';
      isError.value = true;
    }
    if (nDaysPlanController.text.isEmpty) {
      errorMsgGrowthPlan3Mon.value = '90 days growth plan is required';
      isError.value = true;
    }

    if (isError.value) {
      isCreatingJobPost.value = false;
      return;
    }

    String endpoint = EndpointService.updateJobPostings;

    if (isClosedStatus.value) {
      await closeJobPosting(jobPosting.id ?? '');
    }

    Map<String, dynamic> body = {
      "jobRequisitionId": jobPosting.id,
      "postedBy": jobPosting.postedBy?.id ?? '',
      "title": jobTitleController.text.trim(),
      "department": jobPosting.department,
      "project": jobPosting.project,
      "openingsCount": int.parse(openingCountController.text.trim()),
      "location": {
        "country": locationCountryController.text.trim(),
        "city": locationCityController.text.trim(),
      },
      "jobMode": [jobModeController.value],
      "description": descController.text.isEmpty
          ? jobPosting.description
          : descController.text.trim(),
      "videoRequirement": '',
      "ctc": maxCtcController.text.isEmpty
          ? jobPosting.ctc?.max ?? ''
          : maxCtcController.text.trim(),
      "questions": jobPosting.questions?.map((q) => q.toMap()).toList(),
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
      "requiredSkills":
          jobPosting.requiredSkills?.map((s) => s.toMap()).toList(),
      'media': {
        'url': selectedVideoFile != null
            ? videoUrl.value
            : jobPosting.media?[0].url,
        'type': "video",
        'thumbnail': selectedThumbnailFile != null
            ? thumbnailUrl.value
            : jobPosting.media?[0].thumbnail,
      },
      "endsOn": jobPosting.endsOn?.toIso8601String(),
      "status": isClosedStatus.value ? 'closed' : jobPosting.status,
    };

    LogHandler.debug(body);

    var url = '$endpoint/${jobPosting.id}';

    try {
      if (selectedVideoFile != null) {
        await apiClient
            .uploadVideoWithThumbnail(
          Endpoints.uploadVideoWithThumbnail,
          selectedVideoFile!,
          //  thumbnailFile: selectedThumbnailFile!,
        )
            .then((response) async {
          if (response['success']) {
            // Handle success
            LogHandler.debug('Upload successful: $response');
            videoUrl.value = response['body']['videoURL'][0];
            thumbnailUrl.value = response['body']['thumbnailURL'].length > 0
                ? response['body']['thumbnailURL'][0]
                : '';

            body['media'] = {
              'url': videoUrl.value,
              "type": "video",
              "thumbnail": thumbnailUrl.value
            };
            LogHandler.debug(body);

            Map<String, dynamic> responsePut = await apiClient.put(url, body);

            LogHandler.debug(responsePut);

            if (responsePut['success']) {
              await fetchMyApplications();
              ToastWidgit.bottomToast('Updated job posting');
              Get.back();
            } else {
              String errorMsg =
                  responsePut['error']['message'] ?? Errors.somethingWentWrong;
              LogHandler.error(errorMsg);
              ToastWidgit.bottomToast('Error creating job post');
            }
          } else {
            // Handle error
            debugPrint('Upload failed: ${response['error']}');
          }
        });
      } else {
        Map<String, dynamic> response = await apiClient.put(url, body);
        LogHandler.debug(response);

        if (response['success']) {
          await fetchMyApplications();
          ToastWidgit.bottomToast('Job posting updated successfully');
          Get.back();
        } else {
          String errorMsg =
              response['error']['message'] ?? Errors.somethingWentWrong;
          LogHandler.error(errorMsg);
        }
      }
    } catch (error) {
      LogHandler.error(error);
    } finally {
      isCreatingJobPost.value = false;
    }
  }
}

String dummyJobs = '''
  [
    {
      "id": "abcd123",
      "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
      "company_name": "Microsoft",
      "postedOn": "2024-06-18",
      "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "ref_id": "123asfasf",
      "applicants": 103,
      "recruiter": "Martha Franz",
      "recruiter_designation": "Senior Product Designer",
      "transaction_date": null,
      "job_title": "Software Engineer",
      "location": "Bengaluru, India",
      "ctc": "24 - 30",
      "skills": [
        "ReactJs",
        "NodeJs",
        "MySQL",
        "Docker",
        "AWS EC2"
      ],
      "growth_plan": [
        {
          "title": "30 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "60 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "90 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        }
      ],
      "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
      "social_handles": [
        {
          "platform": "Instagram",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "LinkedIn",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "X",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        }
      ]
    },
    {
      "id": "abcd1234",
      "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
      "company_name": "Google",
      "postedOn": "2024-06-24",
      "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "ref_id": "123asfasf",
      "applicants": 26,
      "recruiter": "Anne Franz",
      "recruiter_designation": "Senior Product Designer",
      "transaction_date": null,
      "job_title": "Senior Product Designer",
      "location": "Bengaluru, India",
      "ctc": "20 - 30",
      "skills": [
        "Figma",
        "UI/UX",
        "Canva"
      ],
      "growth_plan": [
        {
          "title": "30 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "60 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "90 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        }
      ],
      "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
      "social_handles": [
        {
          "platform": "Instagram",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "LinkedIn",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "X",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        }
      ]
    },
    {
      "id": "abcd1235",
      "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
      "company_name": "Meta",
      "postedOn": "2024-06-24",
      "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "ref_id": "123asfasf",
      "applicants": 26,
      "recruiter": "Pennie Franz",
      "recruiter_designation": "Senior Product Designer",
      "transaction_date": null,
      "job_title": "Senior Product Designer",
      "location": "Bengaluru, India",
      "ctc": "20 - 30",
      "skills": [
        "Figma",
        "UI/UX",
        "Canva"
      ],
      "growth_plan": [
        {
          "title": "30 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "60 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "90 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        }
      ],
      "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
      "social_handles": [
        {
          "platform": "Instagram",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "LinkedIn",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "X",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        }
      ]
    },
    {
      "id": "abcd1236",
      "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
      "company_name": "Microsoft",
      "postedOn": "2024-06-24",
      "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "ref_id": "123asfasf",
      "applicants": 26,
      "recruiter": "Maddie Franz",
      "recruiter_designation": "Senior Product Designer",
      "transaction_date": null,
      "job_title": "Senior Product Designer",
      "location": "Bengaluru, India",
      "ctc": "20 - 30",
      "skills": [
        "Figma",
        "UI/UX",
        "Canva"
      ],
      "growth_plan": [
        {
          "title": "30 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "60 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "90 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        }
      ],
      "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
      "social_handles": [
        {
          "platform": "Instagram",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "LinkedIn",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "X",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        }
      ]
    },
        {
      "id": "abcd1237",
      "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
      "company_name": "Microsoft",
      "postedOn": "2024-06-24",
      "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "ref_id": "123asfasf",
      "applicants": 26,
      "recruiter": "Maggie Franz",
      "recruiter_designation": "Senior Product Designer",
      "transaction_date": null,
      "job_title": "Senior Product Designer",
      "location": "Bengaluru, India",
      "ctc": "20 - 30",
      "skills": [
        "Figma",
        "UI/UX",
        "Canva"
      ],
      "growth_plan": [
        {
          "title": "30 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "60 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        },
        {
          "title": "90 day Plan",
          "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
        }
      ],
      "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
      "social_handles": [
        {
          "platform": "Instagram",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "LinkedIn",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        },
        {
          "platform": "X",
          "logoUrl": "",
          "url": "https://instagram.com/abcd"
        }
      ]
    }
  ]
  ''';
