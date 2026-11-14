import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datasources/trip_detail_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';

ApiClient unusedApiClient() =>
    ApiClient(tokenStorage: TokenStorage(), onSessionExpired: () {});

/// `data` of `GET /trips/{id}` as returned to the trip owner.
Map<String, dynamic> tripDetailJson({String id = 'trip-1'}) => {
  'id': id,
  'name': 'Mùa hè rực rỡ xuyên miền Trung 2025',
  'description': 'Hành trình săn hoàng hôn Mỹ Khê và ẩm thực Hội An.',
  'coverImageUrl': null,
  'status': 'ONGOING',
  'visibility': 'PUBLIC',
  'tripType': 'FRIENDS',
  'startDate': '2025-07-15T00:00:00.000Z',
  'endDate': '2025-07-20T00:00:00.000Z',
  'maxMembers': 6,
  'budgetLevel': 'MEDIUM',
  'inviteCode': 'TRIP-VN2025',
  'viewer': {'userId': 'user-alex', 'role': 'OWNER'},
  'expenseSummary': {'totalAmount': 4850000, 'currency': 'VND'},
  'checkinProgress': {'completedCount': 6, 'totalCount': 8, 'pointsEarned': 0},
  'members': [
    _member(
      'alex',
      'Alex Nguyễn',
      'OWNER',
      travelPersona: 'Beach Lover 🏖️',
      amountSpent: 2710000,
    ),
    _member(
      'trang',
      'Minh Trang',
      'ADMIN',
      travelPersona: 'Foodie Traveler 🍜',
      isOnline: true,
      amountSpent: 2140000,
    ),
    _member(
      'bao',
      'Quốc Bảo',
      'MEMBER',
      activityNote: 'Đã check-in hoạt động',
      memoryCount: 5,
    ),
    _member('phuong', 'Lan Phương', 'MEMBER', isNewMember: true),
  ],
  'destinations': [
    {
      'id': 'destination-danang',
      'city': 'Đà Nẵng',
      'country': 'Việt Nam',
      'order': 1,
      'startDate': '2025-07-15T00:00:00.000Z',
      'endDate': '2025-07-18T00:00:00.000Z',
      'isCurrent': true,
    },
    {
      'id': 'destination-hoian',
      'city': 'Phố Cổ Hội An',
      'country': 'Việt Nam',
      'order': 2,
      'startDate': '2025-07-18T00:00:00.000Z',
      'endDate': '2025-07-20T00:00:00.000Z',
      'isCurrent': false,
    },
  ],
  'nextActivity': {
    'id': 'activity-dragon-bridge',
    'title': 'Ngắm Cầu Rồng phun lửa',
    'description': 'Tập trung tại bến thuyền Bạch Đằng lúc 18:15.',
    'startTime': '2025-07-16T11:30:00.000Z',
    'confirmedCount': 2,
    'totalCount': 4,
  },
  'memories': {
    'totalCount': 12,
    'items': [
      {
        'id': 'memory-ban-co',
        'imageUrl': 'https://cdn.test/memories/ban-co.png',
        'caption': 'Đỉnh Bàn Cờ',
        'authorName': 'Alex Nguyễn',
      },
      {
        'id': 'memory-orphan',
        'imageUrl': 'https://cdn.test/memories/orphan.png',
        'caption': null,
        'authorName': null,
      },
    ],
  },
  'completionReward': {'points': 500, 'canClaim': true, 'claimed': false},
  'timeline': {
    'totalCount': 8,
    'items': [
      {
        'id': 'event-checkin',
        'type': 'ACTIVITY_CHECKIN',
        'actorName': 'Quốc Bảo',
        'actorAvatarUrl': null,
        'content': 'Đã check-in hoạt động',
        'createdAt': '2025-07-16T06:45:00.000Z',
      },
      {
        'id': 'event-expense',
        'type': 'EXPENSE_CREATED',
        'actorName': 'Minh Trang',
        'actorAvatarUrl': null,
        'content': 'Đã thêm một chi phí mới',
        'createdAt': '2025-07-16T05:40:00.000Z',
      },
    ],
  },
};

/// The same trip seen by a signed-in user who is not a member.
Map<String, dynamic> visitorTripDetailJson() => {
  ...tripDetailJson(),
  'inviteCode': null,
  'viewer': {'userId': 'user-visitor', 'role': null},
  'expenseSummary': null,
  'memories': null,
  'completionReward': null,
  'timeline': null,
};

Map<String, dynamic> _member(
  String key,
  String displayName,
  String role, {
  String? travelPersona,
  String? activityNote,
  bool isOnline = false,
  bool isNewMember = false,
  double amountSpent = 0,
  int memoryCount = 0,
}) => {
  'id': 'member-$key',
  'userId': 'user-$key',
  'displayName': displayName,
  'avatarUrl': null,
  'role': role,
  'joinedAt': '2025-07-01T00:00:00.000Z',
  'travelPersona': travelPersona,
  'activityNote': activityNote,
  'isOnline': isOnline,
  'isNewMember': isNewMember,
  'amountSpent': amountSpent,
  'memoryCount': memoryCount,
};

/// In-memory backend: mutations are visible to the next `getTripDetail`.
class FakeTripDetailRemoteDataSource extends TripDetailRemoteDataSource {
  FakeTripDetailRemoteDataSource([Map<String, dynamic>? json])
    : _trip = TripDetailOverview.fromJson(json ?? tripDetailJson()),
      super(apiClient: unusedApiClient());

  TripDetailOverview _trip;

  @override
  Future<TripDetailOverview> getTripDetail(String tripId) async =>
      _trip.copyWith(id: tripId);

  @override
  Future<void> kickMember(String tripId, String targetUserId) async {
    _trip = _trip.copyWith(
      members: _trip.members
          .where((member) => member.userId != targetUserId)
          .toList(growable: false),
    );
  }

  @override
  Future<void> leaveTrip(String tripId) async {
    _trip = _trip.copyWith(
      members: _trip.members
          .where((member) => member.userId != _trip.viewer.userId)
          .toList(growable: false),
    );
  }

  @override
  Future<String> rotateInviteCode(String tripId) async {
    const next = 'NEWCODE1';
    _trip = _trip.copyWith(inviteCode: next);
    return next;
  }

  @override
  Future<TripDetailRewardClaim> claimCompletionReward(String tripId) async {
    final reward = _trip.completionReward;
    if (reward == null || !reward.canClaim || reward.claimed) {
      throw const ApiException(
        message: 'You have already completed this trip',
        statusCode: 409,
      );
    }
    _trip = _trip.copyWith(
      completionReward: reward.copyWith(claimed: true, canClaim: false),
    );
    return TripDetailRewardClaim(pointsAwarded: reward.points);
  }
}
