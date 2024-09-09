import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/user_interface/models/job_recommendations.dart';
import 'package:hirevire_app/utils/size_util.dart';

class SocialIconWidget extends StatelessWidget {
  const SocialIconWidget({
    super.key,
    required this.socialMedia,
  });

  final SocialUrl socialMedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: open link socialMedia.url
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath:
                  GlobalConstants.socialProfileTypesMap[socialMedia.platform],
              height: 30.w(context),
            ),
            Text(
              socialMedia.platform ?? 'Other',
              style: AppTextThemes.extraSmallText(context),
            ),
          ],
        ),
      ),
    );
  }
}
