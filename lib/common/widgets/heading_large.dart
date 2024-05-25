import 'package:flutter/material.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class HeadingLarge extends StatelessWidget {
  const HeadingLarge({
    super.key,
    required this.heading,
  });
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: AppTextThemes.titleStyle(context).copyWith(
        fontSize: 38.fSize(context),
        height: 1.2,
      ),
    );
  }
}
