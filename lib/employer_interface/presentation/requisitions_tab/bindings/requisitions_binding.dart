import 'package:get/get.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/controllers/requisitions_controller.dart';
import 'package:hirevire_app/user_interface/controllers/complete_profile_controller.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/controllers/jobs_controller.dart';

class RequisitionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequisitionsController>(() => RequisitionsController(), tag: 'requisitionsController');
  }
}
