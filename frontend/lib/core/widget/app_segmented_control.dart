import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_typography.dart';
import 'app_pressable.dart';

class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<AppSegmentedItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        children: items
            .map((item) {
              final selected = item.value == value;
              return Expanded(
                child: AppPressable(
                  key: item.key,
                  onTap: () => onChanged(item.value),
                  pressedScale: 0.97,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.surface : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      boxShadow: selected ? AppShadows.level1 : const [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.label,
                      style: AppTypography.bodyMedium.copyWith(
                        color: selected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: selected
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

class AppSegmentedItem<T> {
  const AppSegmentedItem({required this.value, required this.label, this.key});

  final T value;
  final String label;
  final Key? key;
}
