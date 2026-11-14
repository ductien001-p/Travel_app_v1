import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/public_image_models.dart';
import '../../utils/public_image_formatters.dart';
import 'public_image_filmstrip.dart';
import 'public_image_glass_icon_button.dart';

class PublicImageViewerTopBar extends StatelessWidget {
  const PublicImageViewerTopBar({
    super.key,
    required this.index,
    required this.total,
    required this.capturedAt,
    required this.onClose,
    required this.onRotate,
    required this.onMore,
    this.onInfo,
    this.moreHighlighted = false,
  });

  final int index;
  final int total;
  final DateTime? capturedAt;
  final VoidCallback onClose;
  final VoidCallback onRotate;
  final VoidCallback onMore;
  final VoidCallback? onInfo;
  final bool moreHighlighted;

  @override
  Widget build(BuildContext context) {
    final stamp = formatPublicImageDateTime(capturedAt);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: Row(
        children: [
          PublicImageGlassIconButton(
            icon: Icons.close_rounded,
            onPressed: onClose,
            semanticLabel: 'Đóng chế độ xem ảnh',
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.heroOverlay.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(
                    color: AppColors.textInverse.withValues(alpha: 0.10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatPublicImageCounter(index, total),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (stamp.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.textInverse.withValues(
                              alpha: 0.40,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          stamp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse.withValues(
                              alpha: 0.90,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          PublicImageGlassIconButton(
            icon: Icons.rotate_90_degrees_cw_rounded,
            onPressed: onRotate,
            semanticLabel: 'Xoay ảnh 90 độ',
          ),
          if (onInfo != null) ...[
            const SizedBox(width: AppSpacing.xs),
            PublicImageGlassIconButton(
              icon: Icons.info_outline_rounded,
              onPressed: onInfo,
              semanticLabel: 'Thông số kỹ thuật Exif',
            ),
          ],
          const SizedBox(width: AppSpacing.xs),
          PublicImageGlassIconButton(
            icon: Icons.more_vert_rounded,
            onPressed: onMore,
            semanticLabel: 'Tùy chọn khác',
            highlighted: moreHighlighted,
          ),
        ],
      ),
    );
  }
}

class PublicImageViewerBottomChrome extends StatelessWidget {
  const PublicImageViewerBottomChrome({
    super.key,
    required this.images,
    required this.index,
    required this.current,
    required this.onSelectIndex,
    required this.onLike,
    required this.onComment,
    required this.onDownload,
    required this.onShare,
  });

  final List<PublicImageItem> images;
  final int index;
  final PublicImageItem current;
  final ValueChanged<int> onSelectIndex;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onDownload;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final caption = current.caption?.trim() ?? '';
    final city = current.cityLabel?.trim() ?? '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PublicImageFilmstrip(
          images: images,
          selectedIndex: index,
          onSelected: onSelectIndex,
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.heroOverlay.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(
                color: AppColors.textInverse.withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        caption.isEmpty ? 'Không có mô tả' : caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textInverse.withValues(alpha: 0.95),
                        ),
                      ),
                    ),
                    if (city.isNotEmpty) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: const Color(
                              0xFF84F5EF,
                            ).withValues(alpha: 0.30),
                          ),
                        ),
                        child: Text(
                          city,
                          style: AppTypography.caption.copyWith(
                            color: const Color(0xFF84F5EF),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Divider(
                  height: 1,
                  color: AppColors.textInverse.withValues(alpha: 0.10),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    _ActionChip(
                      icon: Icons.favorite_rounded,
                      iconColor: AppColors.danger,
                      label: '${current.likeCount}',
                      onTap: onLike,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _ActionChip(
                      icon: Icons.chat_bubble_outline_rounded,
                      iconColor: AppColors.textTertiary,
                      label: '${current.commentCount}',
                      onTap: onComment,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _ActionChip(
                      icon: Icons.download_rounded,
                      iconColor: const Color(0xFF84F5EF),
                      label: 'Tải về HD',
                      onTap: onDownload,
                    ),
                    const Spacer(),
                    AppPressable(
                      onTap: onShare,
                      pressedScale: 0.95,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.45),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.share_rounded,
                              size: 18,
                              color: Color(0xFF00312F),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Chia sẻ',
                              style: AppTypography.bodyMedium.copyWith(
                                color: const Color(0xFF00312F),
                                fontWeight: FontWeight.w700,
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
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.swipe_down_rounded,
              size: 15,
              color: AppColors.textInverse.withValues(alpha: 0.50),
            ),
            const SizedBox(width: 6),
            Text(
              'Vuốt xuống để đóng • Chụm 2 ngón tay để phóng to/thu nhỏ',
              style: AppTypography.caption.copyWith(
                color: AppColors.textInverse.withValues(alpha: 0.50),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}

class PublicImageLocationPill extends StatelessWidget {
  const PublicImageLocationPill({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.96,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.heroOverlay.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: AppColors.textInverse.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_rounded,
              size: 18,
              color: Color(0xFF84F5EF),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textInverse,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PublicImageExifPill extends StatelessWidget {
  const PublicImageExifPill({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    if (summary.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.heroOverlay.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppColors.textInverse.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.photo_camera_outlined,
            size: 15,
            color: Color(0xFF84F5EF),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              summary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.badge.copyWith(
                color: AppColors.textInverse.withValues(alpha: 0.90),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.94,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.textInverse.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textInverse,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
