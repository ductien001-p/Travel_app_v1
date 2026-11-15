import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/public_image_models.dart';
import '../../utils/public_image_formatters.dart';

Future<void> showPublicImageOptionsSheet({
  required BuildContext context,
  required PublicImageItem image,
  required int index,
  required int total,
  required VoidCallback onViewMap,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => PublicImageOptionsSheet(
      image: image,
      index: index,
      total: total,
      onViewMap: () {
        Navigator.of(ctx).pop();
        onViewMap();
      },
      onCopyLink: () async {
        final url = image.shareUrl ?? image.imageUrl;
        await Clipboard.setData(ClipboardData(text: url));
        if (ctx.mounted) {
          Navigator.of(ctx).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Đã sao chép liên kết ảnh.')),
            );
        }
      },
    ),
  );
}

class PublicImageOptionsSheet extends StatelessWidget {
  const PublicImageOptionsSheet({
    super.key,
    required this.image,
    required this.index,
    required this.total,
    required this.onViewMap,
    required this.onCopyLink,
  });

  final PublicImageItem image;
  final int index;
  final int total;
  final VoidCallback onViewMap;
  final VoidCallback onCopyLink;

  static const _sheetBg = Color(0xF20A0F12);

  @override
  Widget build(BuildContext context) {
    final coords = formatPublicImageCoordinates(
      latitude: image.latitude,
      longitude: image.longitude,
    );
    final location = image.locationShortLabel ?? image.locationLabel ?? '';
    final subtitle = [
      'Ảnh ${index + 1} / $total',
      if (location.isNotEmpty) location,
    ].join(' • ');

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: _sheetBg,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
          border: Border.all(
            color: AppColors.textInverse.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.textInverse.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tùy chọn bức ảnh',
                        style: AppTypography.sectionTitle.copyWith(
                          color: AppColors.textInverse,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                AppPressable(
                  onTap: () => Navigator.of(context).pop(),
                  pressedScale: 0.92,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.textInverse.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.textInverse.withValues(alpha: 0.10),
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Divider(
              height: 1,
              color: AppColors.textInverse.withValues(alpha: 0.10),
            ),
            const SizedBox(height: AppSpacing.sm),
            _OptionTile(
              icon: Icons.location_on_rounded,
              iconTone: _OptionIconTone.teal,
              title: 'Xem vị trí trên bản đồ',
              subtitle: [
                if (coords.isNotEmpty) coords,
                if (image.regionLabel != null) 'Bán đảo ${image.regionLabel}',
              ].where((part) => part.isNotEmpty).join(' • '),
              onTap: onViewMap,
            ),
            _OptionTile(
              icon: Icons.link_rounded,
              iconTone: _OptionIconTone.neutral,
              title: 'Sao chép liên kết ảnh',
              subtitle: 'Chia sẻ trực tiếp qua link ảnh gốc HD',
              onTap: onCopyLink,
            ),
          ],
        ),
      ),
    );
  }
}

enum _OptionIconTone { teal, neutral }

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.iconTone,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final _OptionIconTone iconTone;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color iconBg;
    final Color iconColor;
    final Color border;
    switch (iconTone) {
      case _OptionIconTone.teal:
        iconBg = AppColors.primary.withValues(alpha: 0.20);
        iconColor = const Color(0xFF84F5EF);
        border = const Color(0xFF84F5EF).withValues(alpha: 0.30);
      case _OptionIconTone.neutral:
        iconBg = AppColors.textInverse.withValues(alpha: 0.10);
        iconColor = AppColors.textInverse.withValues(alpha: 0.80);
        border = AppColors.textInverse.withValues(alpha: 0.15);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs + 2),
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.99,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.textInverse.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: AppColors.textInverse.withValues(alpha: 0.05),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: border),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: AppSpacing.sm + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textTertiary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
