import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';

class GreenDot extends StatelessWidget {
  const GreenDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.green,
      ),
    );
  }
}
