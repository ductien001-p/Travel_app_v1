import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';
import 'trip_detail_pill_button.dart';
import 'trip_detail_section_header.dart';

class TripDetailMembersSection extends StatelessWidget {
  const TripDetailMembersSection({
    super.key,
    required this.trip,
    required this.isRemoving,
    required this.actionsEnabled,
    required this.onInvite,
    required this.onCopyInviteCode,
    required this.onRotateInviteCode,
    required this.isRotatingInviteCode,
    required this.onTransferAdmin,
    required this.onRemove,
    required this.onViewPhotos,
    this.onOpenJoinRequests,
  });

  final TripDetailOverview trip;
  final bool Function(TripDetailMember member) isRemoving;
  final bool actionsEnabled;
  final VoidCallback onInvite;
  final ValueChanged<String> onCopyInviteCode;
  final VoidCallback onRotateInviteCode;
  final bool isRotatingInviteCode;
  final ValueChanged<TripDetailMember> onTransferAdmin;
  final ValueChanged<TripDetailMember> onRemove;
  final ValueChanged<TripDetailMember> onViewPhotos;

  /// Opens the join requests of the trip; hidden when null.
  final VoidCallback? onOpenJoinRequests;

  @override
  Widget build(BuildContext context) {
    final inviteCode = trip.inviteCode;
    final actions = _headerActions();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripDetailSectionHeader(
          title: 'Thành viên nhóm',
          countLabel: '${trip.members.length} / ${trip.maxMembers}',
          countHighlighted: true,
          trailing: actions.length == 1 ? actions.single : null,
        ),
        // Two pills next to the title would truncate it on a phone.
        if (actions.length > 1) ...[
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: actions,
          ),
        ],
        if (inviteCode != null && inviteCode.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          _InviteCodeBox(
            code: inviteCode,
            onCopy: () => onCopyInviteCode(inviteCode),
            onRotate: onRotateInviteCode,
            isRotating: isRotatingInviteCode,
            actionsEnabled: actionsEnabled,
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        for (final member in trip.members) ...[
          _MemberTile(
            member: member,
            canRemove: trip.canRemove(member),
            isRemoving: isRemoving(member),
            actionsEnabled: actionsEnabled,
            onTransferAdmin: () => onTransferAdmin(member),
            onRemove: () => onRemove(member),
            onViewPhotos: () => onViewPhotos(member),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        if (trip.canInviteMembers) ...[
          const SizedBox(height: AppSpacing.xxs),
          _InviteMoreButton(onPressed: onInvite),
        ],
      ],
    );
  }

  List<Widget> _headerActions() => [
    if (trip.canInviteMembers)
      TripDetailPillButton(
        label: 'Mời bạn',
        icon: Icons.person_add_alt_1_rounded,
        onPressed: onInvite,
      ),
    if (onOpenJoinRequests case final openJoinRequests?)
      TripDetailPillButton(
        label: 'Yêu cầu',
        icon: Icons.how_to_reg_rounded,
        onPressed: openJoinRequests,
      ),
  ];
}

class _InviteCodeBox extends StatelessWidget {
  const _InviteCodeBox({
    required this.code,
    required this.onCopy,
    required this.onRotate,
    required this.isRotating,
    required this.actionsEnabled,
  });

  final String code;
  final VoidCallback onCopy;
  final VoidCallback onRotate;
  final bool isRotating;
  final bool actionsEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Row(
        children: [
          const _CircleIcon(icon: Icons.key_rounded),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mã mời chuyến đi bí mật', style: AppTypography.caption),
                Text(
                  code,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          TripDetailPillButton(
            label: 'Sao chép',
            variant: TripDetailPillVariant.outlined,
            onPressed: actionsEnabled && !isRotating ? onCopy : null,
          ),
          const SizedBox(width: AppSpacing.xs),
          TripDetailPillButton(
            label: 'Đổi mã',
            variant: TripDetailPillVariant.outlined,
            isLoading: isRotating,
            onPressed: actionsEnabled ? onRotate : null,
          ),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({
    required this.member,
    required this.canRemove,
    required this.isRemoving,
    required this.actionsEnabled,
    required this.onTransferAdmin,
    required this.onRemove,
    required this.onViewPhotos,
  });

  final TripDetailMember member;
  final bool canRemove;
  final bool isRemoving;
  final bool actionsEnabled;
  final VoidCallback onTransferAdmin;
  final VoidCallback onRemove;
  final VoidCallback onViewPhotos;

  bool get _isOwner => member.role == TripDetailMemberRole.owner;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      radius: AppRadius.card,
      color: AppColors.glass85,
      child: Row(
        children: [
          _MemberAvatar(member: member),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      member.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle,
                    ),
                    if (_badge() case final badge?)
                      FittedBox(fit: BoxFit.scaleDown, child: badge),
                  ],
                ),
                const SizedBox(height: 2),
                _MemberSubtitle(member: member),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          ?_trailing(),
        ],
      ),
    );
  }

  Widget? _badge() {
    if (_isOwner) {
      return const AppBadge(label: 'Trưởng nhóm', tone: AppBadgeTone.warning);
    }
    if (member.role == TripDetailMemberRole.admin) {
      return AppBadge(label: member.role.label);
    }
    if (member.isNewMember) {
      return const AppBadge(label: 'Mới gia nhập', tone: AppBadgeTone.neutral);
    }
    return null;
  }

  /// "Xem ảnh" whenever the member has photos, then the owner mark, the
  /// management actions or the amount spent.
  Widget? _trailing() {
    final children = [
      if (member.memoryCount > 0)
        _MiniAction(
          icon: Icons.photo_camera_outlined,
          tooltip: 'Xem ảnh của ${member.displayName}',
          onTap: onViewPhotos,
        ),
      ..._statusOrActions(),
    ];
    if (children.isEmpty) return null;
    if (children.length == 1) return children.single;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xxs),
          children[i],
        ],
      ],
    );
  }

  List<Widget> _statusOrActions() {
    if (_isOwner) {
      return const [
        Icon(
          Icons.verified_user_outlined,
          color: AppColors.primary,
          semanticLabel: 'Trưởng nhóm',
        ),
      ];
    }
    if (canRemove) {
      return [
        _MiniAction(
          icon: Icons.admin_panel_settings_outlined,
          tooltip: 'Chuyển quyền quản trị cho ${member.displayName}',
          onTap: actionsEnabled ? onTransferAdmin : null,
        ),
        _MiniAction(
          icon: Icons.person_remove_outlined,
          tooltip: 'Mời ${member.displayName} ra khỏi nhóm',
          destructive: true,
          isLoading: isRemoving,
          onTap: actionsEnabled ? onRemove : null,
        ),
      ];
    }
    final spent = member.amountSpent;
    if (spent != null && spent > 0) {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Đã chi', style: AppTypography.caption),
            Text(
              formatTripMoney(spent),
              style: AppTypography.caption.copyWith(
                color: AppColors.primaryActive,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ];
    }
    return const [];
  }
}

class _MemberSubtitle extends StatelessWidget {
  const _MemberSubtitle({required this.member});

  final TripDetailMember member;

  @override
  Widget build(BuildContext context) {
    final persona = member.travelPersona;
    final status = member.isOnline ? 'Đang hoạt động' : member.activityNote;
    final hasPersona = persona != null && persona.isNotEmpty;
    final hasStatus = status != null && status.isNotEmpty;

    if (!hasPersona && !hasStatus) {
      return Text(member.role.label, style: AppTypography.caption);
    }

    return Text.rich(
      TextSpan(
        style: AppTypography.caption,
        children: [
          if (hasPersona)
            TextSpan(
              text: persona,
              style: const TextStyle(color: AppColors.primaryActive),
            ),
          if (hasPersona && hasStatus) const TextSpan(text: '  •  '),
          if (hasStatus)
            TextSpan(
              text: status,
              style: TextStyle(
                color: member.isOnline
                    ? AppColors.success
                    : AppColors.textSecondary,
              ),
            ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({required this.member});

  final TripDetailMember member;

  static const _size = 48.0;

  @override
  Widget build(BuildContext context) {
    final isOwner = member.role == TripDetailMemberRole.owner;
    return SizedBox.square(
      dimension: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: isOwner ? AppColors.warning : AppColors.primaryLight,
              ),
            ),
            child: AppAvatar(
              size: _size - 4,
              imageUrl: member.avatarUrl,
              initials: initialsOf(member.displayName),
            ),
          ),
          if (isOwner)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.warning,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  size: 12,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          if (member.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MiniAction extends StatelessWidget {
  const _MiniAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.destructive = false,
    this.isLoading = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool destructive;
  final bool isLoading;

  static const _size = 36.0;

  @override
  Widget build(BuildContext context) {
    final foreground = destructive ? AppColors.danger : AppColors.textSecondary;
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: AppPressable(
          onTap: isLoading ? null : onTap,
          pressedScale: 0.9,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            width: _size,
            height: _size,
            decoration: BoxDecoration(
              color: destructive
                  ? AppColors.danger.withValues(alpha: 0.12)
                  : AppColors.surfaceSubdued,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: foreground,
                    ),
                  )
                : Icon(icon, size: 18, color: foreground),
          ),
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: AppColors.primary),
    );
  }
}

class _InviteMoreButton extends StatelessWidget {
  const _InviteMoreButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onPressed,
      pressedScale: 0.98,
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary08,
          borderRadius: BorderRadius.circular(AppRadius.input),
          border: Border.all(color: AppColors.primary38),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.contacts_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                'Mời thêm từ danh bạ & Bạn bè Teal Horizon',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
