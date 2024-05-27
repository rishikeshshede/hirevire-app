import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/utils/size_util.dart';

class SocialUrlCard extends StatelessWidget {
  const SocialUrlCard({
    super.key,
    required this.platform,
    required this.url,
    required this.onTap,
  });

  final String platform;
  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 60,
          margin: EdgeInsets.only(right: 8.w(context), bottom: 10.w(context)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.disabled.withOpacity(.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CustomImageView(
                imagePath: GlobalConstants.socialProfileTypesMap[platform],
                height: 20,
              ),
              const HorizontalSpace(space: 8),
              Expanded(
                child: Text(
                  url,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: -6,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.cancel_outlined,
              color: AppColors.red,
            ),
          ),
        )
      ],
    );
  }
}
