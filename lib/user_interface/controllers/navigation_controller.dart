import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxBool isSignedIn = false.obs; // default: false

  RxInt currentTabIndex = 0.obs;

  navigate(VoidCallback toScreen) {
    return Timer(const Duration(seconds: 1), () {
      toScreen();
    });
  }

  void onNavTabTap(int index) {
    currentTabIndex.value = index;
  }
}
