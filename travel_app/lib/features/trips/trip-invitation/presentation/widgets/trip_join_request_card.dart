import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../data/models/trip_join_request_models.dart';
import '../../utils/trip_join_request_formatters.dart';

/// One join request: who asked, how well they fit, and the decision.
class TripJoinRequestCard extends StatelessWidget {
  const TripJoinRequestCard({
    super.key,
    required this.request,
    required this.now,
    this.onApprove,
    this.onReject,
    this.isApproving = false,
    this.isRejecting = false,
  });

  /// Scores from here on are highlighted as a strong fit.
  static const strongMatchScore = 90;

  final TripJoinRequest request;
  final DateTime now;

  /// Null disables the button, e.g. while another decision is being sent.
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final bool isApproving;
  final bool isRejecting;

  @override
  Widget build(BuildContext context) {
    final message = request.message?.trim();
    final hasMatch =
        request.travelPersona != null || request.matchScore != null;
    final isStrongMatch = (request.matchScore ?? 0) >= strongMatchScore;
    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.cardCompact),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RequesterRow(request: request, now: now),
          if (hasMatch) ...[
            const SizedBox(height: AppSpacing.sm),
            _MatchPanel(request: request, isStrongMatch: isStrongMatch),
          ],
          if (message != null && message.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _MessageQuote(message: message, isStrongMatch: isStrongMatch),
          ],
          const SizedBox(height: AppSpacing.sm),
          if (request.status == TripJoinRequestStatus.pending)
            _DecisionButtons(
              requesterName: request.requester.displayName,
              onApprove: onApprove,
              onReject: onReject,
              isApproving: isApproving,
              isRejecting: isRejecting,
            )
          else
            _DecisionResult(request: request, now: now),
        ],
      ),
    );
  }
}

class _RequesterRow extends StatelessWidget {
  const _RequesterRow({required this.request, required this.now});

  final TripJoinRequest request;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final requester = request.requester;
    final recent = isRecentJoinRequest(request.createdAt, now: now);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RequesterAvatar(requester: requester),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      requester.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle,
                    ),
                  ),
                  if (requester.isVerified) ...[
                    const SizedBox(width: AppSpacing.xxs),
                    const Icon(
                      Icons.verified_rounded,
                      size: 16,
                      color: AppColors.primary,
                      semanticLabel: 'Đã xác minh',
                    ),
                  ],
                ],
              ),
              Text(
                '@${requester.username}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption,
              ),
              const SizedBox(height: AppSpacing.xxs / 2),
              Row(
                children: [
                  Icon(
                    recent ? Icons.schedule_rounded : Icons.history_rounded,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Flexible(
                    child: Text(
                      formatJoinRequestAge(request.createdAt, now: now),
                      style: AppTypography.caption,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RequesterAvatar extends StatelessWidget {
  const _RequesterAvatar({required this.requester});

  static const _size = 48.0;
  static const _onlineDot = 14.0;

  final TripJoinRequester requester;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppAvatar(
            size: _size,
            imageUrl: requester.avatarUrl,
            initials: initialsOf(requester.displayName),
          ),
          if (requester.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Semantics(
                label: 'Đang trực tuyến',
                child: Container(
                  width: _onlineDot,
                  height: _onlineDot,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MatchPanel extends StatelessWidget {
  const _MatchPanel({required this.request, required this.isStrongMatch});

  final TripJoinRequest request;
  final bool isStrongMatch;

  @override
  Widget build(BuildContext context) {
    final persona = request.travelPersona;
    final score = request.matchScore;
    final note = request.matchNote?.trim();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isStrongMatch
            ? AppColors.primaryLight
            : AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(
          color: isStrongMatch
              ? AppColors.borderBrandSoft
              : AppColors.borderNeutral,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xxs,
            children: [
              if (persona != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isStrongMatch
                          ? Icons.auto_awesome_rounded
                          : _personaIcon(request.personaType),
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Flexible(
                      child: Text(
                        persona,
                        style: AppTypography.badge.copyWith(
                          color: isStrongMatch
                              ? AppColors.primaryActive
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              if (score != null)
                _MatchScore(score: score, strong: isStrongMatch),
            ],
          ),
          if (note != null && note.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'AI Matchmaker: ',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryActive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: note),
                ],
              ),
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static IconData _personaIcon(
    TripJoinRequestPersonaType? type,
  ) => switch (type) {
    TripJoinRequestPersonaType.soloTraveler => Icons.person_outline_rounded,
    TripJoinRequestPersonaType.familyTraveler => Icons.family_restroom_rounded,
    TripJoinRequestPersonaType.coupleTraveller => Icons.favorite_border_rounded,
    TripJoinRequestPersonaType.groupTraveler => Icons.groups_outlined,
    TripJoinRequestPersonaType.backpacker => Icons.hiking_rounded,
    TripJoinRequestPersonaType.mountainLover => Icons.terrain_rounded,
    TripJoinRequestPersonaType.beachLover => Icons.beach_access_outlined,
    TripJoinRequestPersonaType.adventureTraveler => Icons.explore_outlined,
    TripJoinRequestPersonaType.foodieTraveler => Icons.restaurant_rounded,
    TripJoinRequestPersonaType.cultureTraveler =>
      Icons.temple_buddhist_outlined,
    TripJoinRequestPersonaType.entertainmentTraveller =>
      Icons.celebration_outlined,
    TripJoinRequestPersonaType.photographyLover => Icons.photo_camera_outlined,
    null => Icons.auto_awesome_rounded,
  };
}

class _MatchScore extends StatelessWidget {
  const _MatchScore({required this.score, required this.strong});

  final int score;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs / 2,
      ),
      decoration: BoxDecoration(
        color: strong ? AppColors.primaryActive : AppColors.primary15,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        joinRequestMatchLabel(score),
        style: AppTypography.badge.copyWith(
          color: strong ? AppColors.textInverse : AppColors.primaryActive,
        ),
      ),
    );
  }
}

class _MessageQuote extends StatelessWidget {
  const _MessageQuote({required this.message, required this.isStrongMatch});

  final String message;
  final bool isStrongMatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border(
          left: BorderSide(
            color: isStrongMatch ? AppColors.primary : AppColors.primary38,
            width: 2,
          ),
        ),
      ),
      child: Text(
        '“$message”',
        style: AppTypography.body.copyWith(fontStyle: FontStyle.italic),
      ),
    );
  }
}

class _DecisionButtons extends StatelessWidget {
  const _DecisionButtons({
    required this.requesterName,
    required this.onApprove,
    required this.onReject,
    required this.isApproving,
    required this.isRejecting,
  });

  /// Narrower than this, the buttons stack so their labels stay readable.
  static const _minRowWidth = 260.0;

  final String requesterName;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final bool isApproving;
  final bool isRejecting;

  @override
  Widget build(BuildContext context) {
    final reject = Semantics(
      label: 'Từ chối yêu cầu của $requesterName',
      excludeSemantics: true,
      button: true,
      enabled: onReject != null,
      onTap: isRejecting ? null : onReject,
      child: AppButton(
        label: 'Từ chối',
        leadingIcon: Icons.close_rounded,
        variant: AppButtonVariant.glass,
        isLoading: isRejecting,
        onPressed: onReject,
      ),
    );
    final approve = Semantics(
      label: 'Đồng ý cho $requesterName vào nhóm',
      excludeSemantics: true,
      button: true,
      enabled: onApprove != null,
      onTap: isApproving ? null : onApprove,
      child: AppButton(
        label: 'Đồng ý',
        leadingIcon: Icons.check_rounded,
        isLoading: isApproving,
        onPressed: onApprove,
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _minRowWidth) {
          return Column(
            children: [
              approve,
              const SizedBox(height: AppSpacing.xs),
              reject,
            ],
          );
        }
        // Same height for both variants so the pair reads as one control.
        return SizedBox(
          height: AppSizes.buttonSecondaryHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: reject),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: approve),
            ],
          ),
        );
      },
    );
  }
}

class _DecisionResult extends StatelessWidget {
  const _DecisionResult({required this.request, required this.now});

  final TripJoinRequest request;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final approved = request.status == TripJoinRequestStatus.approved;
    final decidedAt = request.decidedAt;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xxs,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: AppBadge(
            label: joinRequestStatusLabel(request.status),
            tone: approved ? AppBadgeTone.success : AppBadgeTone.danger,
            icon: approved ? Icons.check_circle_outline : Icons.block_rounded,
          ),
        ),
        if (decidedAt != null)
          Text(
            formatJoinRequestAge(decidedAt, now: now),
            style: AppTypography.caption,
          ),
      ],
    );
  }
}
