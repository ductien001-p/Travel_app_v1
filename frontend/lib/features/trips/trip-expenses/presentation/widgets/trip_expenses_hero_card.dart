import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

class TripExpensesHeroCard extends StatelessWidget {
  const TripExpensesHeroCard({
    super.key,
    required this.overview,
    required this.onAddExpense,
    required this.onSettleDebts,
  });

  final TripExpensesOverview overview;
  final VoidCallback onAddExpense;
  final VoidCallback onSettleDebts;

  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00504D), Color(0xFF006A66), Color(0xFF20A29D)],
    stops: [0.0, 0.45, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    final summary = overview.summary;
    final net = summary.viewerNetBalance;
    final netLabel = net >= 0 ? 'Cần nhận lại' : 'Cần trả thêm';

    return Container(
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(AppRadius.hero),
        boxShadow: AppShadows.primaryGlow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -48,
            right: -48,
            child: _DecorRing(size: 192, opacity: 0.15),
          ),
          Positioned(
            bottom: -32,
            left: -32,
            child: _DecorRing(size: 160, opacity: 0.10),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        'QUỸ NHÓM CHUNG',
                        style: AppTypography.badge.copyWith(
                          color: const Color(0xFF84F5EF),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.group_rounded,
                      size: 15,
                      color: Colors.white.withValues(alpha: 0.80),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${overview.memberCount} người',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.80),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'VND (đ)',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.70),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Tổng chi tiêu toàn chuyến',
                  style: AppTypography.caption.copyWith(
                    color: Colors.white.withValues(alpha: 0.80),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: formatExpenseMoney(
                          summary.totalAmount,
                        ).replaceAll(' đ', ''),
                        style: AppTypography.display.copyWith(
                          color: AppColors.textInverse,
                          fontSize: 32,
                          height: 1.25,
                        ),
                      ),
                      TextSpan(
                        text: ' đ',
                        style: AppTypography.screenTitle.copyWith(
                          color: const Color(0xFF99F2EC),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _HeroStat(
                          label: 'Bạn đã chi',
                          value: formatExpenseMoney(summary.viewerPaidAmount),
                          valueColor: AppColors.textInverse,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _HeroStat(
                          label: netLabel,
                          value: formatSignedExpenseMoney(net),
                          valueColor: const Color(0xFF99F2EC),
                          trailing: Icon(
                            net >= 0
                                ? Icons.arrow_downward_rounded
                                : Icons.arrow_upward_rounded,
                            size: 12,
                            color: const Color(0xFF99F2EC),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _HeroAction(
                        label: 'Thêm khoản chi',
                        icon: Icons.add_circle_rounded,
                        filled: true,
                        onTap: onAddExpense,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _HeroAction(
                        label: 'Quyết toán nợ',
                        icon: Icons.handshake_rounded,
                        filled: false,
                        onTap: onSettleDebts,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorRing extends StatelessWidget {
  const _DecorRing({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: opacity)),
        color: Colors.white.withValues(alpha: 0.05),
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.label,
    required this.value,
    required this.valueColor,
    this.trailing,
  });

  final String label;
  final String value;
  final Color valueColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.70),
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.cardTitle.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 4),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF99F2EC).withValues(alpha: 0.20),
                ),
                alignment: Alignment.center,
                child: trailing,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _HeroAction extends StatelessWidget {
  const _HeroAction({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: filled
              ? AppColors.surface
              : Colors.white.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: filled
              ? null
              : Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: filled ? AppColors.primaryActive : AppColors.textInverse,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                maxLines: 1,
                softWrap: false,
                style: AppTypography.bodyMedium.copyWith(
                  color: filled
                      ? AppColors.primaryActive
                      : AppColors.textInverse,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
