import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_response_parser.dart';

import '../models/ranking_models.dart';

abstract class RankingDataSource {
  Future<RankingPage> getPage(RankingPeriod period);

  Future<RankingQuest> claimQuest(String questId);
}

class RankingRemoteDataSource implements RankingDataSource {
  const RankingRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<RankingPage> getPage(RankingPeriod period) async {
    final periodQuery = _periodQuery(period);

    final leaderboardBody = await _apiClient.get<Map<String, dynamic>>(
      '/ranking/leaderboard',
      queryParameters: <String, dynamic>{
        'page': 1,
        'limit': 20,
        'period': periodQuery,
      },
    );

    RankingMeCard? me;
    try {
      final meBody = await _apiClient.get<Map<String, dynamic>>(
        '/ranking/me',
        queryParameters: <String, dynamic>{'period': periodQuery},
      );
      me = _mapMe(ApiResponseParser.dataMap(meBody));
    } catch (_) {
      me = null;
    }

    List<RankingQuest> quests = const [];
    var questsTotal = 0;
    try {
      final questsBody = await _apiClient.get<Map<String, dynamic>>(
        '/ranking/quests',
      );
      final raw = questsBody['data'];
      if (raw is List) {
        quests = raw
            .whereType<Map>()
            .map((row) => _mapQuest(Map<String, dynamic>.from(row)))
            .toList(growable: false);
      }
      questsTotal =
          _asInt(questsBody['questsTotal']) ?? quests.length;
    } catch (_) {
      quests = const [];
    }

    final entriesRaw = leaderboardBody['data'];
    final entries = entriesRaw is List
        ? entriesRaw
              .whereType<Map>()
              .map((row) => Map<String, dynamic>.from(row))
              .map(_mapTraveler)
              .toList(growable: false)
        : const <RankingTraveler>[];

    final seasonLabel =
        leaderboardBody['seasonLabel']?.toString() ??
        me?.tierLabel ??
        'Bảng xếp hạng';
    final snapshotAt = _parseDate(leaderboardBody['snapshotAt']);
    final podium = entries.where((e) => e.rank >= 1 && e.rank <= 3).toList();
    final list = entries.where((e) => e.rank >= 4).toList();
    final listLabel = list.isEmpty
        ? 'Chưa có xếp hạng mở rộng'
        : 'Hiển thị Top ${list.first.rank} - ${list.last.rank}';

    final monthLabel = 'Tháng ${DateTime.now().month}';

    return RankingPage(
      seasonLabel: period == RankingPeriod.season
          ? (leaderboardBody['seasonLabel']?.toString() ?? seasonLabel)
          : _seasonSubtitle(period, leaderboardBody['seasonLabel']?.toString()),
      updatedLabel: snapshotAt == null
          ? 'Cập nhật vừa xong'
          : 'Cập nhật ${_relativeOrDate(snapshotAt)}',
      listRangeLabel: listLabel,
      questsTotal: questsTotal,
      selectedPeriod: period,
      periods: [
        const RankingPeriodOption(id: RankingPeriod.week, label: 'Tuần Này'),
        RankingPeriodOption(id: RankingPeriod.month, label: monthLabel),
        RankingPeriodOption(
          id: RankingPeriod.season,
          label: leaderboardBody['seasonLabel']?.toString() ?? 'Mùa giải',
        ),
        const RankingPeriodOption(
          id: RankingPeriod.allTime,
          label: 'Mọi thời đại',
        ),
      ],
      podium: podium,
      me: me,
      entries: list,
      quests: quests,
    );
  }

  @override
  Future<RankingQuest> claimQuest(String questId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/ranking/quests/${Uri.encodeComponent(questId)}/claim',
    );
    return _mapQuest(ApiResponseParser.dataMap(response));
  }

  String _seasonSubtitle(RankingPeriod period, String? seasonLabel) {
    return switch (period) {
      RankingPeriod.week => 'Tuần này',
      RankingPeriod.month => 'Tháng ${DateTime.now().month}',
      RankingPeriod.season => seasonLabel ?? 'Mùa giải',
      RankingPeriod.allTime => 'Mọi thời đại',
    };
  }

  RankingTraveler _mapTraveler(Map<String, dynamic> raw) {
    final ranking = _asInt(raw['ranking']);
    return RankingTraveler(
      userId: raw['userId']?.toString() ?? '',
      rank: ranking ?? 0,
      displayName:
          raw['displayName']?.toString().trim().isNotEmpty == true
          ? raw['displayName'].toString().trim()
          : (raw['username']?.toString() ?? 'Người dùng'),
      username: raw['username']?.toString() ?? '',
      avatarUrl: raw['avatarUrl']?.toString(),
      badgeLabel: raw['badgeLabel']?.toString(),
      badgeIcon: raw['badgeIcon']?.toString(),
      points: _asInt(raw['totalPoints']) ?? 0,
      tripsCompleted: _asInt(raw['totalTripsCompleted']) ?? 0,
      tier: raw['rank']?.toString(),
      verified: raw['isVerified'] == true,
      highlight: (ranking ?? 0) <= 5,
    );
  }

  RankingMeCard _mapMe(Map<String, dynamic> raw) {
    final ranking = _asInt(raw['ranking']);
    final points = _asInt(raw['totalPoints']) ?? 0;
    final nextPoints = _asInt(raw['nextRankPoints']) ?? points;
    final tier = raw['rank']?.toString();

    return RankingMeCard(
      userId: raw['userId']?.toString() ?? '',
      rank: ranking ?? 0,
      displayName:
          raw['displayName']?.toString().trim().isNotEmpty == true
          ? raw['displayName'].toString().trim()
          : (raw['username']?.toString() ?? 'Bạn'),
      username: raw['username']?.toString() ?? '',
      avatarUrl: raw['avatarUrl']?.toString(),
      verified: raw['isVerified'] == true,
      tierLabel: rankingTierLabel(tier),
      rankDelta: _asInt(raw['rankDelta']) ?? 0,
      points: points,
      tripsCompleted: _asInt(raw['totalTripsCompleted']) ?? 0,
      nextTierLabel: raw['nextTierLabel']?.toString() ?? 'Top 10',
      nextTierPoints: nextPoints,
      progressHint: raw['progressHint']?.toString() ?? '',
    );
  }

  RankingQuest _mapQuest(Map<String, dynamic> raw) {
    final actionRaw = raw['action']?.toString() ?? 'START';
    final toneRaw = raw['tone']?.toString() ?? 'PRIMARY';
    return RankingQuest(
      id: raw['id']?.toString() ?? '',
      code: raw['code']?.toString() ?? '',
      title: raw['title']?.toString() ?? '',
      subtitle: raw['subtitle']?.toString() ?? '',
      icon: raw['icon']?.toString() ?? 'stars',
      pointsReward: _asInt(raw['pointsReward']) ?? 0,
      action: switch (actionRaw) {
        'CONTINUE' => RankingQuestAction.continueAction,
        'WRITE' => RankingQuestAction.write,
        _ => RankingQuestAction.start,
      },
      tone: switch (toneRaw) {
        'SECONDARY' => RankingQuestTone.secondary,
        'TERTIARY' => RankingQuestTone.tertiary,
        _ => RankingQuestTone.primary,
      },
      progressCurrent: _asInt(raw['progressCurrent']),
      progressTarget: _asInt(raw['targetCount']),
      claimed: raw['claimed'] == true,
      claimable: raw['claimable'] == true,
    );
  }

  String _periodQuery(RankingPeriod period) => switch (period) {
    RankingPeriod.week => 'WEEK',
    RankingPeriod.month => 'MONTH',
    RankingPeriod.season => 'SEASON',
    RankingPeriod.allTime => 'ALL_TIME',
  };

  int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  DateTime? _parseDate(Object? value) {
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  String _relativeOrDate(DateTime date) {
    final local = date.toLocal();
    final diff = DateTime.now().difference(local);
    if (diff.inMinutes < 1) return 'vừa xong';
    if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
    if (diff.inHours < 24) return '${diff.inHours} giờ trước';
    if (diff.inDays < 7) return '${diff.inDays} ngày trước';
    return '${local.day}/${local.month}/${local.year}';
  }
}

String rankingTierLabel(String? rank) {
  return switch (rank) {
    'BEGINNER' => 'Beginner',
    'EXPLORER' => 'Explorer',
    'ADVENTURER' => 'Adventurer',
    'TRAVELER' => 'Traveler',
    'LEGEND' => 'Legend',
    _ => rank?.trim().isNotEmpty == true ? rank!.trim() : 'Explorer',
  };
}
