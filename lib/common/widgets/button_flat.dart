import 'package:flutter/material.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ButtonFlat extends StatelessWidget {
  const ButtonFlat({
    super.key,
    required this.onTap,
    required this.btnText,
    this.height,
    this.fontSize = 16,
  });

  final VoidCallback onTap;
  final String btnText;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 42,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: AppTextThemes.smallText(context)
              .copyWith(
                fontWeight: FontWeight.w600,
              )
              .copyWith(fontSize: fontSize!.adaptSize(context)),
        ),
      ),
    );
  }
}
