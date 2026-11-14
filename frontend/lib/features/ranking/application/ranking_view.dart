import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/ranking_models.dart';

class RankingViewState {
  const RankingViewState({
    required this.page,
    this.period = RankingPeriod.allTime,
    this.busyQuestId,
    this.actionError,
  });

  final RankingPage page;
  final RankingPeriod period;
  final String? busyQuestId;
  final Object? actionError;

  List<RankingTraveler> get podiumOrdered {
    final byRank = [...page.podium]..sort((a, b) => a.rank.compareTo(b.rank));
    if (byRank.length < 3) return byRank;
    // Stitch podium: #2 | #1 | #3
    final first = byRank.firstWhere(
      (item) => item.rank == 1,
      orElse: () => byRank.first,
    );
    final second = byRank.firstWhere(
      (item) => item.rank == 2,
      orElse: () => byRank[1],
    );
    final third = byRank.firstWhere(
      (item) => item.rank == 3,
      orElse: () => byRank[2],
    );
    return [second, first, third];
  }

  List<RankingTraveler> get listEntries => page.entries;

  RankingMeCard? get me => page.me;

  double get meProgress {
    final card = page.me;
    if (card == null || card.nextTierPoints <= 0) return 0;
    return (card.points / card.nextTierPoints).clamp(0.0, 1.0);
  }

  RankingViewState copyWith({
    RankingPage? page,
    RankingPeriod? period,
    String? busyQuestId,
    bool clearBusyQuest = false,
    Object? actionError,
    bool clearActionError = false,
  }) => RankingViewState(
    page: page ?? this.page,
    period: period ?? this.period,
    busyQuestId: clearBusyQuest ? null : busyQuestId ?? this.busyQuestId,
    actionError: clearActionError ? null : actionError ?? this.actionError,
  );
}

String rankingPointsLabel(int points, {bool withUnit = false}) {
  final digits = points.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final reverseIndex = digits.length - i;
    buffer.write(digits[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write('.');
    }
  }
  final formatted = buffer.toString();
  if (!withUnit) return formatted;
  return '$formatted pts';
}

String rankingRankDeltaLabel(int delta) {
  if (delta > 0) return '+$delta bậc';
  if (delta < 0) return '$delta bậc';
  return 'Ổn định';
}

String rankingFailureMessage(Object error) {
  if (error is ApiException && error.statusCode == 401) {
    return 'Phiên đăng nhập đã hết hạn';
  }
  if (error is ApiException && error.message.trim().isNotEmpty) {
    return error.message.trim();
  }
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}

bool rankingFailureIsUnauthorized(Object error) =>
    error is ApiException && error.statusCode == 401;
