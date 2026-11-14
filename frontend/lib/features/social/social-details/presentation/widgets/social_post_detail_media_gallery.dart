import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/social_post_detail_models.dart';

class SocialPostDetailMediaGallery extends StatelessWidget {
  const SocialPostDetailMediaGallery({
    super.key,
    required this.medias,
    required this.pageIndex,
    required this.onPageChanged,
    this.onFullscreen,
    this.onImageTap,
  });

  final List<SocialPostDetailMedia> medias;
  final int pageIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback? onFullscreen;
  final ValueChanged<int>? onImageTap;

  @override
  Widget build(BuildContext context) {
    if (medias.isEmpty) return const SizedBox.shrink();
    final urls = medias
        .map((m) => m.url)
        .whereType<String>()
        .where((url) => url.isNotEmpty)
        .toList(growable: false);
    if (urls.isEmpty) return const SizedBox.shrink();

    final safeIndex = pageIndex.clamp(0, urls.length - 1);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                itemCount: urls.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  final image = Image.network(
                    urls[index],
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.surfaceSubdued,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  );
                  if (onImageTap == null) return image;
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onImageTap!(index),
                    child: image,
                  );
                },
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.heroOverlay,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        '${safeIndex + 1}/${urls.length}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textInverse,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (onFullscreen != null) ...[
                      const SizedBox(width: 8),
                      Material(
                        color: AppColors.heroOverlay,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: onFullscreen,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.fullscreen_rounded,
                              size: 18,
                              color: AppColors.textInverse,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
