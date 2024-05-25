import 'package:flutter/material.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ButtonFlat extends StatelessWidget {
  const ButtonFlat({
    super.key,
    required this.onTap,
    required this.btnText,
  });

  final VoidCallback onTap;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        btnText,
        style: AppTextThemes.smallText(context)
            .copyWith(
              fontWeight: FontWeight.w600,
            )
            .copyWith(fontSize: 12.5.adaptSize(context)),
      ),
    );
  }
}
