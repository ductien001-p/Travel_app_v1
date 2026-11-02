import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../data/models/trip_invite_friends_models.dart';
import '../../utils/trip_invite_friends_formatters.dart';

class TripInviteFriendsCandidateTile extends StatelessWidget {
  const TripInviteFriendsCandidateTile({
    super.key,
    required this.person,
    required this.selected,
    required this.onPressed,
  });

  final TripInviteCandidate person;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final pending = !person.canInvite;
    final shared = tripInviteSharedTripsLabel(person.tripsTogetherCount);
    final fit = tripInviteFitLabel(
      travelPersona: person.travelPersona,
      matchScore: person.matchScore,
    );
    final subtitle = pending
        ? 'Đã gửi lời mời'
        : fit ??
              (shared.isEmpty
                  ? '@${person.user.username}'
                  : '@${person.user.username} · $shared');
    return Opacity(
      opacity: pending ? 0.8 : 1,
      child: AppCard(
        padding: const EdgeInsets.all(14),
        radius: AppRadius.card,
        borderColor: selected ? AppColors.primary38 : AppColors.borderBrandSoft,
        child: Row(
          children: [
            AppAvatar(size: 48, initials: initialsOf(person.user.displayName)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.user.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            _Action(
              pending: pending,
              selected: selected,
              compact: person.tripsTogetherCount == 0 && !pending && !selected,
              onPressed: onPressed,
              name: person.user.displayName,
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.pending,
    required this.selected,
    required this.compact,
    required this.onPressed,
    required this.name,
  });

  final bool pending;
  final bool selected;
  final bool compact;
  final VoidCallback? onPressed;
  final String name;

  @override
  Widget build(BuildContext context) {
    if (pending) {
      return Text(
        'Chờ duyệt',
        style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
      );
    }
    if (compact && !selected) {
      return AppIconButton(
        icon: Icons.add_rounded,
        onPressed: onPressed,
        semanticLabel: 'Mời $name',
        iconColor: AppColors.primary,
        backgroundColor: AppColors.surface,
      );
    }
    return Semantics(
      button: true,
      label: selected ? 'Bỏ chọn $name' : 'Mời $name',
      child: AppPressable(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(
            selected ? 'Đã chọn' : '+ Mời',
            style: AppTypography.caption.copyWith(
              color: selected ? AppColors.textInverse : AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
