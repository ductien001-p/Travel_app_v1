import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';

import '../../../trip-details/presentation/widgets/trip_detail_feedback.dart';
import '../../application/trip_expenses_action_controller.dart';
import '../../application/trip_expenses_controller.dart';
import '../../application/trip_expenses_filter.dart';
import '../../application/trip_expenses_view.dart';
import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';
import '../widgets/trip_expenses_bottom_bar.dart';
import '../widgets/trip_expenses_category_breakdown.dart';
import '../widgets/trip_expenses_debts_sheet.dart';
import '../widgets/trip_expenses_filter_bar.dart';
import '../widgets/trip_expenses_hero_card.dart';
import '../widgets/trip_expenses_list_item.dart';
import '../widgets/trip_expenses_settle_flow.dart';
import '../widgets/trip_expenses_settlement_section.dart';
import '../widgets/trip_expenses_skeleton.dart';
import '../widgets/trip_expenses_top_bar.dart';

class TripExpensesScreen extends ConsumerWidget {
  const TripExpensesScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncView = ref.watch(tripExpensesViewProvider(tripId));
    final view = asyncView.value;
    final action = ref.watch(tripExpensesActionControllerProvider(tripId));

    return AppScaffold(
      topBar: TripExpensesTopBar(
        onBack: () => _goBack(context),
        tripName: view?.overview.tripName,
        onSettings: view == null
            ? null
            : () => showTripDetailComingSoon(context),
      ),
      bottomNavigationBar: view == null
          ? null
          : TripExpensesBottomBar(
              onAddExpense: () => _openAddExpense(context),
              onSettle: () => _openDebts(context),
            ),
      body: switch (asyncView) {
        AsyncValue(:final value?) => _ExpensesContent(
          tripId: tripId,
          view: value,
          isBusy: action.isBusy,
          onRefresh: () => _refresh(context, ref),
          onSelectScope: (scope) => ref
              .read(tripExpensesFilterProvider(tripId).notifier)
              .selectScope(scope),
          onSelectCategory: (category) => ref
              .read(tripExpensesFilterProvider(tripId).notifier)
              .selectCategory(category),
          onAddExpense: () => _openAddExpense(context),
          onSettleDebts: () => _openDebts(context),
          onSettleSettlement: (settlement) => settleTripExpenseSettlement(
            context: context,
            ref: ref,
            tripId: tripId,
            settlement: settlement,
            currency: value.overview.currency,
          ),
        ),
        AsyncValue(:final error?) => _ExpensesError(
          error: error,
          onRetry: () => ref.invalidate(tripExpensesControllerProvider(tripId)),
          onBack: () => _goBack(context),
        ),
        _ => const TripExpensesSkeleton(),
      },
    );
  }

  void _openAddExpense(BuildContext context) {
    context.pushNamed(
      RouteNames.tripAddExpense,
      pathParameters: {'tripId': tripId},
    );
  }

  Future<void> _openDebts(BuildContext context) async {
    await showTripExpensesDebtsSheet(context: context, tripId: tripId);
  }

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(tripExpensesControllerProvider(tripId).notifier).refresh();
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripExpensesErrorMessage(error));
      }
    }
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(
        RouteNames.tripDetail,
        pathParameters: {'tripId': tripId},
      );
    }
  }
}

class _ExpensesContent extends StatelessWidget {
  const _ExpensesContent({
    required this.tripId,
    required this.view,
    required this.isBusy,
    required this.onRefresh,
    required this.onSelectScope,
    required this.onSelectCategory,
    required this.onAddExpense,
    required this.onSettleDebts,
    required this.onSettleSettlement,
  });

  final String tripId;
  final TripExpensesView view;
  final bool isBusy;
  final Future<void> Function() onRefresh;
  final ValueChanged<TripExpensesScope> onSelectScope;
  final ValueChanged<TripExpensesCategory?> onSelectCategory;
  final VoidCallback onAddExpense;
  final VoidCallback onSettleDebts;
  final ValueChanged<TripExpensesSettlement> onSettleSettlement;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          0,
          AppSpacing.screenHorizontal,
          AppSpacing.safeBottom,
        ),
        children: [
          TripExpensesHeroCard(
            overview: view.overview,
            onAddExpense: onAddExpense,
            onSettleDebts: onSettleDebts,
          ),
          const SizedBox(height: AppSpacing.md),
          if (view.overview.categories.isNotEmpty) ...[
            TripExpensesCategoryBreakdown(categories: view.overview.categories),
            const SizedBox(height: AppSpacing.md),
          ],
          TripExpensesSettlementSection(
            settlements: view.overview.settlements,
            isBusy: isBusy,
            onSettleSettlement: onSettleSettlement,
          ),
          if (view.overview.settlements.isNotEmpty)
            const SizedBox(height: AppSpacing.md),
          TripExpensesFilterBar(
            view: view,
            onSelectScope: onSelectScope,
            onSelectCategory: onSelectCategory,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text('Lịch sử chi tiêu', style: AppTypography.sectionTitle),
              const Spacer(),
              Text(
                '${view.expenses.length} giao dịch',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          switch (view.status) {
            TripExpensesBodyStatus.empty => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
              child: AppEmptyView(
                icon: Icons.receipt_long_outlined,
                title: 'Chưa có khoản chi nào',
                description:
                    'Thêm khoản chi đầu tiên để bắt đầu chia tiền nhóm.',
                actionLabel: 'Thêm khoản chi',
                onAction: onAddExpense,
              ),
            ),
            TripExpensesBodyStatus.filteredEmpty => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
              child: AppEmptyView(
                icon: Icons.filter_alt_outlined,
                title: 'Không có khoản chi phù hợp',
                description: 'Thử đổi bộ lọc hoặc xem tất cả chi tiêu.',
              ),
            ),
            TripExpensesBodyStatus.ready => Column(
              children: [
                for (var i = 0; i < view.expenses.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.sm),
                  TripExpensesListItem(entry: view.expenses[i]),
                ],
              ],
            ),
          },
        ],
      ),
    );
  }
}

class _ExpensesError extends StatelessWidget {
  const _ExpensesError({
    required this.error,
    required this.onRetry,
    required this.onBack,
  });

  final Object error;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    if (isTripExpensesForbidden(error)) {
      return AppErrorView(
        title: 'Không thể xem chi tiêu',
        message: tripExpensesErrorMessage(error),
        actionLabel: 'Quay lại',
        onRetry: onBack,
      );
    }
    return AppErrorView(
      title: 'Không thể tải chi tiêu',
      message: tripExpensesErrorMessage(error),
      actionLabel: 'Thử lại',
      onRetry: onRetry,
    );
  }
}
