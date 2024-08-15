import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class ButtonOutline extends StatelessWidget {
  const ButtonOutline({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.btnColor,
    this.width,
    this.height,
    this.iconPath,
    this.iconHeight,
    this.iconPadding,
    this.textStyle,
    this.borderRadius,
  });

  final String btnText;
  final VoidCallback onPressed;
  final Color? btnColor;
  final double? width;
  final double? height;
  final String? iconPath;
  final double? iconHeight;
  final double? iconPadding;
  final TextStyle? textStyle;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 42,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          side: BorderSide(
            color: btnColor ?? AppColors.primaryDark,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null && iconPath!.isNotEmpty)
              CustomImageView(
                imagePath: iconPath!,
                height: iconHeight?.h(context) ?? 32.h(context),
                padding: iconPadding,
              ),
            if (iconPath == null || iconPath == '') const SizedBox(width: 8),
            Flexible(
              child: Text(
                btnText,
                style: textStyle ??
                    AppTextThemes.buttonTextStyle(context).copyWith(
                      color: btnColor ?? AppColors.primaryDark,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:hirevire_app/common/widgets/custom_image_view.dart';
// import 'package:hirevire_app/constants/color_constants.dart';
// import 'package:hirevire_app/themes/text_theme.dart';
// import 'package:hirevire_app/utils/size_util.dart';
//
// class ButtonOutline extends StatelessWidget {
//   const ButtonOutline({
//     super.key,
//     required this.btnText,
//     required this.onPressed,
//     this.btnColor,
//     this.width,
//     this.height,
//     this.iconPath,
//     this.iconHeight,
//     this.iconPadding,
//   });
//
//   final String btnText;
//   final VoidCallback onPressed;
//   final Color? btnColor;
//   final double? width;
//   final double? height;
//   final String? iconPath;
//   final double? iconHeight;
//   final double? iconPadding;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: width ?? designWidth.adaptSize(context),
//       height: height ?? 42,
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: OutlinedButton(
//         onPressed: onPressed,
//         style: OutlinedButton.styleFrom(
//           backgroundColor: AppColors.background,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           side: BorderSide(
//             color: btnColor ?? AppColors.primary,
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (iconPath != null && iconPath!.isNotEmpty)
//               CustomImageView(
//                 imagePath: iconPath!,
//                 height: iconHeight?.h(context) ?? 32.h(context),
//                 padding: iconPadding,
//               ),
//             if (iconPath == null || iconPath == '') const SizedBox(width: 8),
//             Text(
//               btnText,
//               style: AppTextThemes.buttonTextStyle(context).copyWith(
//                 color: btnColor ?? AppColors.primary,
//               ),
//             ),
//             SizedBox(width: 32.adaptSize(context)),
//           ],
//         ),
//       ),
//     );
//   }
// }

