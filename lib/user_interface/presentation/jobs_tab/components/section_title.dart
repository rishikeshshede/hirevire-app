import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.marginTop = 20,
    this.marginBottom = 10,
  });
  final String title;
  final double marginTop, marginBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      child: Text(
        title,
        style: AppTextThemes.bodyTextStyle(context).copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          fontSize: 16,
        ),
      ),
    );
  }
}
