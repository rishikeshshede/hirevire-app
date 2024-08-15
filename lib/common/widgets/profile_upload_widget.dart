import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/video_upload_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileUploadWidget extends StatefulWidget {
  final Function(File? selectedFile) onFileSelected;
  final String? profileImageUrl;
  final String? titleText;
    final File? selectedProfileFile;

  const ProfileUploadWidget({
    required this.onFileSelected,
    this.profileImageUrl,
    this.titleText,
        this.selectedProfileFile,
    super.key,
  });

  @override
  _ProfileUploadWidgetState createState() => _ProfileUploadWidgetState();
}

class _ProfileUploadWidgetState extends State<ProfileUploadWidget> {
  File? selectedProfileFile;

  @override
  void initState() {
    super.initState();
    selectedProfileFile = widget.profileImageUrl != null ? null : widget.profileImageUrl as File?;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        File? newProfileImage = await _pickImageFromGallery();
        if (newProfileImage != null) {
          setState(() {
            selectedProfileFile = newProfileImage;
          });
          widget.onFileSelected(newProfileImage);
        }
      },
      child: Container(
        width: double.infinity,
        height: 200, // Adjust height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: _getDecorationImage(),
        ),
        child: _buildPlaceholderContent(),
      ),
    );
  }

  DecorationImage? _getDecorationImage() {
    if (selectedProfileFile != null) {
      return DecorationImage(
        image: FileImage(selectedProfileFile!),
        fit: BoxFit.contain,
      );
    } else if (widget.profileImageUrl != null) {
      return DecorationImage(
        image: NetworkImage(widget.profileImageUrl!),
        fit: BoxFit.contain,
      );
    }
    return null;
  }

  Widget _buildPlaceholderContent() {
    if (widget.profileImageUrl == null && selectedProfileFile == null) {
      return CustomPaint(
        painter: DashedBorderPainter(),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add, color: AppColors.background),
              const SizedBox(width: 8),
              Text(
                widget.titleText ?? 'Upload Profile Picture',
                style: const TextStyle(color: AppColors.background),
              ),
            ],
          ),
        ),
      );
    }
    return Container(); // Return an empty container if no placeholder is needed
  }

  Future<File?> _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }
}
