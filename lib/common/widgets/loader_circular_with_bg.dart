import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class LoaderCircularWithBg extends StatelessWidget {
  const LoaderCircularWithBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.w(context),
      width: 46.w(context),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black,
      ),
      child: const CircularProgressIndicator(
        color: AppColors.background,
        strokeWidth: 3,
      ),
    );
  }
}
