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
    return Container(
      height: 60.w(context),
      margin: EdgeInsets.only(bottom: 10.w(context)),
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
          ),
          GestureDetector(
            onTap: onTap, // show warning
            child: SizedBox(
              width: 40.w(context),
              height: 60.w(context),
              child: const Icon(
                Icons.delete,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
