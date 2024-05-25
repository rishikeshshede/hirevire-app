import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/screens/unknown_route_screen.dart';
import 'package:hirevire_app/themes/app_theme.dart';
import 'package:hirevire_app/user_interface/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hirevire',
      theme: theme(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      unknownRoute: GetPage(
        name: '/unknownRoute',
        page: () => const UnknownRouteScreen(),
      ),
    );
  }
}
