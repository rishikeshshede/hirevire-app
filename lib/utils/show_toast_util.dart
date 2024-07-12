import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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

  // static void styledToast(String msg, BuildContext context, bool isSuccess) {
  //   final widget = isSuccess
  //       ? CustomSuccessToastWidget(message: msg)
  //       : CustomFailToastWidget(message: msg);

  //   showToastWidget(
  //     widget,
  //     context: context,
  //     animation: StyledToastAnimation.fade,
  //     reverseAnimation: StyledToastAnimation.fade,
  //     position: StyledToastPosition.bottom,
  //     animDuration: Duration(seconds: 1),
  //     duration: Duration(seconds: 4),
  //     dismissOtherToast: true,
  //   );
  // }
}

class CustomSuccessToastWidget extends StatelessWidget {
  final String message;

  const CustomSuccessToastWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class CustomFailToastWidget extends StatelessWidget {
  final String message;

  const CustomFailToastWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
