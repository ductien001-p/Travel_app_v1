import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';

class ExplorePlaceCover extends StatelessWidget {
  const ExplorePlaceCover({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (url.trim().isEmpty) {
      return _CoverFallback(width: width, height: height);
    }
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, _, _) => _CoverFallback(width: width, height: height),
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.primaryLight,
      alignment: Alignment.center,
      child: const Icon(Icons.landscape_rounded, color: AppColors.primary),
    );
  }
}
