import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }
}
