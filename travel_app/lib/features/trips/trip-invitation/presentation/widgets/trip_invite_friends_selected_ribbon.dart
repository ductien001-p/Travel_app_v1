import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../data/models/trip_invite_friends_models.dart';

class TripInviteFriendsSelectedRibbon extends StatelessWidget {
  const TripInviteFriendsSelectedRibbon({
    super.key,
    required this.selected,
    required this.onRemove,
    required this.onClear,
  });

  final List<TripInviteCandidate> selected;
  final ValueChanged<TripInviteCandidate> onRemove;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (selected.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'ĐÃ CHỌN ĐỂ MỜI (${selected.length})',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            AppPressable(
              onTap: onClear,
              child: Text(
                'Bỏ chọn tất cả',
                style: AppTypography.caption.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final person in selected) ...[
                _SelectedChip(person: person, onRemove: () => onRemove(person)),
                const SizedBox(width: AppSpacing.xs),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SelectedChip extends StatelessWidget {
  const _SelectedChip({required this.person, required this.onRemove});

  final TripInviteCandidate person;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAvatar(size: 24, initials: initialsOf(person.user.displayName)),
          const SizedBox(width: 6),
          Text(
            person.user.displayName,
            style: AppTypography.caption.copyWith(
              color: AppColors.primaryActive,
              fontWeight: FontWeight.w700,
            ),
          ),
          Semantics(
            button: true,
            label: 'Bỏ chọn ${person.user.displayName}',
            child: AppPressable(
              onTap: onRemove,
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
