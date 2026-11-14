import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

/// Paging state at the bottom of the timeline.
class TripTimelineFooter extends StatelessWidget {
  const TripTimelineFooter({
    super.key,
    required this.hasMore,
    required this.isLoadingMore,
    required this.hasLoadMoreError,
    required this.onLoadMore,
    this.isFiltered = false,
  });

  final bool hasMore;
  final bool isLoadingMore;
  final bool hasLoadMoreError;
  final VoidCallback onLoadMore;

  /// Whether the list shows one category only, so the end message does not
  /// claim the whole trip history is on screen.
  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (isLoadingMore) {
      child = const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.primary,
        ),
      );
    } else if (hasLoadMoreError) {
      child = Column(
        children: [
          Text(
            'Không tải được các sự kiện cũ hơn.',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(color: AppColors.danger),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppButton(
            label: 'Thử lại',
            variant: AppButtonVariant.secondary,
            expand: false,
            onPressed: onLoadMore,
          ),
        ],
      );
    } else if (hasMore) {
      child = AppButton(
        label: 'Tải thêm sự kiện',
        variant: AppButtonVariant.secondary,
        expand: false,
        onPressed: onLoadMore,
      );
    } else {
      child = _EndOfTimeline(isFiltered: isFiltered);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Center(child: child),
    );
  }
}

class _EndOfTimeline extends StatelessWidget {
  const _EndOfTimeline({required this.isFiltered});

  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            boxShadow: AppShadows.level1,
          ),
          child: const Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          isFiltered
              ? 'Đã hiển thị tất cả sự kiện phù hợp'
              : 'Đã hiển thị tất cả sự kiện của chuyến đi',
          textAlign: TextAlign.center,
          style: AppTypography.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
