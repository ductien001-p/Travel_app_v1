import 'package:travel_frontend_v1/features/profile/data/models/profile_showcase_models.dart';

ProfileShowcase sampleProfileShowcase() => ProfileShowcase.fromJson({
  'hostStatus': 'APPROVED',
  'ranking': {
    'userId': 'user-1',
    'totalPoints': 1450,
    'totalTripsCompleted': 8,
    'rank': 'ADVENTURER',
    'ranking': 50,
    'percentile': 5,
  },
  'social': {'tripCount': 12, 'followerCount': 1250, 'followingCount': 340},
  'travelDna': {
    'dominant': _badge(
      type: 'FOODIE_TRAVELER',
      name: 'Food Explorer',
      icon: '🍜',
      score: 88,
      activityCount: 16,
    ),
    'topBadges': <Map<String, dynamic>>[],
    'all': [
      _badge(
        type: 'FOODIE_TRAVELER',
        name: 'Food Explorer',
        icon: '🍜',
        score: 88,
        activityCount: 16,
      ),
      _badge(type: 'CULTURE_TRAVELER', name: 'Văn Hóa', icon: '🏛️', score: 76),
      _badge(type: 'PHOTOGRAPHY_LOVER', name: 'Săn Ảnh', icon: '📸', score: 72),
      _badge(type: 'BEACH_LOVER', name: 'Biển Đảo', icon: '🌊', score: 64),
      _badge(
        type: 'ADVENTURE_TRAVELER',
        name: 'Đường dài',
        icon: '🥾',
        score: 51,
      ),
    ],
  },
  'ongoingTrip': _trip(
    id: 'trip-ongoing',
    name: 'Mùa Hè Rực Rỡ: Bán Đảo Sơn Trà & Phố Cổ Hội An',
    status: 'ONGOING',
    startDate: '2025-07-19T00:00:00.000Z',
    endDate: '2025-07-22T00:00:00.000Z',
    memberCount: 4,
    completedActivities: 7,
    totalActivities: 10,
    highlights: ['Bánh Mì Phượng', 'Trà Mót'],
  ),
  'upcomingTrip': _trip(
    id: 'trip-upcoming',
    name: 'Mùa Thu Tây Bắc & Săn Mây Y Tý',
    status: 'UPCOMING',
    startDate: '2025-10-01T00:00:00.000Z',
    endDate: '2025-10-05T00:00:00.000Z',
    memberCount: 3,
    completedActivities: 0,
    totalActivities: 0,
    highlights: [],
  ),
  'memories': {
    'totalCount': 184,
    'items': [
      {'id': 'memory-1', 'imageUrl': 'https://example.com/m1.jpg'},
      {'id': 'memory-2', 'imageUrl': 'https://example.com/m2.jpg'},
    ],
  },
  'savedPlaces': {
    'count': 24,
    'items': [
      {
        'id': 'saved-1',
        'placeId': 'place-1',
        'name': 'Phố đèn lồng Hội An',
        'city': 'Hội An',
        'country': 'Việt Nam',
        'category': 'OLD_TOWN',
        'coverImageUrl': 'https://example.com/saved.jpg',
      },
    ],
  },
  'posts': {'count': 15, 'items': <Map<String, dynamic>>[]},
});

Map<String, dynamic> _badge({
  required String type,
  required String name,
  required String icon,
  required int score,
  int activityCount = 0,
}) => {
  'type': type,
  'name': name,
  'icon': icon,
  'description': name,
  'score': score,
  'tripTypeCount': 1,
  'activityCount': activityCount,
  'createdAt': '2026-01-01T00:00:00.000Z',
  'updatedAt': '2026-01-01T00:00:00.000Z',
};

Map<String, dynamic> _trip({
  required String id,
  required String name,
  required String status,
  required String startDate,
  required String endDate,
  required int memberCount,
  required int completedActivities,
  required int totalActivities,
  required List<String> highlights,
}) => {
  'id': id,
  'name': name,
  'coverImageUrl': 'https://example.com/$id.jpg',
  'status': status,
  'startDate': startDate,
  'endDate': endDate,
  'budgetLevel': 'MEDIUM',
  'maxMembers': 5,
  'memberCount': memberCount,
  'totalActivities': totalActivities,
  'completedActivities': completedActivities,
  'highlights': highlights,
};
