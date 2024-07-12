import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/employer_interface/models/job_posting.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';

import '../../../../constants/error_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/log_handler.dart';

class JobPostingsController extends GetxController {
  late ApiClient apiClient;

  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;

  RxList<JobPosting> jobPostings = <JobPosting>[].obs;
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
    name.value = await PersistenceHandler.getString(PersistenceKeys.name);
  }

  fetchJobPostings() async {

    String endpoint = EndpointService.getJobPostings;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      LogHandler.debug(response);

      if (response['success']) {
        jobPostings.value = JobPosting.fromJsonList(response['body']['data']);
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

  submitJobApplication() async {

    String endpoint = ""; //Endpoints.submitJob; //TODO: add api endpoint

    Map<String, dynamic> body = {

    };
    LogHandler.debug(body);

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