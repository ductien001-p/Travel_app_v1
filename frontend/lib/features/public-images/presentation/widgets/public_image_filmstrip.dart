import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/public_image_models.dart';
import '../../utils/public_image_formatters.dart';
import 'public_image_network.dart';

class PublicImageFilmstrip extends StatelessWidget {
  const PublicImageFilmstrip({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<PublicImageItem> images;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: images.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs + 2),
        itemBuilder: (context, index) {
          final image = images[index];
          final selected = index == selectedIndex;
          final thumb = image.thumbnailUrl ?? image.imageUrl;
          return AppPressable(
            onTap: () => onSelected(index),
            pressedScale: 0.94,
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 56,
              height: 56,
              padding: EdgeInsets.all(selected ? 2 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.textInverse.withValues(alpha: 0.20),
                  width: selected ? 2 : 1,
                ),
              ),
              child: Opacity(
                opacity: selected ? 1 : 0.62,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(selected ? 10 : 12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PublicImageNetwork(url: thumb),
                      Positioned(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.heroOverlay.withValues(
                              alpha: 0.65,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            formatPublicImageClock(image),
                            textAlign: TextAlign.center,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textInverse,
                              fontSize: 8,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
