import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/responsive.dart';
import 'package:hirevire_app/utils/size_util.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.controller,
    this.title,
    required this.list,
    required this.onChanged,
    required this.initialValue,
  });

  final dynamic controller;
  final String? title;
  final String initialValue;
  final List<String> list;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title!,
                style: AppTextThemes.smallText(context)
                    .copyWith(fontSize: 12.5.adaptSize(context)),
              ),
            ),
          const SizedBox(height: 5),
          Container(
            width: Responsive.width(context, 1) - 32,
            height: 42.w(context),
            padding:
                EdgeInsets.symmetric(horizontal: 10.w(context), vertical: 0),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryDark),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Colors.black,
              //     spreadRadius: 1,
              //     blurRadius: 0,
              //     offset: Offset(2, 3),
              //   ),
              // ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: initialValue,
                items: list.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
                isExpanded: true,
                style: AppTextThemes.bodyTextStyle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
