import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/trip_detail_feedback.dart';

import '../../application/trip_expenses_action_controller.dart';
import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

Future<bool> confirmTripExpenseSettle(
  BuildContext context,
  TripExpensesSettlement settlement, {
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(settlementConfirmTitle(settlement)),
      content: Text(settlementConfirmMessage(settlement, currency: currency)),
      actions: [
        TextButton(onPressed: () => ctx.pop(false), child: const Text('Hủy')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () => ctx.pop(true),
          child: Text(settlementConfirmPrimaryLabel(settlement)),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// Confirms then calls `settleSplit`. Returns true when settled successfully.
Future<bool> settleTripExpenseSettlement({
  required BuildContext context,
  required WidgetRef ref,
  required String tripId,
  required TripExpensesSettlement settlement,
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) async {
  if (!canViewerSettleSettlement(settlement)) return false;
  final expenseId = settlement.expenseId;
  final splitId = settlement.splitId;
  if (expenseId == null ||
      expenseId.isEmpty ||
      splitId == null ||
      splitId.isEmpty) {
    showTripDetailMessage(context, 'Không tìm thấy khoản chia để tất toán.');
    return false;
  }

  final confirmed = await confirmTripExpenseSettle(
    context,
    settlement,
    currency: currency,
  );
  if (!confirmed || !context.mounted) return false;

  try {
    await ref
        .read(tripExpensesActionControllerProvider(tripId).notifier)
        .settleSplit(expenseId: expenseId, splitId: splitId);
    if (context.mounted) {
      showTripDetailMessage(context, 'Đã ghi nhận tất toán');
    }
    return true;
  } catch (error) {
    if (context.mounted) {
      showTripDetailMessage(context, tripExpensesActionErrorMessage(error));
    }
    return false;
  }
}
