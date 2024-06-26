import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class AnimatedProgressIndicator extends StatelessWidget {
  final double value;
  final Color progressColor;
  final Color backgroundColor;
  final double height;

  const AnimatedProgressIndicator({
    super.key,
    required this.value,
    this.progressColor = AppColors.primaryDark,
    this.backgroundColor = AppColors.disabled,
    this.height = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpace(space: 45.h(context)),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: const Duration(milliseconds: 500),
          builder: (BuildContext context, double value, Widget? child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(height / 2),
              child: LinearProgressIndicator(
                value: value,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: backgroundColor,
                minHeight: height,
              ),
            );
          },
        ),
        VerticalSpace(space: 45.h(context)),
      ],
    );
  }
}
