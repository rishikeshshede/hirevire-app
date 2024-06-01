import 'package:get/get.dart';
import 'package:hirevire_app/common/screens/splash_screen.dart';
import 'package:hirevire_app/common/screens/unknown_route_screen.dart';
import 'package:hirevire_app/user_interface/presentation/base_navigator.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/personal_details.dart/sliding_base.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/landing_screen.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/auth/otp_screen.dart';
import 'package:hirevire_app/user_interface/presentation/onboarding/auth/provide_email_screen.dart';

class AppRoutes {
  // Routes
  static const String initialRoute = '/';
  static const String unknownRoute = '/unknownRoute';
  static const String landingScreen = '/landingScreen';
  static const String emailScreen = '/emailScreen';
  static const String otpScreen = '/otpScreen';
  static const String introScreen = '/introScreen';
  static const String userBaseNavigator = '/userBaseNavigator';

  // Pages
  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: unknownRoute,
      page: () => const UnknownRouteScreen(),
    ),
    GetPage(
      name: landingScreen,
      page: () => const LandingScreen(),
    ),
    GetPage(
      name: emailScreen,
      page: () => const ProvideEmailScreen(),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OTPScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: introScreen,
      page: () => const SlidingBase(),
    ),
    GetPage(
      name: userBaseNavigator,
      page: () => const UserBaseNavigator(),
    ),
  ];
}
