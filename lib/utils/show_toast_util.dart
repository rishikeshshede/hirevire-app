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
