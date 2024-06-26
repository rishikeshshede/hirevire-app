import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    required this.onRemove,
  });

  final String text;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.w(context),
      padding: const EdgeInsets.fromLTRB(15, 6, 6, 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.accent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BodyTextWidget(
            text: text,
          ),
          const HorizontalSpace(
            space: 8,
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.cancel_outlined,
              color: AppColors.red,
            ),
          )
        ],
      ),
    );
  }
}
