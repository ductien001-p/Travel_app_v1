import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/notifications/application/notification_destination.dart';
import 'package:travel_frontend_v1/features/notifications/data/models/notification_models.dart';

void main() {
  test('parses an inbox item and unread meta', () {
    final item = AppNotification.fromJson({
      'id': 'n-1',
      'type': 'TRIP_INVITATION',
      'title': 'Lời mời',
      'message': 'Alex mời bạn',
      'isRead': false,
      'createdAt': '2026-07-19T07:00:00.000Z',
      'tripId': 'trip-1',
      'actorId': 'user-2',
    });

    expect(item.title, 'Lời mời');
    expect(item.tripId, 'trip-1');
    expect(item.isRead, isFalse);
  });

  test('opens join requests for a trip join request and trip detail otherwise', () {
    expect(
      notificationDestination(type: 'TRIP_JOIN_REQUEST', tripId: 'trip-1')
          .target,
      NotificationOpenTarget.joinRequests,
    );
    expect(
      notificationDestination(
        type: 'TRIP_RECRUITMENT_CLOSED',
        tripId: 'trip-1',
      ).target,
      NotificationOpenTarget.tripDetail,
    );
    expect(
      notificationDestination(type: 'TRIP_INVITATION', tripId: null).target,
      NotificationOpenTarget.none,
    );
  });
}
