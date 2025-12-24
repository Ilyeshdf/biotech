import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SafeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool isCircular;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the URL is valid
    if (imageUrl.isEmpty) {
      return _buildErrorWidget(context);
    }

    try {
      Widget imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) =>
            placeholder ??
            const Center(
              child: CircularProgressIndicator(),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildErrorWidget(context),
        memCacheWidth: 300,
        memCacheHeight: 300,
        maxWidthDiskCache: 300,
        maxHeightDiskCache: 300,
      );

      if (isCircular) {
        return ClipOval(child: imageWidget);
      }

      return imageWidget;
    } catch (e) {
      return _buildErrorWidget(context);
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: (width ?? 50) * 0.6,
        color: Colors.grey[600],
      ),
    );
  }
}

class SafeNetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final String fallbackUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const SafeNetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.fallbackUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
      errorWidget: SafeNetworkImage(
        imageUrl: fallbackUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: placeholder,
        errorWidget: errorWidget,
      ),
    );
  }
}
