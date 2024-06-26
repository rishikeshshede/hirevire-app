import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.skill,
  });

  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(skill),
    );
  }
}
