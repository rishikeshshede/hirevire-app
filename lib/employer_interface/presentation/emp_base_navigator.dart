import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/chat/bindings/chat_binding.dart';
import 'package:hirevire_app/employer_interface/presentation/chat/chat_screen.dart';
import 'package:hirevire_app/employer_interface/presentation/job_postings_tab/bindings/job_postings_binding.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/bindings/requisitions_binding.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/requisitions_tab.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

import '../controllers/emp_navigation_controller.dart';
import 'job_postings_tab/job_postings_tab.dart';

class EmployerBaseNavigator extends StatefulWidget {
  const EmployerBaseNavigator({super.key});

  @override
  State<EmployerBaseNavigator> createState() => _EmployerBaseNavigatorState();
}

class _EmployerBaseNavigatorState extends State<EmployerBaseNavigator> {
  final EmpNavigationController controller =
      Get.put(EmpNavigationController(), tag: 'navController');

  final Color _selectedItemColor = AppColors.primaryDark;
  final Color _unselectedItemColor = AppColors.greyDisabled;

  Widget requisitionsTab() {
    RequisitionsBinding().dependencies();
    return const RequisitionsTab();
  }

  Widget postingsTab() {
    JobPostingsBinding().dependencies();
    return const JobPostingsTab();
  }

  Widget chatTab() {
    ChatBinding().dependencies();
    return const ChatScreen();
  }

  late final List<Widget> _screens;

  Color _changeIconColor(currentIndex) {
    return controller.currentTabIndex.value == currentIndex
        ? _selectedItemColor
        : _unselectedItemColor;
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      requisitionsTab(),
      postingsTab(),
      chatTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _screens[controller.currentTabIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentTabIndex.value,
          onTap: controller.onNavTabTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: _selectedItemColor,
          unselectedItemColor: _unselectedItemColor,
          backgroundColor: AppColors.background,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          elevation: 5,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _changeIconColor(0),
                  BlendMode.srcIn,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.bagIcon,
                  width: 18.w(context),
                ),
              ),
              label: 'Requisitions',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _changeIconColor(1),
                  BlendMode.srcIn,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.applicationIcon,
                  width: 18.w(context),
                ),
              ),
              label: 'Job Postings',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _changeIconColor(2),
                  BlendMode.srcIn,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.chatIcon,
                  width: 18.w(context),
                ),
              ),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
