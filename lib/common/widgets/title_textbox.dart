import 'package:flutter/material.dart';
import 'package:hirevire_app/themes/text_theme.dart';

class TextboxTitle extends StatelessWidget {
  const TextboxTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Text(
        title,
        style: AppTextThemes.bodyTextStyle(context).copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
