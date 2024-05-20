import 'package:flutter/widgets.dart';

class Responsive {
  static double _screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double _screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double _shortestSide(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide;
  }

  static double width(BuildContext context, double value) {
    return _screenWidth(context) * value;
  }

  static double height(BuildContext context, double value) {
    return _screenHeight(context) * value;
  }

  static double shortestSide(BuildContext context, double value) {
    return _shortestSide(context) * value;
  }
}
