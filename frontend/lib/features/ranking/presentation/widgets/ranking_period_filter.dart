import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/ranking_models.dart';

class RankingPeriodFilter extends StatelessWidget {
  const RankingPeriodFilter({
    super.key,
    required this.periods,
    required this.selected,
    required this.onChanged,
  });

  final List<RankingPeriodOption> periods;
  final RankingPeriod selected;
  final ValueChanged<RankingPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Row(
        children: periods
            .map((item) {
              final isSelected = item.id == selected;
              return Expanded(
                child: AppPressable(
                  onTap: () => onChanged(item.id),
                  pressedScale: 0.97,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.surface
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: isSelected
                          ? Border.all(color: AppColors.primary20)
                          : null,
                      boxShadow: isSelected ? AppShadows.level1 : const [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}
