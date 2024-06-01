import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/navigation_controller.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/user_interface/presentation/home_screen.dart';
import 'package:hirevire_app/user_interface/presentation/second_tab_screen.dart';
import 'package:hirevire_app/user_interface/presentation/third_tab_screen.dart';
import 'package:hirevire_app/utils/size_util.dart';

class UserBaseNavigator extends StatefulWidget {
  const UserBaseNavigator({super.key});

  @override
  State<UserBaseNavigator> createState() => _UserBaseNavigatorState();
}

class _UserBaseNavigatorState extends State<UserBaseNavigator> {
  final NavigationController controller = Get.find(tag: 'navController');

  final Color _selectedItemColor = AppColors.primaryDark;
  final Color _unselectedItemColor = Colors.grey;

  final List _screens = [
    const HomeScreen(),
    const SecondTabScreen(),
    const ThirdTabScreen(),
  ];

  Color _changeIconColor(currentIndex) {
    return controller.currentTabIndex.value == currentIndex
        ? _selectedItemColor
        : _unselectedItemColor;
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
          selectedFontSize: 12,
          unselectedFontSize: 11,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _changeIconColor(0),
                  BlendMode.srcIn,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.dummyUserImage,
                  width: 18.w(context),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _changeIconColor(1),
                  BlendMode.srcIn,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.dummyUserImage,
                  width: 18.w(context),
                ),
              ),
              label: 'Second Tab',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _changeIconColor(2),
                  BlendMode.srcIn,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.dummyUserImage,
                  width: 18.w(context),
                ),
              ),
              label: 'Third Tab',
            ),
          ],
        ),
      ),
    );
  }
}
