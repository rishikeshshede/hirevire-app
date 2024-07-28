import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/loader.dart';
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
    this.textStyle,
    this.showLoading = false,
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
  final TextStyle? textStyle;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 42,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: showLoading
              ? AppColors.disabled
              : btnColor ?? AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: showLoading
            ? const LoaderWidget(size: 20)
            : Row(
                mainAxisAlignment: (iconPosition == IconPosition.left ||
                        iconPosition == IconPosition.right)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconPosition == IconPosition.left && iconPath != null)
                    CustomImageView(
                      imagePath: iconPath,
                      height: iconHeight?.h(context) ?? 32.h(context),
                      padding: iconPadding,
                    )
                  else if (iconPosition != IconPosition.center)
                    const HorizontalSpace(space: 8),
                  if (iconPosition == IconPosition.center && iconPath != null)
                    CustomImageView(
                      imagePath: iconPath,
                      height: iconHeight?.h(context) ?? 32.h(context),
                      padding: iconPadding,
                      margin: const EdgeInsets.only(right: 8),
                      color: iconColor,
                    ),
                  Flexible(
                    child: Text(
                      btnText,
                      style: textStyle ??
                          AppTextThemes.buttonTextStyle(context)
                              .copyWith(color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (iconPosition == IconPosition.right && iconPath != null)
                    CustomImageView(
                      imagePath: iconPath,
                      height: iconHeight?.h(context) ?? 32.h(context),
                      padding: iconPadding,
                    )
                  else if (iconPosition != IconPosition.center)
                    const HorizontalSpace(space: 8),
                ],
              ),
      ),
    );
  }
}

enum IconPosition { left, center, right }
