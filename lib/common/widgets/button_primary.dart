import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.btnColor,
    this.width,
    this.height,
    this.iconPath,
    this.iconHeight,
    this.iconPadding,
    this.textColor,
    this.iconPosition = IconPosition.center,
    this.iconColor,
  });

  final String btnText;
  final VoidCallback onPressed;
  final Color? btnColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final String? iconPath;
  final double? iconHeight;
  final double? iconPadding;
  final IconPosition iconPosition;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width ?? designWidth.adaptSize(context),
      height: height ?? 42,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: btnColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Row(
          mainAxisAlignment: (iconPosition == IconPosition.left ||
                  iconPosition == IconPosition.right)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            iconPosition == IconPosition.left
                ? CustomImageView(
                    imagePath: iconPath,
                    height: iconHeight?.h(context) ?? 32.h(context),
                    padding: iconPadding,
                  )
                : const HorizontalSpace(space: 8),
            if (iconPosition == IconPosition.center && iconPath != null)
              CustomImageView(
                imagePath: iconPath,
                height: iconHeight?.h(context) ?? 32.h(context),
                padding: iconPadding,
                margin: const EdgeInsets.only(right: 8),
                color: iconColor,
              ),
            Text(
              btnText,
              style: AppTextThemes.buttonTextStyle(context)
                  .copyWith(color: textColor),
            ),
            iconPosition == IconPosition.right
                ? CustomImageView(
                    imagePath: iconPath,
                    height: iconHeight?.h(context) ?? 32.h(context),
                    padding: iconPadding,
                  )
                : const HorizontalSpace(space: 8),
          ],
        ),
      ),
    );
  }
}

enum IconPosition { left, center, right }
