import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/video_upload_widget.dart';

class ProfileUploadWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String? profileImageUrl;
  final String? titleText;

  const ProfileUploadWidget({
    required this.onPressed,
    this.profileImageUrl,
    this.titleText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (titleText != null)
          // Text(
          //   titleText!,
          //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              height: 200, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: profileImageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(profileImageUrl!),
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
              child: profileImageUrl == null
                  ? CustomPaint(
                      painter: DashedBorderPainter(),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              'Upload Profile Picture',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}
