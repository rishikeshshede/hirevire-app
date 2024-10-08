import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/shimmer_widgets.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/responsive.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to chat screen
      },
      child: Container(
        width: Responsive.width(context, 1),
        padding: EdgeInsets.symmetric(
          horizontal: GlobalConstants.screenHorizontalPadding,
          vertical: GlobalConstants.screenHorizontalPadding * .55,
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath:
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDZ8fHVzZXJ8ZW58MHx8MHx8fDA%3D',
              height: 45,
              width: 45,
              radius: BorderRadius.circular(25),
              fit: BoxFit.cover,
              padding: 0,
              placeholderWidget: Shimmers.box(
                context,
                height: 45,
                width: 45,
                radius: 30,
              ),
            ),
            const HorizontalSpace(space: 12),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rohit Sharma',
                    style: AppTextThemes.bodyTextStyle(context).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: Responsive.width(context, .1)),
                    child: Text(
                      'We have scheduled your interview on 23rd?',
                      style: AppTextThemes.bodyTextStyle(context)
                          .copyWith(fontSize: 13.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLight,
                    ),
                    child: Text(
                      '1',
                      style: AppTextThemes.buttonTextStyle(context)
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Text(
                    '10:21 am',
                    style: AppTextThemes.extraSmallText(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
