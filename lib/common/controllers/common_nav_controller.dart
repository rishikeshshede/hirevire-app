import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:hirevire_app/common/controllers/text_controller.dart';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';

class CommonNavController extends GetxController {
  RxBool isNew = true.obs; // default: true
  RxBool isEmployee = false.obs; // default: false
  RxBool isSignedIn = false.obs; // default: false
  RxBool isEmailVerified = false.obs; // default: false
  RxBool isUserRegistered = false.obs; // default: false
  RxString authToken = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    Get.put(TextController(), tag: 'textController');
    // await deleteAllLocalValues();
    await fetchAllLocalValues();
    checkLocalDataAndNavigate();
  }

  fetchAllLocalValues() async {
    isNew.value =
        await PersistenceHandler.getBool(PersistenceKeys.isNew) ?? isNew.value;
    isEmployee.value =
        await PersistenceHandler.getBool(PersistenceKeys.isEmployee) ??
            isEmployee.value;
    isSignedIn.value =
        await PersistenceHandler.getBool(PersistenceKeys.isSignedIn) ??
            isSignedIn.value;
    isEmailVerified.value =
        await PersistenceHandler.getBool(PersistenceKeys.isEmailVerified) ??
            isEmailVerified.value;
    isUserRegistered.value =
        await PersistenceHandler.getBool(PersistenceKeys.isUserRegistered) ??
            isUserRegistered.value;
    authToken.value =
        await PersistenceHandler.getString(PersistenceKeys.authToken) ?? '';
    name.value = await PersistenceHandler.getString(PersistenceKeys.name) ?? '';
    email.value =
        await PersistenceHandler.getString(PersistenceKeys.email) ?? '';
  }

  deleteAllLocalValues() async {
    await PersistenceHandler.deleteAll();
  }

  checkLocalDataAndNavigate() {
    isNew.value
        ? navigate(() => toCommonOnboardingScreen())
        : isEmployee.value
            ? isSignedIn.value
                ? navigate(() => toEmpBaseNav())
                : navigate(() => toEmpLoginScreen())
            : isSignedIn.value && authToken.value.isNotEmpty
                ? navigate(() => toUserBaseNav())
                : isUserRegistered.value
                    ? navigate(() => toUserEmailVerification())
                    : isEmailVerified.value
                        ? navigate(() => toNameDobScreen())
                        : navigate(() => toUserEmailVerification());
  }

  void toCommonOnboardingScreen() {
    Get.toNamed(AppRoutes.commonOnboardingScreen);
  }

  void toNameDobScreen() {
    Get.put(UserOnbController());
    Get.toNamed(AppRoutes.nameScreen);
  }

  void toUserEmailVerification() {
    Get.put(UserOnbController());
    Get.toNamed(AppRoutes.userEamilValidationScreen);
  }

  void toEmpLoginScreen() {
    Get.toNamed(AppRoutes.empLoginScreen);
  }

  void toEmpBaseNav() {
    // Get.toNamed(AppRoutes.empBaseNavigator);
  }

  void toUserBaseNav() {
    Get.toNamed(AppRoutes.userBaseNavigator);
  }

  navigate(VoidCallback toScreen) {
    return Timer(const Duration(seconds: 1), () {
      toScreen();
    });
  }
}
