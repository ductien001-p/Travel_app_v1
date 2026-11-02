import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_segmented_control.dart';

import '../../application/trip_expenses_filter.dart';
import '../../application/trip_expenses_view.dart';
import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

class TripExpensesFilterBar extends StatelessWidget {
  const TripExpensesFilterBar({
    super.key,
    required this.view,
    required this.onSelectScope,
    required this.onSelectCategory,
  });

  final TripExpensesView view;
  final ValueChanged<TripExpensesScope> onSelectScope;
  final ValueChanged<TripExpensesCategory?> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final filter = view.filter;
    final categories = view.overview.categories.map((c) => c.category).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSegmentedControl<TripExpensesScope>(
          value: filter.scope,
          onChanged: onSelectScope,
          items: [
            const AppSegmentedItem(
              value: TripExpensesScope.all,
              label: 'Tất cả chi tiêu',
            ),
            AppSegmentedItem(
              value: TripExpensesScope.mine,
              label: 'Của tôi (${view.mineCount})',
            ),
            const AppSegmentedItem(
              value: TripExpensesScope.unsettled,
              label: 'Cần quyết toán',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _CategoryChip(
                label: 'Tất cả (${view.overview.expenses.length})',
                selected: filter.category == null,
                onTap: () => onSelectCategory(null),
              ),
              for (final category in categories) ...[
                const SizedBox(width: AppSpacing.xs),
                _CategoryChip(
                  label: expenseCategoryChipLabel(category),
                  selected: filter.category == category,
                  onTap: () => onSelectCategory(category),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderBrandSoft,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: selected
              ? AppTypography.badge.copyWith(
                  fontSize: 11,
                  color: AppColors.textInverse,
                )
              : AppTypography.caption.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
        ),
      ),
    );
  }
}
