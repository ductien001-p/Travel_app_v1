import '../data/models/profile_showcase_models.dart';
import 'profile_count_format.dart';

bool profileShowsVerifiedBadge(String hostStatus) => hostStatus == 'APPROVED';

String profileRankLabel(ProfileShowcaseRanking ranking) {
  final rankName = switch (ranking.rank) {
    'BEGINNER' => 'Hạng Mới',
    'EXPLORER' => 'Hạng Khám phá',
    'ADVENTURER' => 'Hạng Thám hiểm',
    'TRAVELER' => 'Hạng Lữ khách',
    'LEGEND' => 'Hạng Huyền thoại',
    _ => ranking.rank,
  };
  final percentile = ranking.percentile;
  if (percentile == null) return rankName;
  return 'Top $percentile% • $rankName';
}

String profilePointsLabel(int totalPoints) =>
    '${formatProfileCount(totalPoints)} pts';

String profileTripStatusLabel(String status) => switch (status) {
  'ONGOING' => 'ĐANG DIỄN RA',
  'UPCOMING' => 'SẮP TỚI',
  'COMPLETED' => 'ĐÃ HOÀN THÀNH',
  'CANCELLED' => 'ĐÃ HỦY',
  'DRAFT' => 'BẢN NHÁP',
  'NOTCOMPLETED' => 'CHƯA HOÀN THÀNH',
  _ => status,
};

String profileBudgetLabel(String? budgetLevel) => switch (budgetLevel) {
  'LOW' => 'Tiết kiệm',
  'MEDIUM' => 'Vừa phải',
  'HIGH' => 'Cao cấp',
  _ => 'Chưa đặt ngân sách',
};

String profileTripDateLabel(String startIso, String endIso) {
  final start = DateTime.parse(startIso).toUtc();
  final end = DateTime.parse(endIso).toUtc();
  final startLabel = '${_two(start.day)}/${_two(start.month)}';
  return '$startLabel - ${_two(end.day)}/${_two(end.month)}/${end.year}';
}

String profileTripMonthLabel(String startIso) {
  final start = DateTime.parse(startIso).toUtc();
  final year = (start.year % 100).toString().padLeft(2, '0');
  return 'T${start.month}/$year';
}

int profileTripNights(String startIso, String endIso) {
  final start = DateTime.parse(startIso).toUtc();
  final end = DateTime.parse(endIso).toUtc();
  final startDay = DateTime.utc(start.year, start.month, start.day);
  final endDay = DateTime.utc(end.year, end.month, end.day);
  final nights = endDay.difference(startDay).inDays;
  return nights < 0 ? 0 : nights;
}

String profileOngoingDurationLabel(String startIso, String endIso) {
  final nights = profileTripNights(startIso, endIso);
  if (nights == 0) return 'Hành trình 1 ngày';
  return 'Hành trình ${nights + 1} ngày $nights đêm';
}

String profileUpcomingDurationLabel(String startIso, String endIso) {
  final nights = profileTripNights(startIso, endIso);
  final days = nights == 0 ? 1 : nights + 1;
  return '$days ngày';
}

String profileTripHighlight(List<String> highlights) => highlights
    .map((item) => item.trim())
    .where((item) => item.isNotEmpty)
    .take(3)
    .join(' • ');

String profileDnaCaption(ProfileTravelDnaBadge badge) {
  if (badge.activityCount > 0) {
    return '${badge.activityCount} điểm đã check-in';
  }
  return badge.description;
}

List<ProfileTravelDnaBadge> profileSupportingTraits(ProfileTravelDna dna) {
  final dominantType = dna.dominant?.type;
  return dna.all
      .where((item) => item.type != dominantType)
      .take(3)
      .toList(growable: false);
}

int profileMemoryExtraCount(ProfileShowcaseMemories memories) {
  final extra = memories.totalCount - memories.items.length;
  return extra < 0 ? 0 : extra;
}

String profileSavedPlaceSubtitle(ProfileShowcaseSavedPlace place) =>
    'Điểm đến • ${place.city}';

String _two(int value) => value.toString().padLeft(2, '0');
