import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/saved_places_view.dart';

class SavedPlaceCard extends StatelessWidget {
  const SavedPlaceCard({
    super.key,
    required this.place,
    required this.onOpen,
    required this.onUnsave,
    required this.onAddToTrip,
    required this.onShare,
    required this.onMore,
  });

  final SavedPlaceRow place;
  final VoidCallback onOpen;
  final VoidCallback onUnsave;
  final VoidCallback onAddToTrip;
  final VoidCallback onShare;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final group = savedPlaceGroupOf(place.category);
    final category = place.category?.trim();
    return AppPressable(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.glass90,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.glassBorder),
          boxShadow: AppShadows.level1,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(
                icon: group == null
                    ? Icons.place_outlined
                    : savedPlaceGroupIcon(group),
                category: category == null || category.isEmpty
                    ? null
                    : category,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            place.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.cardTitle,
                          ),
                        ),
                        if (place.canUnsave)
                          _IconAction(
                            icon: Icons.bookmark_rounded,
                            color: AppColors.primary,
                            semanticLabel: 'Bỏ lưu khỏi danh sách',
                            onPressed: onUnsave,
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            place.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: AppColors.warning,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                savedPlaceRatingLabel(place.rating),
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Divider(height: 1, color: AppColors.borderNeutral),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Flexible(
                          child: _AddToTripButton(onPressed: onAddToTrip),
                        ),
                        const Spacer(),
                        _IconAction(
                          icon: Icons.share_outlined,
                          color: AppColors.textTertiary,
                          semanticLabel: 'Chia sẻ với bạn bè',
                          onPressed: onShare,
                        ),
                        _IconAction(
                          icon: Icons.more_vert,
                          color: AppColors.textTertiary,
                          semanticLabel: 'Thao tác khác',
                          onPressed: onMore,
                        ),
                      ],
                    ),
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

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.icon, required this.category});

  final IconData icon;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: SizedBox(
        width: 112,
        height: 112,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _thumbnailColors(category),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -6,
                bottom: -8,
                child: Icon(
                  icon,
                  size: 72,
                  color: AppColors.primary.withValues(alpha: 0.18),
                ),
              ),
              if (category != null)
                Positioned(
                  top: AppSpacing.xs,
                  left: AppSpacing.xs,
                  right: AppSpacing.xs,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.glass85,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 2,
                        ),
                        child: Text(
                          category!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.badge.copyWith(
                            color: AppColors.primaryActive,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Color> _thumbnailColors(String? category) {
  final group = savedPlaceGroupOf(category);
  return switch (group) {
    SavedPlaceGroup.food => [
      AppColors.warning.withValues(alpha: 0.35),
      AppColors.primaryLight,
    ],
    SavedPlaceGroup.coast => [
      AppColors.info.withValues(alpha: 0.28),
      AppColors.primaryLight,
    ],
    SavedPlaceGroup.culture => [
      AppColors.star.withValues(alpha: 0.45),
      AppColors.primaryLight,
    ],
    SavedPlaceGroup.mountain => [
      AppColors.success.withValues(alpha: 0.28),
      AppColors.primaryLight,
    ],
    _ => [AppColors.primaryLight, AppColors.surfaceSubdued],
  };
}

class _AddToTripButton extends StatelessWidget {
  const _AddToTripButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onPressed,
      pressedScale: 0.96,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: AppShadows.primaryGlow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add, size: 14, color: AppColors.textInverse),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  'Thêm vào chuyến đi',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.badge.copyWith(
                    color: AppColors.textInverse,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.icon,
    required this.color,
    required this.semanticLabel,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final String semanticLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: AppPressable(
        onTap: onPressed,
        pressedScale: 0.9,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}
