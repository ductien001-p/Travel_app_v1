import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';

import '../../application/trip_expenses_action_controller.dart';
import '../../application/trip_expenses_controller.dart';
import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';
import 'trip_expenses_settle_flow.dart';
import 'trip_expenses_settlement_section.dart';

Future<void> showTripExpensesDebtsSheet({
  required BuildContext context,
  required String tripId,
}) {
  return showAppBottomSheet<void>(
    context: context,
    child: _TripExpensesDebtsSheet(tripId: tripId),
  );
}

class _TripExpensesDebtsSheet extends ConsumerWidget {
  const _TripExpensesDebtsSheet({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overview = ref
        .watch(tripExpensesControllerProvider(tripId))
        .value
        ?.overview;
    final action = ref.watch(tripExpensesActionControllerProvider(tripId));
    final settlements = overview == null
        ? const <TripExpensesSettlement>[]
        : viewerRelatedSettlements(overview.settlements);
    final toReceive = settlements.where((s) => s.toIsViewer).toList();
    final toPay = settlements.where((s) => s.fromIsViewer).toList();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Công nợ của bạn', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Các khoản bạn đang nợ hoặc cần nhận lại.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (settlements.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: AppEmptyView(
                icon: Icons.handshake_outlined,
                title: 'Không còn khoản nào cần quyết toán với bạn',
                description:
                    'Mọi phần chia liên quan đến bạn đã được tất toán.',
              ),
            )
          else
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (toReceive.isNotEmpty) ...[
                    Text(
                      'Bạn cần nhận (${toReceive.length})',
                      style: AppTypography.cardTitle,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    for (final row in toReceive) ...[
                      TripExpensesSettlementRow(
                        settlement: row,
                        isBusy: action.isBusy,
                        onSettle: canViewerSettleSettlement(row)
                            ? () => settleTripExpenseSettlement(
                                context: context,
                                ref: ref,
                                tripId: tripId,
                                settlement: row,
                                currency:
                                    overview?.currency ??
                                    TripExpensesCurrency.vnd,
                              )
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  if (toPay.isNotEmpty) ...[
                    Text(
                      'Bạn cần trả (${toPay.length})',
                      style: AppTypography.cardTitle,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    for (final row in toPay) ...[
                      TripExpensesSettlementRow(
                        settlement: row,
                        isBusy: action.isBusy,
                        onSettle: canViewerSettleSettlement(row)
                            ? () => settleTripExpenseSettlement(
                                context: context,
                                ref: ref,
                                tripId: tripId,
                                settlement: row,
                                currency:
                                    overview?.currency ??
                                    TripExpensesCurrency.vnd,
                              )
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                    ],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
