import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';

class PublicImageNetwork extends StatelessWidget {
  const PublicImageNetwork({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => const ColoredBox(
        color: AppColors.surfaceSubdued,
        child: Center(
          child: Icon(
            Icons.broken_image_outlined,
            color: AppColors.textTertiary,
          ),
        ),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ColoredBox(
          color: Color(0xFF12181C),
          child: Center(
            child: SizedBox.square(
              dimension: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
