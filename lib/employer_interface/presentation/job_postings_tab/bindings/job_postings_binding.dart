import 'package:get/get.dart';

import '../controllers/job_postings_controller.dart';

class JobPostingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobPostingsController>(() => JobPostingsController(),
        tag: 'jobPostingsController');
  }
}
