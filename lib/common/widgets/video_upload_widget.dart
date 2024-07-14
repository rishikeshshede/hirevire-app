import 'package:flutter/material.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../employer_interface/presentation/requisitions_tab/controllers/requisitions_controller.dart';

class VideoUploadWidget extends StatefulWidget {
  final Function(File? videoFile, File? thumbnailFile) onFilesSelected;

  const VideoUploadWidget({required this.onFilesSelected, Key? key}) : super(key: key);

  @override
  _VideoUploadWidgetState createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  File? _videoFile;
  File? _thumbnailFile;
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
        widget.onFilesSelected(_videoFile, _thumbnailFile);
      });
    }
  }

  Future<void> _pickThumbnail() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _thumbnailFile == null
            ? const Column(
          children: [
            Icon(Icons.image, size: 50, color: Colors.grey),
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
              color: Colors.grey[200],
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

  Widget _buildUploadContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.upload_file,
          size: 40,
          color: Colors.black,
        ),
        const SizedBox(height: 12),
        const Text(
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
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 4.0;
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
