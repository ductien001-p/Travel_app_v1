import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../application/achivement_view.dart';
import '../../data/models/achivement_models.dart';

Future<void> showCompletionRewardSheet(
  BuildContext context, {
  required AchivementCompletionResult result,
  VoidCallback? onOpenRanking,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        CompletionRewardSheet(result: result, onOpenRanking: onOpenRanking),
  );
}

class CompletionRewardSheet extends StatelessWidget {
  const CompletionRewardSheet({
    super.key,
    required this.result,
    this.onOpenRanking,
  });

  final AchivementCompletionResult result;
  final VoidCallback? onOpenRanking;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md + bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryActive, AppColors.primary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary38,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.textInverse,
                size: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Chúc mừng hoàn thành!',
              style: AppTypography.screenTitle.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (result.tripName.trim().isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                result.tripName,
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Text(
              achivementPointsLabel(result.pointsAwarded, withPlus: true),
              style: AppTypography.display.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'ĐÃ CỘNG VÀO BẢNG XẾP HẠNG DU LỊCH',
              style: AppTypography.badge.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (result.tierLabel != null &&
                result.tierLabel!.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.primary20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Cấp hiện tại · ${result.tierLabel} · x${result.multiplierUsed}',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            const Divider(color: AppColors.borderNeutral),
            const SizedBox(height: AppSpacing.sm),
            _BreakdownRow(
              icon: Icons.check_circle_rounded,
              label: 'Điểm trip check-in (×5)',
              value: achivementPointsLabel(result.basePoints, withPlus: true),
            ),
            const SizedBox(height: AppSpacing.sm),
            _BreakdownRow(
              icon: Icons.task_alt_rounded,
              label: 'Nhiệm vụ đã hoàn thành (${result.missionsCompleted})',
              value: achivementPointsLabel(
                result.missionPoints,
                withPlus: true,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _BreakdownRow(
              icon: Icons.bolt_rounded,
              label: 'Hệ số nhân cấp',
              value: 'x${result.multiplierUsed}',
              valueColor: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(color: AppColors.borderBrandSoft),
              ),
              child: Row(
                children: [
                  Text(
                    'Công thức thưởng',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      result.formulaLabel,
                      textAlign: TextAlign.end,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (result.nextTierHint != null &&
                result.nextTierHint!.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubdued,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.borderBrandSoft),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.military_tech_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            result.nextTierHint!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '${(result.nextTierProgress * 100).round()}%',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    AppProgressBar(value: result.nextTierProgress, height: 6),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onOpenRanking?.call();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textInverse,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Xem bảng xếp hạng',
                      style: AppTypography.sectionTitle.copyWith(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.leaderboard_rounded, size: 20),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Đóng',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Text(
          value,
          style: AppTypography.body.copyWith(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
