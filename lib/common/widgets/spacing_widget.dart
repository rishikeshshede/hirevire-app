import 'package:flutter/material.dart';
import 'package:hirevire_app/utils/size_util.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({super.key, this.space = 6});

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space.h(context));
  }
}

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({super.key, this.space = 6});

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space.w(context));
  }
}
