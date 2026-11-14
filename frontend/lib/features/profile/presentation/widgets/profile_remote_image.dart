import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';

class ProfileRemoteImage extends StatelessWidget {
  const ProfileRemoteImage({super.key, required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;
    if (imageUrl == null || imageUrl.isEmpty) {
      return const ColoredBox(
        color: AppColors.surfaceSubdued,
        child: Center(
          child: Icon(Icons.image_outlined, color: AppColors.textTertiary),
        ),
      );
    }
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, _, _) => const ColoredBox(
        color: AppColors.surfaceSubdued,
        child: Center(
          child: Icon(Icons.image_outlined, color: AppColors.textTertiary),
        ),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ColoredBox(color: AppColors.surfaceSubdued);
      },
    );
  }
}
