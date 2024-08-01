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

import '../../../../constants/error_constants.dart';
import '../../../../constants/global_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/capitalize_first_letter.dart';
import '../../../../utils/log_handler.dart';

class JobPostingsController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;
  RxBool isClosedStatus = false.obs;

  RxList<JobPosting> jobPostings = <JobPosting>[].obs;
  var status = ''.obs; // Status text
  var statusColor = Colors.transparent.obs; // Status color

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
  TextEditingController ctcController = TextEditingController();
  TextEditingController tDaysPlanController = TextEditingController();
  TextEditingController sDaysPlanController = TextEditingController();
  TextEditingController nDaysPlanController = TextEditingController();
  TextEditingController qOneController = TextEditingController();
  TextEditingController qTwoController = TextEditingController();

  File? selectedVideoFile;
  RxString selectedVideoFileUrl = ''.obs;
  RxString selectedThumbnailFileUrl = ''.obs;
  File? selectedThumbnailFile = File('');

  void setRecruiterVideoThumbnail(String? videoUrl, String? thumbnailUrl) {
    selectedVideoFileUrl.value = videoUrl ?? '';
    selectedThumbnailFileUrl.value = thumbnailUrl ?? '';
  }

  void setJobTitle(String? jobTitle) {
    jobTitleController.text = jobTitle ?? '';
  }

  void setOpeningCount(int openingCount) {
    openingCountController.text = openingCount.toString();
  }

  void setLocation(Location? location) {
    locationCityController.text = location?.city ?? '';
    locationCountryController.text = location?.country ?? '';
  }

  void setPerks(String? perks) {
    jobModeController.value =
        perksController.text = perks ?? '';
  }
  void setCtc(String? ctc) {
    ctcController.text = ctc ?? '';
  }
  void setThiDays(String? growthPlan) {
    tDaysPlanController.text = growthPlan ?? '';
  }
  void setSixDays(String? growthPlan) {
    sDaysPlanController.text = growthPlan ?? '';
  }
  void setNinetyDays(String? growthPlan) {
    nDaysPlanController.text = growthPlan ?? '';
  }

  void setJobMode(List<String>? jobMode) {
    jobModeController.value =
        capitalizeFirstLetter(jobMode?[0] ?? GlobalConstants.locationTypes[0]);
  }

  void setDescription(String? desc) {
    descController.text = desc ?? '';
  }

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

  void onFilesSelected(File? videoFile, File? thumbnailFile) {
    selectedVideoFile = videoFile;
    selectedThumbnailFile = thumbnailFile;
  }

  fetchJobPostings() async {
    isLoading.value = true;
    String endpoint = EndpointService.getJobPostings;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {
        jobPostings.value = JobPosting.fromJsonList(response['body']['data']);
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

  updateJobPosting(JobPosting jobPosting) async {
    String endpoint = EndpointService.updateJobPostings;

    if (isClosedStatus.value) {
      await closeJobPosting(jobPosting.id ?? '');
    }

    Map<String, dynamic> body = {
      "jobRequisitionId": jobPosting.id,
      "postedBy": jobPosting.postedBy?.id ?? '',
      "title": jobPosting.title,
      "department": jobPosting.department,
      "project": jobPosting.project,
      "openingsCount": 0,
      "location": {
        "country": jobPosting.location?.country,
        "city": jobPosting.location?.city
      },
      "jobMode": jobPosting.jobMode,
      "description": jobPosting.description,
      "videoRequirement": '',
      "ctc": jobPosting.ctc,
      "questions": jobPosting.questions?.map((q) => q.toMap()).toList(),
      "growth_plan": jobPosting.growthPlan?.map((g) => g.toMap()).toList(),
      "perks": jobPosting.perks,
      "requiredSkills":
          jobPosting.requiredSkills?.map((s) => s.toMap()).toList(),
      "media": jobPosting.media?.map((m) => m.toMap()).toList(),
      "endsOn": jobPosting.endsOn?.toIso8601String(),
      "status": isClosedStatus.value ? 'closed' : jobPosting.status,
    };

    LogHandler.debug(body);

    var url = '$endpoint/${jobPosting.id}';

    try {
      Map<String, dynamic> response = await apiClient.put(url, body);
      LogHandler.debug(response);

      if (response['success']) {
        ToastWidgit.bottomToast('Job posting closed successfully');
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
