import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

class TripExpensesSettlementSection extends StatelessWidget {
  const TripExpensesSettlementSection({
    super.key,
    required this.settlements,
    required this.onSettleSettlement,
    this.isBusy = false,
  });

  final List<TripExpensesSettlement> settlements;
  final ValueChanged<TripExpensesSettlement> onSettleSettlement;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    if (settlements.isEmpty) return const SizedBox.shrink();

    return AppCard(
      radius: AppRadius.cardLarge,
      color: AppColors.glass85,
      borderColor: AppColors.primary12,
      shadows: AppShadows.level1,
      padding: const EdgeInsets.all(AppSpacing.cardProminent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.currency_exchange_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đề xuất quyết toán tối ưu',
                      style: AppTypography.cardTitle,
                    ),
                    Text(
                      'Chỉ cần ${settlements.length} giao dịch để hoàn tất',
                      style: AppTypography.caption.copyWith(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF99F2EC).withValues(alpha: 0.40),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  'Tự động cân đối',
                  style: AppTypography.badge.copyWith(
                    fontSize: 10,
                    color: const Color(0xFF00716D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < settlements.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            TripExpensesSettlementRow(
              settlement: settlements[i],
              isBusy: isBusy,
              onSettle: canViewerSettleSettlement(settlements[i])
                  ? () => onSettleSettlement(settlements[i])
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}

class TripExpensesSettlementRow extends StatelessWidget {
  const TripExpensesSettlementRow({
    super.key,
    required this.settlement,
    this.onSettle,
    this.isBusy = false,
  });

  final TripExpensesSettlement settlement;
  final VoidCallback? onSettle;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final highlight = settlement.toIsViewer || settlement.fromIsViewer;
    final toColor = settlement.toIsViewer
        ? AppColors.primary
        : AppColors.textPrimary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: highlight
            ? const Color(0xFFE6F6FF).withValues(alpha: 0.70)
            : AppColors.surfaceSubdued.withValues(alpha: 0.70),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.surfaceSubdued,
            child: Text(
              settlement.fromInitials,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        settlement.fromDisplayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: settlement.toIsViewer
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    Flexible(
                      child: Text(
                        settlement.toDisplayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: toColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (settlement.note != null)
                  Text(
                    settlement.note!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatExpenseMoney(settlement.amount),
                style: AppTypography.cardTitle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: highlight ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              if (onSettle != null)
                AppPressable(
                  onTap: isBusy ? null : onSettle,
                  pressedScale: 0.95,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: settlement.toIsViewer
                          ? AppColors.primary
                          : AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      settlementActionLabel(settlement),
                      style: AppTypography.badge.copyWith(
                        fontSize: 11,
                        color: settlement.toIsViewer
                            ? AppColors.textInverse
                            : AppColors.primary,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubdued,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'Chờ xác nhận',
                    style: AppTypography.badge.copyWith(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
