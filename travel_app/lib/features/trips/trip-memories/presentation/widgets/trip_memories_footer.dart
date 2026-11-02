import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

/// Paging state at the bottom of the album.
class TripMemoriesFooter extends StatelessWidget {
  const TripMemoriesFooter({
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

  /// Whether a filter is applied, so the end message does not claim the
  /// whole album is on screen.
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
            'Không tải được các ảnh cũ hơn.',
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
        label: 'Tải thêm ảnh',
        variant: AppButtonVariant.secondary,
        expand: false,
        onPressed: onLoadMore,
      );
    } else {
      child = Text(
        isFiltered
            ? 'Đã hiển thị tất cả ảnh phù hợp'
            : 'Đã hiển thị tất cả kỷ niệm của chuyến đi',
        textAlign: TextAlign.center,
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Center(child: child),
    );
  }
}
