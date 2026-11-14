import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/travel_dna_radar_view.dart';
import 'travel_dna_identity_card.dart';
import 'travel_dna_radar_chart.dart';
import 'travel_dna_suggestions.dart';

class TravelDnaRadarBody extends StatefulWidget {
  const TravelDnaRadarBody({
    super.key,
    required this.view,
    required this.onOpenJourney,
    required this.onFindCompanions,
  });

  final TravelDnaRadarView view;
  final VoidCallback onOpenJourney;
  final VoidCallback onFindCompanions;

  @override
  State<TravelDnaRadarBody> createState() => _TravelDnaRadarBodyState();
}

class _TravelDnaRadarBodyState extends State<TravelDnaRadarBody> {
  var _compareCommunity = true;

  @override
  Widget build(BuildContext context) {
    final view = widget.view;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.safeBottom,
      ),
      children: [
        TravelDnaIdentityCard(view: view),
        const SizedBox(height: AppSpacing.lg),
        if (!view.hasDna)
          const AppEmptyView(
            title: 'Chưa có Travel DNA',
            description: 'Check-in trong chuyến đi để bắt đầu bản đồ radar.',
            icon: Icons.radar_rounded,
          )
        else ...[
          AppCard(
            radius: AppRadius.cardLarge,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.radar_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            view.chartTitle,
                            style: AppTypography.sectionTitle,
                          ),
                          Text(
                            'Biểu đồ giải mã gu xê dịch cá nhân hóa',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _CompareToggle(
                      enabled: _compareCommunity,
                      onPressed: () => setState(
                        () => _compareCommunity = !_compareCommunity,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                TravelDnaRadarChart(
                  axes: view.radarAxes,
                  showCommunity: _compareCommunity,
                  userLabel: view.identity.displayName,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${view.details.length} Trục Bản Sắc Chi Tiết',
                  style: AppTypography.sectionTitle,
                ),
              ),
              Text(
                view.updatedLabel,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final axis in view.details) ...[
            TravelDnaAxisCard(axis: axis),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.md),
          if (view.journey != null) ...[
            TravelDnaJourneyCard(
              journey: view.journey!,
              onOpen: widget.onOpenJourney,
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          TravelDnaCompanionSection(
            companions: view.companionPreview,
            onFindCompanions: widget.onFindCompanions,
          ),
        ],
      ],
    );
  }
}

class _CompareToggle extends StatelessWidget {
  const _CompareToggle({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: enabled ? AppColors.primaryLight : AppColors.surfaceSubdued,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.borderBrandSoft),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: enabled ? AppColors.primary : AppColors.textTertiary,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surface,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text('So sánh cộng đồng', style: AppTypography.badge),
            ],
          ),
        ),
      ),
    );
  }
}
