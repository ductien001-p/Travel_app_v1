import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/ranking_models.dart';
import '../provider/ranking_provider.dart';
import 'ranking_view.dart';

/// No automatic retry: 401 never recovers; screen retries manually.
final rankingControllerProvider =
    AsyncNotifierProvider.autoDispose<RankingController, RankingViewState>(
      RankingController.new,
      retry: (_, _) => null,
    );

class RankingController extends AsyncNotifier<RankingViewState> {
  @override
  Future<RankingViewState> build() => _load(RankingPeriod.season);

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    final period = previous?.period ?? RankingPeriod.season;
    if (previous == null) {
      state = const AsyncLoading<RankingViewState>();
    }
    state = await AsyncValue.guard(() => _load(period));
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  Future<bool> setPeriod(RankingPeriod period) async {
    final current = state.asData?.value;
    if (current == null || current.period == period) return true;

    final optimistic = current.copyWith(period: period, clearActionError: true);
    state = AsyncData(optimistic);
    final result = await AsyncValue.guard(() => _load(period));
    if (result.hasError) {
      state = AsyncData(optimistic.copyWith(actionError: result.error));
      return false;
    }
    state = result;
    return true;
  }

  Future<bool> claimQuest(String questId) async {
    final current = state.asData?.value;
    if (current == null || current.busyQuestId != null) return false;

    state = AsyncData(
      current.copyWith(busyQuestId: questId, clearActionError: true),
    );
    try {
      final updated = await ref
          .read(rankingRepositoryProvider)
          .claimQuest(questId);
      final latest = state.asData?.value ?? current;
      final nextQuests = latest.page.quests
          .map((quest) => quest.id == questId ? updated : quest)
          .toList(growable: false);
      state = AsyncData(
        latest.copyWith(
          page: latest.page.copyWith(quests: nextQuests),
          clearBusyQuest: true,
          clearActionError: true,
        ),
      );
      await refresh();
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyQuest: true, actionError: error),
      );
      return false;
    }
  }

  Future<RankingViewState> _load(RankingPeriod period) async {
    final page = await ref.read(rankingRepositoryProvider).getPage(period);
    return RankingViewState(page: page, period: page.selectedPeriod);
  }
}
