import 'package:get/get.dart';
import 'package:hirevire_app/user_interface/controllers/complete_profile_controller.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';

class JobsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobsController>(() => JobsController(), tag: 'jobsController');
    Get.lazyPut<CompleteProfileController>(() => CompleteProfileController(),
        tag: 'completeProfileController');
  }
}
