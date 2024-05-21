import 'package:flutter/material.dart';

// Viewport values of your Figma Design.
const num designWidth = 360;
const num designHeight = 800;
const num designStatusBar = 0;

/// Extension to make UI responsive across all mobile devices.
extension ResponsiveExtension on num {
  /// Get device viewport width.
  double _getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get device viewport height.
  double _getHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    num statusBar = mediaQuery.viewPadding.top;
    num bottomBar = mediaQuery.viewPadding.bottom;
    num screenHeight = mediaQuery.size.height - statusBar - bottomBar;
    return screenHeight as double;
  }

  /// Set padding/margin (for the left and right side) & width of the screen or widget according to the viewport width.
  double w(BuildContext context) => (this * _getWidth(context)) / designWidth;

  /// Set padding/margin (for the top and bottom side) & height of the screen or widget according to the viewport height.
  double h(BuildContext context) =>
      (this * _getHeight(context)) / (designHeight - designStatusBar);

  /// Set the smallest px in image height and width.
  double adaptSize(BuildContext context) {
    var height = h(context);
    var width = w(context);
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  /// Set text font size according to viewport.
  double fSize(BuildContext context) => adaptSize(context);
}

/// Extension for formatting double values.
extension FormatExtension on double {
  /// Return a [double] value formatted to the specified number of fraction digits.
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
