import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/services/api_service.dart';
import 'package:hirevire_app/utils/datetime_util.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import '../../../../constants/endpoint_constants.dart';
import '../../../../constants/error_constants.dart';
import '../../../../services/api_endpoint_service.dart';
import '../../../../utils/log_handler.dart';
import '../../../../utils/show_toast_util.dart';
import '../../../models/job_recommendations.dart';
import '../../../models/job_seeker_profile.dart';

class JobsController extends GetxController {
  late ApiClient apiClient;

  RxBool isApplyJobPost = false.obs;

  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxBool isProfileComplete = false.obs;
  RxList<bool> isOpen = [true, false, false].obs;

  RxString videoUrl = ''.obs;
  RxString thumbnailUrl = ''.obs;

  String defaultItemId = "Other";

  //RxList<JobModel> jobs = <JobModel>[].obs;
  RxList<JobRecommendationsModel> jobs = <JobRecommendationsModel>[].obs;
  Rx<JobSeekerProfile> jobSeekerProfile = JobSeekerProfile().obs;

  var status = ''.obs; // Status text
  var statusColor = Colors.transparent.obs; // Status color

  var skillRatingValue = 0.00.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController skillsSearchController = TextEditingController();
  TextEditingController additionalNoteController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  final FocusNode searchFocusNode = FocusNode();
  FocusNode additionalNoteFocusNode = FocusNode();

  RxList<Map<String, dynamic>> suggestedJobs = <Map<String, dynamic>>[].obs;

  File? selectedVideoFile;
  File? selectedThumbnailFile = File('');

  RxList<Map<String, dynamic>> selectedSkills = <Map<String, dynamic>>[].obs;
  var skillsRatings = <String, double>{}.obs; // Map to store ratings for skills

  RxString skillsSearchQuery = ''.obs;
  RxList<Map<String, dynamic>> filteredSkillsSuggestions =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    fetchLocalData();
    //fetchJobs();
    debounce(skillsSearchQuery, (_) => suggestSkills(),
        time: const Duration(milliseconds: 300));
    fetchRecommendedJobs();
    fetchUserProfile();
  }

  void addSkill(Map<String, dynamic> selectedSkill) {
    Map<String, dynamic> skillMap = {
      '_id': selectedSkill['_id'],
      'name': selectedSkill['name'],
    };

    bool skillExists = false;

    if (selectedSkills.isEmpty) {
      selectedSkills.add(skillMap);
      skillsRatings[selectedSkill['_id']] = 5.0; // Default rating
    } else {
      for (var skill in selectedSkills) {
        if (skill['name'].toString().toLowerCase() ==
            selectedSkill['name'].toString().toLowerCase()) {
          skillExists = true;
          return;
        }
      }
      if (!skillExists) {
        selectedSkills.add(skillMap);
        skillsRatings[selectedSkill['_id']] = 5.0; // Default rating
      }
    }
    skillsSearchController.clear();
  }

  void updateSkillRating(String skillId, double rating) {
    skillsRatings[skillId] = rating;
  }

  void removeSkill(Map<String, dynamic> skill) {
    selectedSkills.remove(skill);
    skillsRatings.remove(skill['data']);
  }

  Future<void> suggestSkills() async {
    if (skillsSearchQuery.isEmpty) {
      filteredSkillsSuggestions.value = [];
    } else {
      String endpoint = Endpoints.searchSkills;
      String searchQuery = "$endpoint/${skillsSearchQuery.value}";

      try {
        Map<String, dynamic> response = await apiClient.get(searchQuery);

        if (response['success']) {
          List<Map<String, dynamic>> convertedList =
              List<Map<String, dynamic>>.from(response['body']['data']);
          filteredSkillsSuggestions.value = convertedList;
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

  void onFilesSelected(File? videoFile, File? thumbnailFile) {
    selectedVideoFile = videoFile;
    selectedThumbnailFile = thumbnailFile;
  }

  fetchLocalData() async {
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
    isProfileComplete.value =
        await PersistenceHandler.getBool(PersistenceKeys.isProfileComplete) ??
            false;
  }

  toggleGrowthPlan(int index, bool value) {
    isOpen[index] = value;
  }

  String getPostTime(DateTime date) {
    return DatetimeUtil.timeAgo(date);
  }

  void applyJob(JobRecommendationsModel job) {
    jobs.remove(job);
    status.value = 'Applied';
    statusColor.value = Colors.green;
    Get.back();
  }

  void rejectJob(JobRecommendationsModel job) async {
    jobs.remove(job);
    status.value = 'Rejected';
    statusColor.value = Colors.red;

    //isLoading.value = true;
    String endpoint = EndpointService.userLeftSwipe;

    Map<String, dynamic> body = {
      'jobPostId': job.id,
    };

    try {
      Map<String, dynamic> response = await apiClient.post(endpoint, body);
      LogHandler.debug(response);

      if (response['success']) {
        jobs.value =
            JobRecommendationsModel.fromJsonList(response['body']['data']);
      } else {
        String errorMsg =
            response['error']['message'] ?? Errors.somethingWentWrong;
        //ToastWidgit.bottomToast(errorMsg);
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

  fetchUserProfile() async {
    String endpoint = EndpointService.getUserProfile;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);

      if (response['success']) {
        jobSeekerProfile.value = JobSeekerProfile.fromMap(
            response['body']['data']); //get user profile model
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

  fetchRecommendedJobs() async {
    isLoading.value = true;
    String endpoint = EndpointService.getRecommendedJobs;

    try {
      Map<String, dynamic> response = await apiClient.get(endpoint);
      // LogHandler.debug(response);

      if (response['success']) {
        jobs.value =
            JobRecommendationsModel.fromJsonList(response['body']['data']);
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
    } finally {
      isLoading.value = false;
    }
  }

  // uploadFiles() async {
  //   if (selectedVideoFile == null) {
  //     ToastWidgit.bottomToast('please upload video, it is required');
  //   }
  //
  //   try {
  //     await apiClient
  //         .uploadVideoWithThumbnail(
  //       EndpointService.userUploadVideoWithThumbnail,
  //       selectedVideoFile!,
  //       selectedThumbnailFile!,
  //     )
  //         .then((response) {
  //       if (response['success']) {
  //         // Handle success
  //         debugPrint('Upload successful: ${response['body']}');
  //         videoUrl.value = response['body']['videoURL'];
  //         thumbnailUrl.value = response['body']['thumbnailURL'];
  //
  //         // return response;
  //       } else {
  //         // Handle error
  //         debugPrint('Upload failed: ${response['error']}');
  //         //return response;
  //       }
  //     });
  //   } catch (error) {
  //     LogHandler.error(error);
  //   }
  //
  //   return null;
  // }

  submitJobApplication(JobRecommendationsModel job) async {
    isApplyJobPost.value = true;
    LogHandler.debug("skillratings map");
    LogHandler.debug(skillsRatings.entries);

    isLoading.value = true;
    if (selectedVideoFile == null) {
      isApplyJobPost.value = false;
      ToastWidgit.bottomToast('Video resume is required');
      return;
    }

    String endpoint = EndpointService.userJobApply;

    //await uploadFiles();

    List<Map<String, dynamic>> requiredSkills =
        skillsRatings.entries.map((entry) {
      return {
        "skill": entry.key,
        "rating": entry.value,
      };
    }).toList();

    List<Map<String, dynamic>> answers =
        job.questions?.map<Map<String, dynamic>>((question) {
              return {
                "question": question.content,
                "type": question.type,
                "options": question.options ?? [],
                "answer": question.type == "text" ? "" : "",
              };
            }).toList() ??
            [];

    Map<String, dynamic> body = {
      "jobPostId": job.id,
      "media": [
        {
          "url": videoUrl.value,
          "type": "video",
          "thumbnail": thumbnailUrl.value,
        }
      ],
      "answers": answers,
      "requiredSkills": requiredSkills,
    };
    LogHandler.debug(body);

    try {
      await apiClient
          .uploadVideoWithThumbnail(
        EndpointService.userUploadVideoWithThumbnail,
        selectedVideoFile!,
        //  thumbnailFile: selectedThumbnailFile!,
      )
          .then((response) async {
        if (response['success']) {
          // Handle success
          debugPrint('Upload successful: $response}');
          if (response['body']['videoURL'] == null ||
              response['body']['videoURL'].isBlank) {
            videoUrl.value = "";
          } else {
            videoUrl.value = response['body']['videoURL'][0];
          }

          if (response['body']['thumbnailURL'] == null ||
              response['body']['thumbnailURL'].isBlank) {
            thumbnailUrl.value = "";
          } else {
            thumbnailUrl.value = response['body']['thumbnailURL'][0];
          }

          Map<String, dynamic> responseJobApply =
              await apiClient.post(endpoint, body);
          LogHandler.debug(responseJobApply);

          if (responseJobApply['success']) {
            applyJob(job);
            // Get.back();
          } else {
            if (responseJobApply['error']['message'] ==
                "You have already applied for this job") {
              ToastWidgit.bottomToast('You have already applied for this job');
              Get.back();
            }
            String errorMsg = responseJobApply['error']['message'] ??
                Errors.somethingWentWrong;
            LogHandler.error(errorMsg);
          }
        } else {
          // Handle error
          debugPrint('Upload failed: ${response['error']}');
        }
      });
    } catch (error) {
      LogHandler.error(error);

      isLoading.value = false;
    } finally {
      isLoading.value = false;
      isApplyJobPost.value = false;
    }
  }
}

// String dummyJobs = '''
//   [
//     {
//       "id": "abcd123",
//       "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
//       "company_name": "Microsoft",
//       "postedOn": "2024-06-18",
//       "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//       "ref_id": "123asfasf",
//       "applicants": 103,
//       "recruiter": "Martha Franz",
//       "recruiter_designation": "Senior Product Designer",
//       "transaction_date": null,
//       "job_title": "Software Engineer",
//       "location": "Bengaluru, India",
//       "ctc": "24 - 30",
//       "skills": [
//         "ReactJs",
//         "NodeJs",
//         "MySQL",
//         "Docker",
//         "AWS EC2"
//       ],
//       "growth_plan": [
//         {
//           "title": "30 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "60 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "90 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         }
//       ],
//       "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
//       "social_handles": [
//         {
//           "platform": "Instagram",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "LinkedIn",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "X",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         }
//       ]
//     },
//     {
//       "id": "abcd1234",
//       "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
//       "company_name": "Google",
//       "postedOn": "2024-06-24",
//       "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//       "ref_id": "123asfasf",
//       "applicants": 26,
//       "recruiter": "Anne Franz",
//       "recruiter_designation": "Senior Product Designer",
//       "transaction_date": null,
//       "job_title": "Senior Product Designer",
//       "location": "Bengaluru, India",
//       "ctc": "20 - 30",
//       "skills": [
//         "Figma",
//         "UI/UX",
//         "Canva"
//       ],
//       "growth_plan": [
//         {
//           "title": "30 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "60 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "90 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         }
//       ],
//       "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
//       "social_handles": [
//         {
//           "platform": "Instagram",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "LinkedIn",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "X",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         }
//       ]
//     },
//     {
//       "id": "abcd1235",
//       "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
//       "company_name": "Meta",
//       "postedOn": "2024-06-24",
//       "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//       "ref_id": "123asfasf",
//       "applicants": 26,
//       "recruiter": "Pennie Franz",
//       "recruiter_designation": "Senior Product Designer",
//       "transaction_date": null,
//       "job_title": "Senior Product Designer",
//       "location": "Bengaluru, India",
//       "ctc": "20 - 30",
//       "skills": [
//         "Figma",
//         "UI/UX",
//         "Canva"
//       ],
//       "growth_plan": [
//         {
//           "title": "30 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "60 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "90 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         }
//       ],
//       "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
//       "social_handles": [
//         {
//           "platform": "Instagram",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "LinkedIn",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "X",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         }
//       ]
//     },
//     {
//       "id": "abcd1236",
//       "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
//       "company_name": "Microsoft",
//       "postedOn": "2024-06-24",
//       "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//       "ref_id": "123asfasf",
//       "applicants": 26,
//       "recruiter": "Maddie Franz",
//       "recruiter_designation": "Senior Product Designer",
//       "transaction_date": null,
//       "job_title": "Senior Product Designer",
//       "location": "Bengaluru, India",
//       "ctc": "20 - 30",
//       "skills": [
//         "Figma",
//         "UI/UX",
//         "Canva"
//       ],
//       "growth_plan": [
//         {
//           "title": "30 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "60 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "90 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         }
//       ],
//       "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
//       "social_handles": [
//         {
//           "platform": "Instagram",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "LinkedIn",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "X",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         }
//       ]
//     },
//         {
//       "id": "abcd1237",
//       "company_logo_url": "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
//       "company_name": "Microsoft",
//       "postedOn": "2024-06-24",
//       "video_url": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//       "ref_id": "123asfasf",
//       "applicants": 26,
//       "recruiter": "Maggie Franz",
//       "recruiter_designation": "Senior Product Designer",
//       "transaction_date": null,
//       "job_title": "Senior Product Designer",
//       "location": "Bengaluru, India",
//       "ctc": "20 - 30",
//       "skills": [
//         "Figma",
//         "UI/UX",
//         "Canva"
//       ],
//       "growth_plan": [
//         {
//           "title": "30 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "60 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         },
//         {
//           "title": "90 day Plan",
//           "description": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS"
//         }
//       ],
//       "perks": "Good to have experience & understanding cloud infrastructure like AWS. Good to have experience & understanding cloud infrastructure like AWS. \\n\\nGood to have experience & understanding cloud infrastructure like AWS",
//       "social_handles": [
//         {
//           "platform": "Instagram",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "LinkedIn",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         },
//         {
//           "platform": "X",
//           "logoUrl": "",
//           "url": "https://instagram.com/abcd"
//         }
//       ]
//     }
//   ]
//   ''';

//      "video_url": "https://as2.ftcdn.net/v2/jpg/05/59/13/27/1000_F_559132795_F42vuGejg9lXypySClo27RNuZGQdg0is.jpg",