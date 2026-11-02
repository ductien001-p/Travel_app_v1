import '../data/models/travel_dna_models.dart';

const travelDnaRadarAxisLimit = 6;
const travelDnaCompanionPreviewLimit = 3;
const travelDnaPotentialScore = 60;
const travelDnaJourneyEyebrow = 'Gợi ý theo Travel DNA';

const _tripDnaTypes = {
  'SOLO_TRAVELER',
  'FAMILY_TRAVELER',
  'COUPLE_TRAVELLER',
  'GROUP_TRAVELER',
  'BACKPACKER',
};

class TravelDnaIdentityInput {
  const TravelDnaIdentityInput({
    required this.displayName,
    required this.initials,
    this.avatarUrl,
    this.verified = false,
    this.rankChip,
  });

  final String displayName;
  final String initials;
  final String? avatarUrl;
  final bool verified;
  final String? rankChip;
}

class TravelDnaRadarView {
  const TravelDnaRadarView({
    required this.identity,
    required this.stats,
    required this.chartTitle,
    required this.radarAxes,
    required this.details,
    required this.updatedLabel,
    required this.journey,
    required this.companions,
  });

  final TravelDnaIdentityView identity;
  final TravelDnaStatsView stats;
  final String chartTitle;
  final List<TravelDnaAxisView> radarAxes;
  final List<TravelDnaAxisView> details;
  final String updatedLabel;
  final TravelDnaJourneyView? journey;
  final List<TravelDnaCompanionView> companions;

  bool get hasDna => details.isNotEmpty;

  List<TravelDnaCompanionView> get companionPreview =>
      companions.take(travelDnaCompanionPreviewLimit).toList(growable: false);
}

class TravelDnaIdentityView {
  const TravelDnaIdentityView({
    required this.displayName,
    required this.initials,
    required this.personaTitle,
    required this.summary,
    this.avatarUrl,
    this.verified = false,
    this.rankChip,
    this.spotlight,
  });

  final String displayName;
  final String initials;
  final String? avatarUrl;
  final bool verified;
  final String? rankChip;
  final String personaTitle;
  final String? spotlight;
  final String summary;
}

class TravelDnaStatsView {
  const TravelDnaStatsView({
    required this.tripsAnalyzed,
    required this.checkIns,
    required this.portraitMatch,
  });

  final int tripsAnalyzed;
  final int checkIns;
  final int portraitMatch;
}

class TravelDnaAxisView {
  const TravelDnaAxisView({
    required this.type,
    required this.icon,
    required this.shortLabel,
    required this.title,
    required this.badgeLabel,
    required this.score,
    required this.communityScore,
    required this.evidence,
    required this.dominant,
    required this.potential,
    this.fitLabel,
  });

  final String type;
  final String icon;
  final String shortLabel;
  final String title;
  final String badgeLabel;
  final int score;
  final int communityScore;
  final String evidence;
  final String? fitLabel;
  final bool dominant;
  final bool potential;
}

class TravelDnaJourneyView {
  const TravelDnaJourneyView({
    required this.tripId,
    required this.matchPercent,
    required this.eyebrow,
    required this.title,
    required this.durationLabel,
    required this.highlightLabel,
    this.coverImageUrl,
  });

  final String tripId;
  final int matchPercent;
  final String eyebrow;
  final String title;
  final String durationLabel;
  final String highlightLabel;
  final String? coverImageUrl;
}

class TravelDnaCompanionView {
  const TravelDnaCompanionView({
    required this.userId,
    required this.name,
    required this.handle,
    required this.note,
    required this.matchPercent,
    required this.fitLabel,
    required this.initials,
    this.avatarUrl,
  });

  final String userId;
  final String name;
  final String handle;
  final String note;
  final int matchPercent;
  final String fitLabel;
  final String initials;
  final String? avatarUrl;
}

TravelDnaRadarView buildTravelDnaRadarView({
  required TravelDnaRadar radar,
  required TravelDnaIdentityInput identity,
  DateTime? now,
}) {
  final dna = radar.dna;
  final ranked = List<TravelDnaBadge>.of(dna.all);
  final axes = ranked.map((badge) => _axis(badge, dna, radar)).toList();
  final radarAxes = axes.take(travelDnaRadarAxisLimit).toList(growable: false);
  final dominant = dna.dominant;
  final persona = dominant == null
      ? 'Chưa có chân dung'
      : '${dominant.name} ${dominant.icon}'.trim();

  return TravelDnaRadarView(
    identity: TravelDnaIdentityView(
      displayName: identity.displayName,
      initials: identity.initials,
      avatarUrl: identity.avatarUrl,
      verified: identity.verified,
      rankChip: identity.rankChip,
      personaTitle: persona,
      spotlight: dominant == null
          ? null
          : travelDnaSpotlight(
              dominantPercentile: radar.dominantPercentile,
              shortLabel: _shortLabel(dominant),
            ),
      summary: _summary(dominant),
    ),
    stats: TravelDnaStatsView(
      tripsAnalyzed: _tripsAnalyzed(ranked),
      checkIns: _checkIns(ranked),
      portraitMatch: _portraitMatch(dominant),
    ),
    chartTitle: radarAxes.length == travelDnaRadarAxisLimit
        ? 'Radar 6 Chiều Bản Sắc'
        : 'Radar ${radarAxes.length} Chiều Bản Sắc',
    radarAxes: radarAxes,
    details: axes,
    updatedLabel: travelDnaUpdatedLabel(
      _latestUpdate(ranked),
      now ?? DateTime.now(),
    ),
    journey: _journey(radar.journey),
    companions: travelDnaCompanionViews(radar.companions),
  );
}

List<TravelDnaCompanionView> travelDnaCompanionViews(
  List<TravelDnaCompanion> companions,
) {
  return [for (final companion in companions) _companion(companion)];
}

String travelDnaFitLabel(int matchPercent) {
  if (matchPercent >= 90) return 'Cực kỳ hợp';
  if (matchPercent >= 80) return 'Rất ăn ý';
  return 'Khá ổn';
}

String? travelDnaSpotlight({
  required int? dominantPercentile,
  required String shortLabel,
}) {
  if (dominantPercentile == null) return null;
  final below = dominantPercentile.clamp(0, 100);
  final top = (100 - below).clamp(1, 100);
  return 'Top $top% $shortLabel';
}

String travelDnaJourneyDuration(String startDate, String endDate) {
  final start = _isoDay(startDate);
  final end = _isoDay(endDate);
  if (start == null || end == null) return '';
  final nights = end.difference(start).inDays;
  if (nights < 0) return '';
  return '${nights + 1} Ngày $nights Đêm';
}

String travelDnaShareMessage(TravelDnaRadarView view) {
  final buffer = StringBuffer('Travel DNA của ${view.identity.displayName}');
  buffer.writeln();
  buffer.writeln(view.identity.personaTitle);
  for (final axis in view.radarAxes) {
    buffer.writeln('${axis.shortLabel}: ${axis.score}/100');
  }
  return buffer.toString().trimRight();
}

String travelDnaRankChip({required String rank, required int totalPoints}) {
  final name = switch (rank) {
    'BEGINNER' => 'Hạng Mới',
    'EXPLORER' => 'Hạng Khám phá',
    'ADVENTURER' => 'Hạng Thám hiểm',
    'TRAVELER' => 'Hạng Lữ khách',
    'LEGEND' => 'Hạng Huyền thoại',
    _ => rank,
  };
  return '$name • ${_grouped(totalPoints)} pts';
}

String travelDnaUpdatedLabel(DateTime? updatedAt, DateTime now) {
  if (updatedAt == null) return 'Chưa có lần cập nhật';
  final days = now.difference(updatedAt).inDays;
  if (days <= 0) return 'Cập nhật hôm nay';
  if (days == 1) return 'Cập nhật 1 ngày trước';
  return 'Cập nhật $days ngày trước';
}

TravelDnaAxisView _axis(
  TravelDnaBadge badge,
  TravelDnaSnapshot dna,
  TravelDnaRadar radar,
) {
  final potential = badge.score < travelDnaPotentialScore;
  final dominant = dna.dominant?.type == badge.type;
  final shortLabel = _shortLabel(badge);
  final places = _placeNames(radar, badge.type);
  return TravelDnaAxisView(
    type: badge.type,
    icon: badge.icon,
    shortLabel: shortLabel,
    title: '$shortLabel (${badge.name})',
    badgeLabel: potential ? badge.badgeTitle : 'Huy hiệu: ${badge.badgeTitle}',
    score: badge.score,
    communityScore: _communityScore(radar, badge.type),
    evidence: _evidence(badge),
    fitLabel: places.isEmpty
        ? null
        : potential
        ? 'Gợi ý: $places'
        : 'Hợp: $places',
    dominant: dominant,
    potential: potential,
  );
}

TravelDnaJourneyView? _journey(TravelDnaJourney? journey) {
  if (journey == null) return null;
  final cover = journey.coverImageUrl?.trim();
  return TravelDnaJourneyView(
    tripId: journey.tripId,
    matchPercent: journey.matchPercent,
    eyebrow: travelDnaJourneyEyebrow,
    title: journey.name,
    durationLabel: travelDnaJourneyDuration(journey.startDate, journey.endDate),
    highlightLabel: '${journey.activityCount} hoạt động',
    coverImageUrl: cover == null || cover.isEmpty ? null : cover,
  );
}

TravelDnaCompanionView _companion(TravelDnaCompanion companion) {
  final name = companion.displayName.trim().isEmpty
      ? companion.username
      : companion.displayName.trim();
  final avatar = companion.avatarUrl?.trim();
  return TravelDnaCompanionView(
    userId: companion.userId,
    name: name,
    handle: '@${companion.username}',
    note: '${companion.persona.icon} ${companion.persona.name}'.trim(),
    matchPercent: companion.matchPercent,
    fitLabel: travelDnaFitLabel(companion.matchPercent),
    initials: _initials(name),
    avatarUrl: avatar == null || avatar.isEmpty ? null : avatar,
  );
}

String _shortLabel(TravelDnaBadge badge) {
  final label = badge.shortLabel.trim();
  return label.isEmpty ? badge.name : label;
}

String _summary(TravelDnaBadge? dominant) {
  final description = dominant?.description.trim();
  if (description != null && description.isNotEmpty) return description;
  return 'Check-in trong chuyến đi để bắt đầu chân dung.';
}

int _tripsAnalyzed(List<TravelDnaBadge> badges) {
  var total = 0;
  for (final badge in badges) {
    if (_tripDnaTypes.contains(badge.type)) total += badge.tripTypeCount;
  }
  return total;
}

int _checkIns(List<TravelDnaBadge> badges) {
  var total = 0;
  for (final badge in badges) {
    total += badge.activityCount;
  }
  return total;
}

int _portraitMatch(TravelDnaBadge? dominant) {
  final score = dominant?.score ?? 0;
  if (score < 0) return 0;
  if (score > 100) return 100;
  return score;
}

int _communityScore(TravelDnaRadar radar, String type) {
  for (final score in radar.community) {
    if (score.type == type) return score.averageScore;
  }
  return 0;
}

String _placeNames(TravelDnaRadar radar, String type) {
  for (final axis in radar.fitPlaces) {
    if (axis.type != type) continue;
    return [
      for (final place in axis.places)
        if (place.name.trim().isNotEmpty) place.name.trim(),
    ].join(', ');
  }
  return '';
}

String _evidence(TravelDnaBadge badge) {
  if (badge.activityCount == 0 && badge.tripTypeCount == 0) {
    return badge.description;
  }
  final count = badge.activityCount > 0
      ? badge.activityCount
      : badge.tripTypeCount;
  final label = switch (badge.type) {
    'FOODIE_TRAVELER' => '$count điểm ẩm thực check-in',
    'CULTURE_TRAVELER' => '$count điểm văn hóa đã khám phá',
    'PHOTOGRAPHY_LOVER' => '$count dấu ấn nhiếp ảnh',
    'BEACH_LOVER' => '$count điểm biển đã ghé',
    'ADVENTURE_TRAVELER' => '$count chặng phiêu lưu',
    'MOUNTAIN_LOVER' => '$count điểm núi đã chinh phục',
    'BACKPACKER' => '$count chuyến phượt',
    'SOLO_TRAVELER' => '$count chuyến một mình',
    'FAMILY_TRAVELER' => '$count chuyến gia đình',
    'COUPLE_TRAVELLER' => '$count chuyến cặp đôi',
    'GROUP_TRAVELER' => '$count chuyến nhóm',
    'ENTERTAINMENT_TRAVELLER' => '$count điểm giải trí',
    _ => badge.activityCount > 0 ? '$count hoạt động' : '$count chuyến đi',
  };
  return '${badge.icon} $label';
}

DateTime? _latestUpdate(List<TravelDnaBadge> badges) {
  DateTime? latest;
  for (final badge in badges) {
    final parsed = DateTime.tryParse(badge.updatedAt)?.toUtc();
    if (parsed == null) continue;
    if (latest == null || parsed.isAfter(latest)) latest = parsed;
  }
  return latest;
}

DateTime? _isoDay(String value) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})').firstMatch(value);
  if (match == null) return null;
  return DateTime.utc(
    int.parse(match.group(1)!),
    int.parse(match.group(2)!),
    int.parse(match.group(3)!),
  );
}

String _initials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList(growable: false);
  if (parts.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}

String _grouped(int value) {
  final negative = value < 0;
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    final remaining = digits.length - index;
    if (index > 0 && remaining % 3 == 0) buffer.write('.');
    buffer.write(digits[index]);
  }
  return negative ? '-${buffer.toString()}' : buffer.toString();
}
