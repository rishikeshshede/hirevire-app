import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final String placeholder;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final double? padding;
  final ImageType? imageType;
  final bool showLoader;

  /// [CustomImageView] can be used for showing any type of images.
  /// It will show the placeholder image if the image is not found on the network.
  const CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeholder = 'assets/images/image_not_found.png',
    this.padding,
    this.imageType,
    this.showLoader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    if (imagePath == null || imagePath!.isEmpty) {
      return _placeholderImage();
    }

    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 2.0),
          child: _getImageTypeWidget(imagePath!),
        ),
      ),
    );
  }

  Widget _getImageTypeWidget(String imagePath) {
    if (imageType == ImageType.file) {
      return _buildFileImage(imagePath);
    }
    switch (imagePath.imageType) {
      case ImageType.svg:
        return _buildSvgImage(imagePath);
      case ImageType.network:
        return _buildNetworkImage(imagePath);
      case ImageType.png:
      default:
        return _buildAssetImage(imagePath);
    }
  }

  Widget _buildSvgImage(String imagePath) {
    return SvgPicture.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }

  Widget _buildFileImage(String imagePath) {
    return Image.file(
      File(imagePath),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }

  Widget _buildNetworkImage(String imagePath) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      color: color,
      placeholder: (context, url) => showLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const SizedBox(),
      errorWidget: (context, url, error) => _placeholderImage(),
    );
  }

  Widget _buildAssetImage(String imagePath) {
    return Image.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }

  Widget _placeholderImage() {
    return Padding(
      padding: EdgeInsets.all(padding ?? 2.0),
      child: Image.asset(
        placeholder,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
