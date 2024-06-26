import 'package:get/get.dart';
import 'package:hirevire_app/employer_interface/controllers/emp_onb_controller.dart';

class EmpLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmpOnbController>(() => EmpOnbController());
  }
}
