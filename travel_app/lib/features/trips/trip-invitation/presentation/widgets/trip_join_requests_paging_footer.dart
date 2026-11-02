import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

/// Paging state under the request cards.
class TripJoinRequestsPagingFooter extends StatelessWidget {
  const TripJoinRequestsPagingFooter({
    super.key,
    required this.isLoadingMore,
    required this.hasLoadMoreError,
    required this.onLoadMore,
  });

  final bool isLoadingMore;
  final bool hasLoadMoreError;
  final VoidCallback onLoadMore;

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
    } else {
      child = Column(
        children: [
          if (hasLoadMoreError) ...[
            Text(
              'Không tải được các yêu cầu cũ hơn.',
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
          AppButton(
            label: hasLoadMoreError ? 'Thử lại' : 'Xem thêm yêu cầu',
            variant: AppButtonVariant.secondary,
            expand: false,
            onPressed: onLoadMore,
          ),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(child: child),
    );
  }
}
