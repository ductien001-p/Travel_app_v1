import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

class TripExpensesCategoryBreakdown extends StatelessWidget {
  const TripExpensesCategoryBreakdown({super.key, required this.categories});

  final List<TripExpensesCategoryShare> categories;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.cardLarge,
      color: AppColors.glass85,
      borderColor: AppColors.glassBorder,
      shadows: AppShadows.level1,
      padding: const EdgeInsets.all(AppSpacing.cardProminent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.donut_small_rounded,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text('Phân bổ danh mục', style: AppTypography.cardTitle),
              const Spacer(),
              Text(
                '${categories.length} danh mục',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _SegmentedBar(categories: categories),
          const SizedBox(height: AppSpacing.sm),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.xs,
            crossAxisSpacing: AppSpacing.xs,
            childAspectRatio: 2.6,
            children: [
              for (final share in categories) _CategoryTile(share: share),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentedBar extends StatelessWidget {
  const _SegmentedBar({required this.categories});

  final List<TripExpensesCategoryShare> categories;

  @override
  Widget build(BuildContext context) {
    final totalAmount = categories.fold<num>(
      0,
      (sum, share) => sum + share.amount,
    );
    final totalPercent = categories.fold<int>(
      0,
      (sum, share) => sum + share.percent,
    );

    return Container(
      height: 14,
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (categories.isEmpty || (totalAmount <= 0 && totalPercent <= 0)) {
            return const SizedBox.expand();
          }

          final widths = <double>[];
          var used = 0.0;
          for (var i = 0; i < categories.length; i++) {
            final share = categories[i];
            final ratio = totalAmount > 0
                ? share.amount / totalAmount
                : share.percent / totalPercent;
            if (i == categories.length - 1) {
              widths.add(
                (constraints.maxWidth - used).clamp(0.0, double.infinity),
              );
            } else {
              final width = constraints.maxWidth * ratio;
              widths.add(width);
              used += width;
            }
          }

          return Row(
            children: [
              for (var i = 0; i < categories.length; i++)
                if (widths[i] > 0)
                  SizedBox(
                    width: widths[i],
                    height: double.infinity,
                    child: ColoredBox(
                      color: expenseCategoryColor(categories[i].category),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.share});

  final TripExpensesCategoryShare share;

  @override
  Widget build(BuildContext context) {
    final color = expenseCategoryColor(share.category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              expenseCategoryLabel(share.category),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${share.percent}%',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                formatExpenseMoneyCompact(share.amount),
                style: AppTypography.caption.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
