import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/social_post_detail_view.dart';

class SocialPostDetailPlaceCard extends StatelessWidget {
  const SocialPostDetailPlaceCard({
    super.key,
    required this.view,
    required this.onOpenPlace,
  });

  final SocialPostDetailView view;
  final VoidCallback? onOpenPlace;

  @override
  Widget build(BuildContext context) {
    final place = view.post.place;
    if (place == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: AppPressable(
        onTap: onOpenPlace,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderBrandSoft),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (view.placeSubtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        view.placeSubtitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: AppColors.textInverse,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
