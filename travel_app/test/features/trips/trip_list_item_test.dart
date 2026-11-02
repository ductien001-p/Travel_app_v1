import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_enums.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_related_models.dart';
import 'package:travel_frontend_v1/features/trips/presentation/screen/trip_screen.dart';

Map<String, dynamic> _listItemJson({required String status}) => {
  'id': 'trip-1',
  'name': 'Đà Nẵng',
  'description': null,
  'startDate': '2026-09-25T00:00:00.000Z',
  'endDate': '2026-09-28T00:00:00.000Z',
  'budgetLevel': 'MEDIUM',
  'maxMembers': 5,
  'tripType': 'FRIENDS',
  'visibility': 'PRIVATE',
  'status': status,
  'destinations': [
    {
      'id': 'destination-1',
      'city': 'Đà Nẵng',
      'country': 'Việt Nam',
      'lat': 16.0544,
      'lng': 108.2022,
      'order': 1,
      'startDate': '2026-09-25T00:00:00.000Z',
      'endDate': '2026-09-28T00:00:00.000Z',
    },
  ],
  'memberCount': 2,
  'memberPreviews': [
    {'id': 'member-1', 'username': 'An', 'avatarUrl': null},
  ],
  'owner': {
    'id': 'owner-1',
    'displayname': 'An',
    'username': 'an',
    'avatarUrl': null,
  },
  'recruiting': true,
  'coverImageUrl': null,
  'checkinCount': 3,
  'totalActivities': 4,
  'completedActivities': 2,
  'progressPercent': 50,
  'nextActivity': {
    'id': 'activity-1',
    'title': 'Bán đảo Sơn Trà',
    'startTime': '2026-09-26T08:00:00.000Z',
  },
};

void main() {
  test('parses the trip dashboard response shape', () {
    final item = TripListItem.fromJson(_listItemJson(status: 'ONGOING'));

    expect(item.destinations.single.tripId, 'trip-1');
    expect(item.memberPreviews.single.username, 'An');
    expect(item.owner?.displayname, 'An');
    expect(item.recruiting, isTrue);
    expect(item.progressPercent, 50);
    expect(item.nextActivity?.title, 'Bán đảo Sơn Trà');
  });

  test('maps Prisma NOTCOMPLETED list status', () {
    final item = TripListItem.fromJson(_listItemJson(status: 'NOTCOMPLETED'));
    expect(item.status, TripStatus.notCompleted);
  });

  test('maps legacy NOTCOM list status', () {
    final item = TripListItem.fromJson(_listItemJson(status: 'NOTCOM'));
    expect(item.status, TripStatus.notCompleted);
  });

  test('maps invitation nested trip status NOTCOMPLETED', () {
    final summary = TripInvitationSummary.fromJson({
      'id': 'trip-1',
      'name': 'Đà Nẵng',
      'status': 'NOTCOMPLETED',
      'startDate': '2026-09-25T00:00:00.000Z',
      'endDate': '2026-09-28T00:00:00.000Z',
    });
    expect(summary.status, TripStatus.notCompleted);
  });

  test('trip screen is constructible', () {
    expect(const TripScreen(), isNotNull);
  });
}
