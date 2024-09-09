import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color color;

  const DotWidget({
    super.key,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
