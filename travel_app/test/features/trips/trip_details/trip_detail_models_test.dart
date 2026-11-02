import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';

import 'trip_detail_fixture.dart';

void main() {
  late TripDetailOverview trip;

  setUp(() => trip = TripDetailOverview.fromJson(tripDetailJson()));

  test('parses the GET /trips/{id} payload', () {
    expect(trip.status, TripDetailStatus.ongoing);
    expect(trip.visibility, TripDetailVisibility.public);
    expect(trip.tripType, TripDetailType.friends);
    expect(trip.inviteCode, 'TRIP-VN2025');
    expect(trip.expenseSummary?.totalAmount, 4850000);
    expect(trip.members, hasLength(4));
    expect(trip.members.first.travelPersona, 'Beach Lover 🏖️');
    expect(
      trip.members.first.joinedAt,
      DateTime.parse('2025-07-01T00:00:00.000Z'),
    );
    expect(trip.destinations.where((d) => d.isCurrent), hasLength(1));
    expect(trip.destinations.first.country, 'Việt Nam');
    expect(trip.nextActivity?.confirmedCount, 2);
    expect(trip.memories?.items.last.authorName, isNull);
    expect(trip.completionReward?.canClaim, isTrue);
    expect(trip.timeline?.items, isNotEmpty);
    expect(trip.checkinProgress.percent, 75);
  });

  test('parses the payload a non-member receives', () {
    final visitor = TripDetailOverview.fromJson(visitorTripDetailJson());

    expect(visitor.viewer.role, isNull);
    expect(visitor.isMember, isFalse);
    expect(visitor.canLeave, isFalse);
    expect(visitor.canInviteMembers, isFalse);
    expect(visitor.members.any(visitor.canRemove), isFalse);
    expect(visitor.expenseSummary, isNull);
    expect(visitor.memories, isNull);
    expect(visitor.completionReward, isNull);
    expect(visitor.timeline, isNull);
  });

  group('permissions follow the backend member rules', () {
    TripDetailMember memberWithRole(TripDetailMemberRole role) =>
        trip.members.firstWhere((m) => m.role == role);

    TripDetailOverview viewedAs(TripDetailMember member) => trip.copyWith(
      viewer: TripDetailViewer(userId: member.userId, role: member.role),
    );

    test('owner can invite and remove admins and members, but not leave', () {
      final owner = viewedAs(memberWithRole(TripDetailMemberRole.owner));

      expect(owner.canInviteMembers, isTrue);
      expect(owner.canManageMembers, isTrue);
      expect(owner.canLeave, isFalse);
      expect(
        owner.canRemove(memberWithRole(TripDetailMemberRole.member)),
        isTrue,
      );
      expect(
        owner.canRemove(memberWithRole(TripDetailMemberRole.admin)),
        isTrue,
      );
      expect(
        owner.canRemove(memberWithRole(TripDetailMemberRole.owner)),
        isFalse,
      );
    });

    test('admin can remove members only and cannot invite', () {
      final admin = viewedAs(memberWithRole(TripDetailMemberRole.admin));

      expect(admin.canInviteMembers, isFalse);
      expect(admin.canManageMembers, isTrue);
      expect(admin.canLeave, isTrue);
      expect(
        admin.canRemove(memberWithRole(TripDetailMemberRole.member)),
        isTrue,
      );
      expect(
        admin.canRemove(memberWithRole(TripDetailMemberRole.admin)),
        isFalse,
      );
    });

    test('member cannot manage, invite or remove anyone', () {
      final plainMember = memberWithRole(TripDetailMemberRole.member);
      final viewerAsMember = viewedAs(plainMember);

      expect(viewerAsMember.canInviteMembers, isFalse);
      expect(viewerAsMember.canManageMembers, isFalse);
      expect(viewerAsMember.canLeave, isTrue);
      expect(trip.members.any(viewerAsMember.canRemove), isFalse);
    });
  });

  test('maps the backend NOTCOMPLETED status', () {
    final parsed = TripDetailOverview.fromJson({
      ...tripDetailJson(),
      'status': 'NOTCOMPLETED',
    });

    expect(parsed.status, TripDetailStatus.notCompleted);
  });

  test('parses every backend timeline event type', () {
    TripDetailEventType parse(String type) => TripDetailTimelineEvent.fromJson({
      'id': 'event-x',
      'type': type,
      'actorName': 'Alex',
      'content': 'Nội dung',
      'createdAt': '2025-07-16T10:00:00Z',
    }).type;

    expect(parse('ACTIVITY_UPDATED'), TripDetailEventType.activityUpdated);
    expect(parse('EXPENSE_SETTLED'), TripDetailEventType.expenseSettled);
    expect(parse('MEMORY_DELETED'), TripDetailEventType.memoryDeleted);
    expect(parse('SOMETHING_NEW'), TripDetailEventType.system);
  });
}
