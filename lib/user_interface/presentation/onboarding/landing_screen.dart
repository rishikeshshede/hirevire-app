import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/routes/app_routes.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 8.h(context),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.cover),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Responsive.height(context, 0.15)),
            Text(
              "Hirevire",
              style: AppTextThemes.subtitleStyle(context).copyWith(
                fontSize: 28.fSize(context),
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 10.h(context)),
            Text(
              "Make the\nfirst move".toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextThemes.titleStyle(context).copyWith(
                fontSize: 48.fSize(context),
                color: AppColors.primaryDark,
                height: 0.9,
              ),
            ),
            const Spacer(),
            ButtonPrimary(
              iconPath: ImageConstant.linkedInLogo,
              iconHeight: 28,
              iconPadding: 3,
              btnText: 'Login with LinkedIn',
              textColor: AppColors.primary,
              btnColor: AppColors.background,
              // iconPosition: IconPosition.left,
              onPressed: () {},
            ),
            ButtonPrimary(
              btnText: 'Use Email',
              btnColor: Colors.black87,
              onPressed: () {
                Get.toNamed(AppRoutes.emailScreen);
              },
            ),
            SizedBox(height: 40.h(context)),
            const TermsAndContitionsWidget(),
            SizedBox(height: 40.h(context)),
          ],
        ),
      ),
    );
  }
}

class TermsAndContitionsWidget extends StatelessWidget {
  const TermsAndContitionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: 'By signing up, you agree to our ',
              style: AppTextThemes.extraSmallText(context),
            ),
            TextSpan(
              text: 'Terms',
              style: AppTextThemes.extraSmallText(context).copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Terms tapped');
                },
            ),
            TextSpan(
              text: '. See how we use your data in our ',
              style: AppTextThemes.extraSmallText(context),
            ),
            TextSpan(
              text: 'Privacy Policy.',
              style: AppTextThemes.extraSmallText(context).copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                height: 1.5,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Privacy Policy tapped');
                },
            ),
          ],
        ),
      ),
    );
  }
}
