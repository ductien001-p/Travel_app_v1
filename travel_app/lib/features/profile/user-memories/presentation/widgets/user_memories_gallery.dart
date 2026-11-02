import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/features/profile/presentation/widgets/profile_remote_image.dart';

import '../../application/user_memories_view.dart';
import '../../data/models/user_memories_models.dart';

class UserMemoriesGalleryGrid extends StatelessWidget {
  const UserMemoriesGalleryGrid({
    super.key,
    required this.items,
    required this.layout,
    required this.onOpen,
    required this.onLike,
  });

  final List<UserMemoryPhoto> items;
  final UserMemoriesLayout layout;
  final ValueChanged<UserMemoryPhoto> onOpen;
  final ValueChanged<UserMemoryPhoto> onLike;

  @override
  Widget build(BuildContext context) {
    final height = layout == UserMemoriesLayout.grid
        ? _squareHeight
        : _featureHeight;
    return Column(
      children: [
        for (var index = 0; index < items.length; index += 2) ...[
          if (index > 0) const SizedBox(height: AppSpacing.sm),
          _pair(
            items[index],
            index + 1 < items.length ? items[index + 1] : null,
            height,
          ),
        ],
      ],
    );
  }

  Widget _pair(UserMemoryPhoto first, UserMemoryPhoto? second, double height) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _MemoryTile(
            photo: first,
            height: height,
            onOpen: onOpen,
            onLike: onLike,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: second == null
              ? SizedBox(height: height)
              : _MemoryTile(
                  photo: second,
                  height: height,
                  onOpen: onOpen,
                  onLike: onLike,
                ),
        ),
      ],
    );
  }
}

const _squareHeight = 176.0;
const _featureHeight = 220.0;

class _MemoryTile extends StatelessWidget {
  const _MemoryTile({
    required this.photo,
    required this.height,
    required this.onOpen,
    required this.onLike,
  });

  final UserMemoryPhoto photo;
  final double height;
  final ValueChanged<UserMemoryPhoto> onOpen;
  final ValueChanged<UserMemoryPhoto> onLike;

  @override
  Widget build(BuildContext context) {
    final badge = photo.badge;
    return AppPressable(
      onTap: () => onOpen(photo),
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.input),
          border: Border.all(color: AppColors.glassBorder),
          boxShadow: AppShadows.level1,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ProfileRemoteImage(url: photo.imageUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.heroImageOverlay,
              ),
            ),
            Positioned(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badge != null && badge.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.90),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        badge,
                        style: AppTypography.badge.copyWith(
                          color: AppColors.textInverse,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                  ],
                  Text(
                    userMemoryTitle(photo),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          photo.tripName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse.withValues(
                              alpha: 0.85,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => onLike(photo),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 2,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                photo.liked
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 13,
                                color: AppColors.danger,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${photo.likeCount}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textInverse,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
