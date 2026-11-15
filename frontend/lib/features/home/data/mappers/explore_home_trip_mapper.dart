import 'package:travel_frontend_v1/features/trips/data/models/trip_creation_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_enums.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';

import '../models/explore_home_models.dart';

/// Static chip set for Community Explore (labels stay client-owned).
const List<ExploreFilterChip> kExploreHomeFilters = [
  ExploreFilterChip(id: 'all', label: 'Tất cả chuyến đi'),
  ExploreFilterChip(id: 'backpacker', label: 'Phượt & Bụi (Backpacker)'),
  ExploreFilterChip(id: 'camping', label: 'Cắm trại & Trekking'),
  ExploreFilterChip(id: 'beach', label: 'Bãi biển & Hóng mát'),
  ExploreFilterChip(id: 'budget', label: 'Chi phí thấp'),
  ExploreFilterChip(id: 'weekend', label: 'Cuối tuần này'),
];

ExploreHomeFeed buildExploreHomeFeed({
  required List<TripListItem> trips,
  required String displayName,
  String? avatarUrl,
  String locationLabel = '',
  List<DestinationCatalogItem> catalog = const [],
  int page = 1,
  bool hasNextPage = false,
  bool catalogUnavailable = false,
  bool hasUnreadNotifications = false,
}) {
  final hotTrips = [
    for (final trip in trips) mapTripListItemToCommunityCard(trip),
  ];
  return ExploreHomeFeed(
    header: ExploreHomeHeader(
      displayName: displayName,
      avatarUrl: avatarUrl,
      locationLabel: locationLabel,
      hasUnreadNotifications: hasUnreadNotifications,
    ),
    filters: kExploreHomeFilters,
    hotTrips: hotTrips,
    destinations: exploreDestinations(trips: trips, catalog: catalog),
    liveTrips: const [],
    page: page,
    hasNextPage: hasNextPage,
    catalogUnavailable: catalogUnavailable,
  );
}

CommunityTripCard mapTripListItemToCommunityCard(TripListItem trip) {
  final owner = trip.owner;
  final nights = trip.endDate.difference(trip.startDate).inDays;
  final durationLabel = nights <= 0
      ? '1 Ngày'
      : '${nights + 1}N$nights'
            'Đ';
  final badges = <String>[
    if (trip.recruiting) 'Đang tuyển',
    _tripTypeBadge(trip.tripType),
  ];
  final tags = <String>{
    'all',
    if (trip.tripType == TripType.backpacker) 'backpacker',
    if (trip.budgetLevel == TripBudgetLevel.low) 'budget',
    if (_isThisWeekend(trip.startDate)) 'weekend',
    if (trip.destinations.any(
      (destination) => destination.destinationType == 'BEACH',
    ))
      'beach',
  };

  return CommunityTripCard(
    id: trip.id,
    author: CommunityTripAuthor(
      name: owner?.displayname ?? 'Chủ trip',
      handle: owner != null ? '@${owner.username}' : '@unknown',
      avatarUrl: owner?.avatarUrl,
    ),
    coverUrl: trip.coverImageUrl ?? '',
    badges: badges,
    durationLabel: durationLabel,
    title: trip.name,
    dateLabel: _dateLabel(trip.startDate, trip.endDate),
    costLabel: _costLabel(trip),
    departureLabel: _departureLabel(trip),
    memberCount: trip.memberCount,
    capacity: trip.maxMembers,
    memberAvatars: [
      for (final member in trip.memberPreviews)
        if (member.avatarUrl != null && member.avatarUrl!.isNotEmpty)
          member.avatarUrl!,
    ],
    filterTags: tags.toList(growable: false),
    recruiting: trip.recruiting,
    requirements: trip.requirements,
    estimatedBudgetPerPerson: trip.estimatedBudgetPerPerson,
    slotsRemaining: trip.slotsRemaining,
    expiresAt: trip.expiresAt,
    matchScore: trip.matchScore,
    urgent: trip.urgent,
  );
}

List<ExploreDestination> exploreDestinations({
  required List<TripListItem> trips,
  List<DestinationCatalogItem> catalog = const [],
}) {
  if (catalog.isEmpty) return aggregateDestinations(trips);
  final counts = _cityCounts(trips);
  final ranked = [...catalog]
    ..sort((a, b) {
      final byCount = (counts[_cityKey(b.name)] ?? 0).compareTo(
        counts[_cityKey(a.name)] ?? 0,
      );
      if (byCount != 0) return byCount;
      return a.name.compareTo(b.name);
    });
  return [
    for (final item in ranked.take(12))
      ExploreDestination(
        id: item.id,
        name: item.name,
        imageUrl: item.coverImageUrl ?? '',
        openTripCount: counts[_cityKey(item.name)] ?? 0,
      ),
  ];
}

Map<String, int> _cityCounts(List<TripListItem> trips) {
  final counts = <String, int>{};
  for (final trip in trips) {
    for (final destination in trip.destinations) {
      final key = _cityKey(destination.city);
      if (key.isEmpty) continue;
      counts[key] = (counts[key] ?? 0) + 1;
    }
  }
  return counts;
}

String _cityKey(String city) => city.trim().toLowerCase();

List<ExploreDestination> aggregateDestinations(List<TripListItem> trips) {
  final counts = <String, int>{};
  for (final trip in trips) {
    for (final destination in trip.destinations) {
      final name = destination.city.trim();
      if (name.isEmpty) continue;
      counts[name] = (counts[name] ?? 0) + 1;
    }
  }
  final entries = counts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return [
    for (final entry in entries.take(8))
      ExploreDestination(
        id: entry.key.toLowerCase().replaceAll(RegExp(r'\s+'), '-'),
        name: entry.key,
        imageUrl: '',
        openTripCount: entry.value,
      ),
  ];
}

String _tripTypeBadge(TripType type) => switch (type) {
  TripType.backpacker => 'Phượt tự túc',
  TripType.friends => 'Bạn bè',
  TripType.family => 'Gia đình',
  TripType.couple => 'Cặp đôi',
  TripType.solo => 'Solo',
  TripType.other => 'Cộng đồng',
};

String _costLabel(TripListItem trip) {
  final amount = trip.estimatedBudgetPerPerson?.trim();
  if (amount != null && amount.isNotEmpty) return '$amount / người';
  return switch (trip.budgetLevel) {
    TripBudgetLevel.low => 'Tiết kiệm',
    TripBudgetLevel.medium => 'Trung bình',
    TripBudgetLevel.high => 'Cao cấp',
    null => '—',
  };
}

String _departureLabel(TripListItem trip) {
  if (trip.destinations.isEmpty) return 'Chưa có điểm đến';
  final first = trip.destinations.first;
  final city = first.city.trim();
  final country = first.country.trim();
  if (city.isEmpty) return country.isEmpty ? 'Chưa có điểm đến' : country;
  if (country.isEmpty || country == city) return city;
  return '$city / $country';
}

String _dateLabel(DateTime start, DateTime end) {
  final localStart = start.toLocal();
  final localEnd = end.toLocal();
  final sameDay =
      localStart.year == localEnd.year &&
      localStart.month == localEnd.month &&
      localStart.day == localEnd.day;
  if (sameDay) return _dayMonth(localStart);
  if (localStart.year == localEnd.year) {
    return '${_dayMonth(localStart)} - ${_dayMonth(localEnd)}';
  }
  return '${_dayMonthYear(localStart)} - ${_dayMonthYear(localEnd)}';
}

String _dayMonth(DateTime date) => '${date.day}/${date.month}';

String _dayMonthYear(DateTime date) => '${date.day}/${date.month}/${date.year}';

bool _isThisWeekend(DateTime start) {
  final now = DateTime.now();
  final local = start.toLocal();
  final today = DateTime(now.year, now.month, now.day);
  final tripDay = DateTime(local.year, local.month, local.day);
  final weekday = today.weekday; // Mon=1 … Sun=7
  final daysUntilSaturday = (DateTime.saturday - weekday + 7) % 7;
  final saturday = today.add(Duration(days: daysUntilSaturday));
  final sunday = saturday.add(const Duration(days: 1));
  return !tripDay.isBefore(saturday) && !tripDay.isAfter(sunday);
}
