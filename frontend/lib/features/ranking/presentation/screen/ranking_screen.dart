import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';

import '../../application/ranking_controller.dart';
import '../../application/ranking_view.dart';
import '../../data/models/ranking_models.dart';
import '../widgets/ranking_list_tile.dart';
import '../widgets/ranking_me_card.dart';
import '../widgets/ranking_period_filter.dart';
import '../widgets/ranking_podium.dart';
import '../widgets/ranking_quest_tile.dart';
import '../widgets/ranking_skeleton.dart';
import '../widgets/ranking_top_bar.dart';

class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rankingControllerProvider);

    ref.listen(rankingControllerProvider, (previous, next) {
      final error = next.asData?.value.actionError;
      if (error == null) return;
      if (previous?.asData?.value.actionError == error) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(rankingFailureMessage(error))));
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          child: Column(
            children: [
              RankingTopBar(
                seasonLabel:
                    state.asData?.value.page.seasonLabel ?? 'Bảng xếp hạng',
                onBack: () => _back(context),
                onHelpTap: () => _comingSoon(context, 'Thể lệ giải đấu'),
              ),
              Expanded(child: _body(context, ref, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<RankingViewState> state,
  ) {
    if (!state.hasValue && state.isLoading) {
      return const RankingSkeleton();
    }
    if (state.hasError && !state.hasValue) {
      final unauthorized = rankingFailureIsUnauthorized(state.error!);
      return AppErrorView(
        title: unauthorized
            ? 'Phiên đăng nhập đã hết hạn'
            : 'Không tải được bảng xếp hạng',
        message: rankingFailureMessage(state.error!),
        actionLabel: 'Thử lại',
        onRetry: unauthorized
            ? null
            : () => ref.read(rankingControllerProvider.notifier).refresh(),
      );
    }

    final view = state.requireValue;
    final me = view.me;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(rankingControllerProvider.notifier).refresh();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.xs,
          AppSpacing.screenHorizontal,
          AppSpacing.safeBottom,
        ),
        children: [
          if (view.page.periods.isNotEmpty) ...[
            RankingPeriodFilter(
              periods: view.page.periods,
              selected: view.period,
              onChanged: (period) {
                ref.read(rankingControllerProvider.notifier).setPeriod(period);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          RankingPodiumSection(
            travelers: view.podiumOrdered,
            updatedLabel: view.page.updatedLabel,
          ),
          if (me != null) ...[
            const SizedBox(height: AppSpacing.lg),
            RankingMeCardWidget(
              me: me,
              progress: view.meProgress,
              onHowToEarnTap: () => _comingSoon(context, 'Cách tích điểm'),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle(
            icon: Icons.leaderboard_rounded,
            title: 'Danh Sách Xếp Hạng',
            trailing: view.page.listRangeLabel,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (view.listEntries.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: AppEmptyView(
                title: 'Chưa có xếp hạng',
                description: 'Hoàn thành chuyến đi để ghi điểm vào bảng xếp hạng.',
              ),
            )
          else
            ...view.listEntries.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: RankingListTile(traveler: item),
              ),
            ),
          if (view.page.quests.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            _SectionTitle(
              icon: Icons.stars_rounded,
              iconColor: AppColors.warning,
              title: 'Nhiệm Vụ Kiếm Điểm',
              trailingAction: Text(
                'Xem tất cả (${view.page.questsTotal})',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...view.page.quests.map(
              (quest) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RankingQuestTile(
                  quest: quest,
                  busy: view.busyQuestId == quest.id,
                  onAction: () => _onQuest(context, ref, quest),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _onQuest(
    BuildContext context,
    WidgetRef ref,
    RankingQuest quest,
  ) async {
    if (quest.claimable) {
      final ok = await ref
          .read(rankingControllerProvider.notifier)
          .claimQuest(quest.id);
      if (ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã nhận +${quest.pointsReward} pts')),
        );
      }
      return;
    }
    if (quest.claimed) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nhiệm vụ đã nhận thưởng')));
      return;
    }
    switch (quest.action) {
      case RankingQuestAction.start:
        context.goNamed(RouteNames.createTrip);
      case RankingQuestAction.continueAction:
        context.goNamed(RouteNames.home);
      case RankingQuestAction.write:
        context.goNamed(RouteNames.social);
    }
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.trips);
  }

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$feature sắp có')));
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.trailing,
    this.trailingAction,
    this.iconColor = AppColors.primary,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final Widget? trailingAction;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: AppTypography.sectionTitle.copyWith(fontSize: 18),
          ),
        ),
        if (trailingAction != null)
          trailingAction!
        else if (trailing != null)
          Text(
            trailing!,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
