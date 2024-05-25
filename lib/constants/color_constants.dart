import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDark = Color(0xFF03045E);
  static const Color primary = Color(0xFF0077B6);
  static const Color primaryLight = Color(0xFF00B4D8);
  static const Color accent = Color(0xFFADE8F4);
  static const Color secondary = Color(0xFF48CAE4);
  static const Color background = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF001D3D);
  static const Color textSecondary = Color.fromARGB(255, 101, 125, 136);
  static const Color disabled = Color(0xFFEEEEEE);
  static const Color red = Color(0xFFDE3939);
  static const Color green = Color(0xFF1FB453);
  static const Color black = Color(0xFF0F0F0F);

  static const gradientPrimary = [
    primaryLight,
    primary,
    primaryDark,
  ];
  static const gradientPrimaryStops = [0.25, 0.5, 0.75];

  static const Map<String, Map<String, Color>> status = {
    'na': {
      'bg': Color(0xFFEEF7FF),
      'text': Color(0xFF0E0079),
    },
    'submitted': {
      'bg': Color(0xFFFEEFAD),
      'text': Color(0xFFFFAF45),
    },
    'review': {
      'bg': Color(0xFFC6DCBA),
      'text': Color(0xFF2C7865),
    },
  };

  static const gradientProfielCard = [
    Color(0xFFECE7FE),
    Color(0xFFF5F6FD),
    Color(0xFFD8E1FC),
  ];
}
