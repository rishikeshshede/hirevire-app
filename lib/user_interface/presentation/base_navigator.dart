import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/navigation_controller.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/user_interface/my_applications_tab/bindings/job_postings_binding.dart';
import 'package:hirevire_app/user_interface/my_applications_tab/my_applications_tab.dart';
import 'package:hirevire_app/user_interface/presentation/chat/bindings/chat_binding.dart';
import 'package:hirevire_app/user_interface/presentation/chat/chat_screen.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/bindings/jobs_binding.dart';
import 'package:hirevire_app/user_interface/presentation/jobs_tab/jobs_tab.dart';
import 'package:hirevire_app/user_interface/presentation/third_tab_screen.dart';
import 'package:hirevire_app/utils/size_util.dart';

class UserBaseNavigator extends StatefulWidget {
  const UserBaseNavigator({super.key});

  @override
  State<UserBaseNavigator> createState() => _UserBaseNavigatorState();
}

class _UserBaseNavigatorState extends State<UserBaseNavigator> {
  final NavigationController controller =
      Get.put(NavigationController(), tag: 'navController');

  final Color _selectedItemColor = AppColors.primaryDark;
  final Color _unselectedItemColor = AppColors.greyDisabled;

  Widget jobsTab() {
    JobsBinding().dependencies();
    return const JobsTab();
  }

  Widget applicationsTab() {
    MyApplicationsBinding().dependencies();
    return const MyApplicationsTab();
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
      jobsTab(),
      applicationsTab(),
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
              label: 'Jobs',
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
              label: 'My Applications',
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
