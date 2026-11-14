import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_invite_friends_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_invite_friends_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_invite_friends_models.dart';

void main() {
  final envelope =
      tripInviteFriendsDatamock['recommendations']! as Map<String, dynamic>;
  final candidates = [
    for (final item in envelope['data']! as List)
      TripInviteCandidate.fromJson(Map<String, dynamic>.from(item as Map)),
  ];
  final now = DateTime.parse(tripInviteFriendsDatamockNow);

  TripInviteFriendsView viewOf({
    TripInviteFriendsFilter filter = TripInviteFriendsFilter.all,
    List<TripInviteCandidate>? people,
    Set<String> excludedUserIds = const {},
  }) => buildTripInviteFriendsView(
    candidates: people ?? candidates,
    searchResults: null,
    hasMoreSearchResults: false,
    filter: filter,
    selectedById: const {},
    excludedUserIds: excludedUserIds,
    now: now,
  );

  test('puts friends with a match score in the suggestion block', () {
    final view = viewOf();

    expect(view.suggestedTitle, 'Gợi ý cùng gu du lịch');
    expect(view.suggested.map((person) => person.user.displayName), [
      'Minh Anh',
      'Thanh Hằng',
      'Hoàng Long',
    ]);
    expect(view.directory.map((person) => person.user.displayName), [
      'Đức Huy',
      'Khánh Vy',
    ]);
    expect(view.singleSectionTitle, isNull);
    expect(candidates[2].canInvite, isFalse);
    expect(
      tripInviteSameTasteChipLabel(envelope['tripTravelPersona'] as String),
      'Cùng gu (Beach Lover 🏖️)',
    );
  });

  test('falls back to shared trips when nobody has a match score', () {
    final plain = [
      for (final person in candidates)
        person.copyWith(travelPersona: null, matchScore: null),
    ];
    final view = viewOf(people: plain);

    expect(view.suggestedTitle, 'Gợi ý bạn đồng hành');
    expect(view.suggested.map((person) => person.user.displayName), [
      'Minh Anh',
      'Hoàng Long',
      'Thanh Hằng',
    ]);
    expect(view.directory.map((person) => person.user.displayName), [
      'Đức Huy',
      'Khánh Vy',
    ]);
  });

  test('recent and same-taste chips use the client thresholds', () {
    final recent = viewOf(filter: TripInviteFriendsFilter.recent);
    expect(recent.singleSectionTitle, 'Gần đây');
    expect(recent.directory.map((person) => person.user.displayName), [
      'Minh Anh',
      'Thanh Hằng',
      'Đức Huy',
    ]);

    final sameTaste = viewOf(filter: TripInviteFriendsFilter.sameTaste);
    expect(sameTaste.singleSectionTitle, 'Cùng gu du lịch');
    expect(sameTaste.directory.map((person) => person.user.displayName), [
      'Minh Anh',
      'Thanh Hằng',
    ]);
  });

  test('pending filter keeps only invitations already sent', () {
    final view = viewOf(filter: TripInviteFriendsFilter.invited);

    expect(view.singleSectionTitle, 'Đã gửi lời mời');
    expect(view.directory.single.user.displayName, 'Thanh Hằng');
    expect(view.suggested, isEmpty);
  });

  test('search hits reuse the known invitation status', () {
    final known = candidates.firstWhere(
      (person) => person.user.id == 'user-duc-huy',
    );
    final hit = candidateFromSearch(
      known.user.copyWith(displayName: 'Đức Huy'),
      [known.copyWith(invitationStatus: TripInviteStatus.pending)],
    );

    expect(hit.invitationStatus, TripInviteStatus.pending);
    expect(hit.canInvite, isFalse);

    final scored = candidates.firstWhere(
      (person) => person.user.id == 'user-minh-anh',
    );
    final scoredHit = candidateFromSearch(scored.user, candidates);
    expect(scoredHit.matchScore, 94);
    expect(scoredHit.travelPersona, 'Beach Lover 🏖️');

    final stranger = candidateFromSearch(
      const TripInviteFriend(
        id: 'user-stranger',
        username: 'stranger',
        displayName: 'Người lạ',
      ),
      candidates,
    );
    expect(stranger.matchScore, isNull);
    expect(stranger.travelPersona, isNull);
  });

  test('members and the viewer are left out of the list', () {
    final view = viewOf(
      excludedUserIds: const {'user-minh-anh', 'user-duc-huy'},
    );

    final names = [
      ...view.suggested.map((person) => person.user.id),
      ...view.directory.map((person) => person.user.id),
    ];
    expect(names, isNot(contains('user-minh-anh')));
    expect(names, isNot(contains('user-duc-huy')));
  });
}
