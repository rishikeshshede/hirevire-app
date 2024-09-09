import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hirevire_app/constants/color_constants.dart';

class ToastWidgit {
  static void bottomToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.disabled,
      textColor: AppColors.primaryDark,
      fontSize: 14.0,
    );
  }
}

class CustomSuccessToastWidget extends StatelessWidget {
  final String message;

  const CustomSuccessToastWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Colors.white),
          const SizedBox(width: 12.0),
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class CustomFailToastWidget extends StatelessWidget {
  final String message;

  const CustomFailToastWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(width: 12.0),
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
