import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ButtonCircular extends StatelessWidget {
  const ButtonCircular({
    super.key,
    this.size = 46,
    this.iconPadding = 14,
    this.btnColor = AppColors.black,
    required this.icon,
    required this.onPressed,
    required this.isActive,
  });

  final double size;
  final double iconPadding;
  final Color btnColor;
  final String icon;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.w(context),
        width: size.w(context),
        // margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? btnColor : AppColors.disabled,
        ),
        child: CustomImageView(
          imagePath: icon,
          padding: iconPadding,
          fit: BoxFit.contain,
          color: AppColors.background,
        ),
      ),
    );
  }
}
