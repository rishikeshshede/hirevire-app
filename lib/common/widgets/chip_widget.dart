import 'package:flutter/material.dart';

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
        color: const Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }
}
