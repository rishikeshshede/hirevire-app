import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoUploadWidget extends StatefulWidget {
  @override
  _VideoUploadWidgetState createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  File? _videoFile;
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickVideo,
      child: Container(
        width: double.infinity,
        height: _videoFile == null ? 200 : null,
        decoration: BoxDecoration(
          color: AppColors.background,
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
    );
  }

  Widget _buildUploadContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.upload_file,
          size: 40,
          color: Colors.black,
        ),
        SizedBox(height: 12),
        Text(
          'Upload Your Video',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Choose a file to upload',
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
      final isPortrait = _videoController!.value.size.height > _videoController!.value.size.width;
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: Container(
          height: isPortrait ? 100 : null,
          child: VideoPlayer(_videoController!),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashWidth = 8.0;
    final dashSpace = 4.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height), Offset(startX + dashWidth, size.height), paint);
      startX += dashWidth + dashSpace;
    }

    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
