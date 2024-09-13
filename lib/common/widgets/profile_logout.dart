import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/routes/app_routes.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';

class ProfileLogout {
  static Future<void> logout(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await logoutConfirmed();
                //Navigator.of(context).pop();
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> logoutConfirmed() async {
    try {
      await PersistenceHandler.deleteAll();

      Get.offAllNamed(AppRoutes.initialRoute);
    } catch (error) {
      if (kDebugMode) {
        print("Logout error: $error");
      }
    }
  }
}
