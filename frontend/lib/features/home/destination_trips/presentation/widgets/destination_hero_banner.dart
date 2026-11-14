import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/destination_trips_models.dart';

class DestinationHeroBanner extends StatelessWidget {
  const DestinationHeroBanner({
    super.key,
    required this.profile,
    required this.saved,
    required this.onToggleSaved,
  });

  final DestinationProfile profile;
  final bool saved;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: AppRadius.cardLarge,
      padding: const EdgeInsets.all(AppSpacing.md),
      shadows: AppShadows.level1,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.input),
            child: SizedBox(
              height: 176,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _Cover(url: profile.coverImageUrl),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.heroImageOverlay,
                    ),
                  ),
                  if (profile.weatherLabel != null)
                    Positioned(
                      top: AppSpacing.sm,
                      left: AppSpacing.sm,
                      right: 52,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _WeatherPill(label: profile.weatherLabel!),
                      ),
                    ),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: _SaveButton(saved: saved, onTap: onToggleSaved),
                  ),
                  Positioned(
                    left: AppSpacing.sm,
                    right: AppSpacing.sm,
                    bottom: AppSpacing.sm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (profile.tagline.trim().isNotEmpty)
                          Text(
                            profile.tagline.toUpperCase(),
                            style: AppTypography.badge.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                        if (profile.summary.trim().isNotEmpty)
                          Text(
                            profile.summary,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textInverse,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_hasStat(profile.altitudeLabel) ||
              _hasStat(profile.seasonLabel) ||
              _hasStat(profile.averageCostLabel)) ...[
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1, color: AppColors.surfaceSubdued),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _Stat(label: 'Độ cao', value: profile.altitudeLabel),
                _Stat(
                  label: 'Mùa lý tưởng',
                  value: profile.seasonLabel,
                  bordered: true,
                ),
                _Stat(
                  label: 'Chi phí TB',
                  value: profile.averageCostLabel,
                  emphasize: true,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

bool _hasStat(String? value) => value != null && value.trim().isNotEmpty;

class _Cover extends StatelessWidget {
  const _Cover({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.trim().isEmpty) return const _CoverFallback();
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const _CoverFallback(),
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.primaryLight,
      child: Center(
        child: Icon(
          Icons.landscape_rounded,
          color: AppColors.primary,
          size: 36,
        ),
      ),
    );
  }
}

class _WeatherPill extends StatelessWidget {
  const _WeatherPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wb_sunny_rounded,
            size: 16,
            color: AppColors.warning,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.saved, required this.onTap});

  final bool saved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.9,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.glass85,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Icon(
          saved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 18,
          color: saved ? AppColors.danger : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    this.bordered = false,
    this.emphasize = false,
  });

  final String label;
  final String? value;
  final bool bordered;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: bordered
            ? const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(color: AppColors.surfaceSubdued),
                ),
              )
            : null,
        child: Column(
          children: [
            Text(label, style: AppTypography.caption),
            const SizedBox(height: 2),
            Text(
              (value == null || value!.trim().isEmpty) ? '—' : value!,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: emphasize ? AppColors.primary : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
