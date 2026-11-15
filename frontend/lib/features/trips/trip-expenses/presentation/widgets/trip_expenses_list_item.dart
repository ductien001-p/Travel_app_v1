import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

void showTripExpenseReceipts(
  BuildContext context,
  List<TripExpenseReceipt> receipts,
) {
  final urls = [
    for (final receipt in receipts)
      if (receipt.url.trim().isNotEmpty) receipt.url,
  ];
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Hóa đơn'),
      content: SizedBox(
        width: 320,
        child: urls.isEmpty
            ? const Text('Hóa đơn chưa có đường dẫn ảnh.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final url in urls) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.image),
                      child: Image.network(
                        url,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const SizedBox(
                          height: 120,
                          child: Center(child: Text('Không tải được hóa đơn.')),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Đóng'),
        ),
      ],
    ),
  );
}

class TripExpensesListItem extends StatelessWidget {
  const TripExpensesListItem({super.key, required this.entry, this.now});

  final TripExpensesEntry entry;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final color = expenseCategoryColor(entry.category);
    final amount = num.tryParse(entry.amount) ?? 0;
    final statusColor = expenseSettleStatusColor(entry.status);

    return AppCard(
      radius: 22,
      color: AppColors.glass85,
      borderColor: AppColors.glassBorder,
      shadows: AppShadows.level1,
      padding: const EdgeInsets.all(AppSpacing.cardCompact),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.image),
                ),
                alignment: Alignment.center,
                child: Icon(
                  expenseCategoryIcon(entry.category),
                  size: 24,
                  color: color,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.description ?? 'Khoản chi',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle,
                    ),
                    const SizedBox(height: 2),
                    Text.rich(
                      TextSpan(
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Người trả: '),
                          TextSpan(
                            text: expensePayerLabel(entry),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: entry.payerIsViewer
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
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
                    formatExpenseMoney(amount, currency: entry.currency),
                    style: AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    formatExpenseWhen(entry.spentAt, now: now),
                    style: AppTypography.caption.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.borderNeutral),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubdued,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  expenseSplitTypeLabel(entry.splitType),
                  style: AppTypography.badge.copyWith(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              if (entry.receipts.isNotEmpty) ...[
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => showTripExpenseReceipts(context, entry.receipts),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.receipt_long_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  entry.splitNote ?? '${entry.splitCount} người',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Icon(
                expenseSettleStatusIcon(entry.status),
                size: 16,
                color: statusColor,
              ),
              const SizedBox(width: 4),
              Text(
                expenseSettleStatusLabel(entry),
                style: AppTypography.caption.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
