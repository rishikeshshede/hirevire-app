import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';
import '../../../common/widgets/spacing_widget.dart';
import '../../../themes/text_theme.dart';
import 'controllers/profile_view_controller.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});
  static final ProfileViewController profileViewController =
      Get.find(tag: 'profileViewController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // First section with purple color
                Container(
                  height: 60,
                  color: AppColors.primary,
                ),
                const VerticalSpace(space: 40,),
                Container(
                  //color: AppColors.disabled,
                  padding: const EdgeInsets.only(top: 20, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      userName(context),
                      const VerticalSpace(space: 8,),
                      userHeadline(context),
                      const VerticalSpace(space: 8,),
                      jobLocation(context),
                      const VerticalSpace(space: 12,),
                      userBioHeading(context),
                      const VerticalSpace(space: 4,),
                      userBio(context),
                      const VerticalSpace(space: 8,),
                      userExperience(context),
                      const VerticalSpace(space: 8,),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 30,
              left: 16,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text userName(BuildContext context) {
    return Text(
      "John Doe",
      style: AppTextThemes.screenTitleStyle(context).copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22.w(context),
      ),
    );
  }

  Text userHeadline(BuildContext context) {
    return Text(
      "React Developer@Ozo Play",
      style: AppTextThemes.secondaryTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Text jobLocation(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: "India, ",
          ),
          TextSpan(
            text: 'Pune',
          ),
        ],
      ),
      style: AppTextThemes.secondaryTextStyle(context),
    );
  }


  Text userBioHeading(BuildContext context) {
    return Text(
      "User Bio",
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

  Text userBio(BuildContext context) {
    return Text(
      "I'm a react developer with 1 yrs of experience in total",
      style: AppTextThemes.secondaryTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.w(context),
      ),
    );
  }

  Text userExperience(BuildContext context) {
    return Text(
      "Experience",
      style: AppTextThemes.bodyTextStyle(context).copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.w(context),
      ),
    );
  }

}
