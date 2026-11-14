import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/presentation/profile_count_format.dart';
import 'package:travel_frontend_v1/features/profile/presentation/profile_showcase_labels.dart';

import 'profile_showcase_fixture.dart';

void main() {
  test('profile showcase response uses backend field names', () {
    final showcase = sampleProfileShowcase();

    expect(profileShowsVerifiedBadge(showcase.hostStatus), isTrue);
    expect(profileRankLabel(showcase.ranking), 'Top 5% • Hạng Thám hiểm');
    expect(profilePointsLabel(showcase.ranking.totalPoints), '1.450 pts');
    expect(showcase.social.followerCount, 1250);
    expect(showcase.social.followingCount, 340);
    expect(showcase.travelDna.dominant?.name, 'Food Explorer');
    expect(showcase.travelDna.dominant?.score, 88);
    expect(
      profileDnaCaption(showcase.travelDna.dominant!),
      '16 điểm đã check-in',
    );
    expect(profileSupportingTraits(showcase.travelDna), hasLength(3));
    expect(
      showcase.travelDna.all.map((trait) => trait.name),
      contains('Đường dài'),
    );
    expect(showcase.ongoingTrip?.name, contains('Hội An'));
    expect(showcase.ongoingTrip?.completedActivities, 7);
    expect(
      profileTripDateLabel(
        showcase.ongoingTrip!.startDate,
        showcase.ongoingTrip!.endDate,
      ),
      '19/07 - 22/07/2025',
    );
    expect(
      profileOngoingDurationLabel(
        showcase.ongoingTrip!.startDate,
        showcase.ongoingTrip!.endDate,
      ),
      'Hành trình 4 ngày 3 đêm',
    );
    expect(showcase.upcomingTrip?.memberCount, 3);
    expect(profileBudgetLabel(showcase.upcomingTrip?.budgetLevel), 'Vừa phải');
    expect(showcase.memories.totalCount, 184);
    expect(profileMemoryExtraCount(showcase.memories), 182);
    expect(showcase.savedPlaces.items, hasLength(1));
    expect(showcase.posts.count, 15);
  });

  test('formatProfileCount groups thousands with a dot', () {
    expect(formatProfileCount(18), '18');
    expect(formatProfileCount(1250), '1.250');
    expect(formatProfileCount(1450), '1.450');
    expect(profileRatio(7, 10), 0.7);
    expect(profileRatio(0, 0), 0);
  });
}
