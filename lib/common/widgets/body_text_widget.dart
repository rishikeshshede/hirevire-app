import 'package:flutter/material.dart';
import 'package:hirevire_app/themes/text_theme.dart';

class BodyTextWidget extends StatelessWidget {
  const BodyTextWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextThemes.bodyTextStyle(context),
    );
  }
}
