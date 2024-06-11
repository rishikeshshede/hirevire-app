import 'package:get/get.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';

class UserOnbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserOnbController>(() => UserOnbController());
  }
}
