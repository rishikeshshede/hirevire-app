import 'package:get/get.dart';
import 'package:hirevire_app/user_interface/presentation/profile_view/controllers/profile_view_controller.dart';


class ProfileViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewController>(() => ProfileViewController(),
        tag: 'profileViewController');
  }
}
