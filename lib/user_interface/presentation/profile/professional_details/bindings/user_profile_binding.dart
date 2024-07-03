import 'package:get/get.dart';
import 'package:hirevire_app/user_interface/controllers/complete_profile_controller.dart';

import '../../../../controllers/user_onb_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileController>(() => CompleteProfileController());
    Get.lazyPut<UserOnbController>(() => UserOnbController());
  }
}
