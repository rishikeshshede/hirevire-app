import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoUploadWidget extends StatefulWidget {
  final Function(File? videoFile, File? thumbnailFile) onFilesSelected;
  String? titleText;

  VideoUploadWidget({required this.onFilesSelected, titleText, super.key});

  @override
  VideoUploadWidgetState createState() => VideoUploadWidgetState();
}

class VideoUploadWidgetState extends State<VideoUploadWidget> {
  File? _videoFile;
  File? _thumbnailFile;
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickVideo,
          child: Container(
            width: double.infinity,
            height: _videoFile == null ? 200 : null,
            decoration: BoxDecoration(
              // color: AppColors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _videoFile == null
                ? CustomPaint(
                    painter: DashedBorderPainter(),
                    child: Center(
                      child: _buildUploadContent(),
                    ),
                  )
                : _buildVideoPreview(),
          ),
        ),
        if (_videoFile != null) _buildThumbnailPicker(),
      ],
    );
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
        widget.onFilesSelected(_videoFile, _thumbnailFile);
      });
    }
  }

  Future<void> _pickThumbnail() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _thumbnailFile = File(pickedFile.path);
        widget.onFilesSelected(_videoFile, _thumbnailFile);
      });
    }
  }

  Widget _buildThumbnailPicker() {
    return GestureDetector(
      onTap: _pickThumbnail,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.disabled),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _thumbnailFile == null
            ? const Column(
                children: [
                  Icon(Icons.image, size: 50, color: AppColors.disabled),
                  SizedBox(height: 8),
                  Text('Pick Thumbnail')
                ],
              )
            : Image.file(
                _thumbnailFile!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildUploadContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.fileIcon,
          height: 35,
        ),
        const SizedBox(height: 12),
        Text(
          widget.titleText ?? 'Upload Video',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Choose a video to upload',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPreview() {
    if (_videoController!.value.isInitialized) {
      final isPortrait = _videoController!.value.size.height >
          _videoController!.value.size.width;
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: SizedBox(
          height: isPortrait ? 100 : null,
          child: VideoPlayer(_videoController!),
        ),
      );
    } else {
      return const Center(
        child: SizedBox(
          width: 50, // Specify the desired width
          height: 50, // Specify the desired height
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.greyDisabled
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    const borderRadius = 12.0;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rrect);

    final Path dashedPath = Path();
    const double totalDashWidth = dashWidth + dashSpace;

    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final Tangent? tangent = pathMetric.getTangentForOffset(distance);
        if (tangent != null) {
          dashedPath.addPath(
            pathMetric.extractPath(distance, distance + dashWidth),
            Offset.zero,
          );
        }
        distance += totalDashWidth;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
