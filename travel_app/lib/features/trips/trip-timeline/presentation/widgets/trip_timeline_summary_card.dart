import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../application/trip_timeline_live_controller.dart';

class TripTimelineMetric {
  const TripTimelineMetric({
    required this.icon,
    required this.value,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color background;
  final Color foreground;
}

class TripTimelineSummaryCard extends StatelessWidget {
  const TripTimelineSummaryCard({
    super.key,
    required this.metrics,
    required this.liveStatus,
    this.inviteCode,
  });

  final List<TripTimelineMetric> metrics;
  final TripTimelineLiveStatus liveStatus;
  final String? inviteCode;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.card,
      color: AppColors.glass85,
      borderColor: AppColors.glassBorder,
      shadows: AppShadows.level2,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _LiveIndicator(status: liveStatus)),
              if (inviteCode != null) AppBadge(label: inviteCode!),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(height: 1, color: AppColors.borderBrandSoft),
          ),
          Row(
            children: [
              for (final metric in metrics)
                Expanded(child: _MetricTile(metric: metric)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LiveIndicator extends StatelessWidget {
  const _LiveIndicator({required this.status});

  final TripTimelineLiveStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      TripTimelineLiveStatus.live => (
        'Đang đồng bộ trực tiếp',
        AppColors.success,
      ),
      TripTimelineLiveStatus.connecting => (
        'Đang kết nối đồng bộ…',
        AppColors.warning,
      ),
      TripTimelineLiveStatus.offline => (
        'Chưa đồng bộ trực tiếp',
        AppColors.textTertiary,
      ),
    };
    return Semantics(
      liveRegion: true,
      label: label,
      excludeSemantics: true,
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.metric});

  final TripTimelineMetric metric;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${metric.label}: ${metric.value}',
      excludeSemantics: true,
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: metric.background,
              shape: BoxShape.circle,
            ),
            child: Icon(metric.icon, size: 16, color: metric.foreground),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            metric.value,
            style: AppTypography.cardTitle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                metric.label,
                maxLines: 1,
                style: AppTypography.caption.copyWith(fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
