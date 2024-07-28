import 'package:get/get.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/controllers/requisitions_controller.dart';

class RequisitionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequisitionsController>(() => RequisitionsController(),
        tag: 'requisitionsController');
  }
}
