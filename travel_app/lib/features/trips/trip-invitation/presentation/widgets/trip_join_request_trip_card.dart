import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../../trip-details/presentation/widgets/trip_detail_pill_button.dart';
import '../../application/trip_join_requests_header.dart';
import '../../utils/trip_join_request_formatters.dart';

/// Trip name, seats taken and the invite code of the trip under review.
class TripJoinRequestTripCard extends StatelessWidget {
  const TripJoinRequestTripCard({
    super.key,
    required this.header,
    required this.onCopyInviteCode,
    required this.onShareInviteCode,
  });

  final TripJoinRequestsHeader header;
  final VoidCallback onCopyInviteCode;
  final VoidCallback onShareInviteCode;

  @override
  Widget build(BuildContext context) {
    final inviteCode = header.inviteCode;
    return AppGlassSurface(
      padding: const EdgeInsets.all(AppSpacing.cardProminent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AppBadge(label: joinRequestTripTypeLabel(header)),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(header.tripName, style: AppTypography.screenTitle),
          const SizedBox(height: AppSpacing.sm),
          _CapacityPanel(header: header),
          if (inviteCode != null) ...[
            const SizedBox(height: AppSpacing.md),
            _InviteCodePanel(
              inviteCode: inviteCode,
              onCopy: onCopyInviteCode,
              onShare: onShareInviteCode,
            ),
          ],
        ],
      ),
    );
  }
}

class _CapacityPanel extends StatelessWidget {
  const _CapacityPanel({required this.header});

  final TripJoinRequestsHeader header;

  @override
  Widget build(BuildContext context) {
    final captionStyle = AppTypography.caption.copyWith(
      color: AppColors.textSecondary,
    );
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xxs,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.group_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Flexible(child: Text('Quân số nhóm', style: captionStyle)),
                ],
              ),
              Text.rich(
                TextSpan(
                  text: joinRequestCapacityLabel(header),
                  style: captionStyle.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${joinRequestRemainingLabel(header)}',
                      style: AppTypography.caption.copyWith(
                        color: header.isFull
                            ? AppColors.warning
                            : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          AppProgressBar(value: header.fillRatio),
        ],
      ),
    );
  }
}

class _InviteCodePanel extends StatelessWidget {
  const _InviteCodePanel({
    required this.inviteCode,
    required this.onCopy,
    required this.onShare,
  });

  final String inviteCode;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.vpn_key_outlined,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MÃ MỜI CHÍNH THỨC', style: AppTypography.caption),
                    SelectableText(
                      inviteCode,
                      maxLines: 1,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: TripDetailPillButton(
                    label: 'Sao chép',
                    icon: Icons.content_copy_rounded,
                    variant: TripDetailPillVariant.outlined,
                    onPressed: onCopy,
                  ),
                ),
              ),
              AppIconButton(
                icon: Icons.share_outlined,
                onPressed: onShare,
                semanticLabel: 'Chia sẻ mã mời',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
