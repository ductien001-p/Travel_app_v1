import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/achivement/application/achivement_view.dart';
import 'package:travel_frontend_v1/features/achivement/data/datamock/achivement_datamock.dart';
import 'package:travel_frontend_v1/features/achivement/data/models/achivement_models.dart';

void main() {
  test('parses trip missions datamock', () {
    final page = TripMissionsPage.fromJson(tripMissionsDatamock);

    expect(page.completedCount, 2);
    expect(page.totalCount, 4);
    expect(page.missionPointsPending, 55);
    expect(page.missionPointsCap, 80);
    expect(page.items, hasLength(4));
    expect(page.progressRatio, 0.5);

    final food = page.items.firstWhere((m) => m.code == 'FOOD_LOCAL');
    expect(food.completed, isTrue);
    expect(food.group, TripMissionGroup.food);
    expect(food.cta, TripMissionCta.itinerary);

    final memory = page.items.firstWhere((m) => m.code == 'MEMORY_3');
    expect(memory.cta, TripMissionCta.memories);
    expect(memory.progressRatio, closeTo(1 / 3, 0.001));
  });

  test('parses travel tier + achievements datamock', () {
    final page = AchivementProgressPage.fromJson(achivementProgressDatamock);

    expect(page.travelTier?.code, 'TRAVELER');
    expect(page.travelTier?.label, 'Lữ khách');
    expect(page.travelTier?.multiplier, 1.2);
    expect(page.travelTier?.next?.code, 'ADVENTURER');
    expect(page.achievements, hasLength(3));
    expect(page.achievements.first.unlocked, isTrue);
    expect(page.achievements.last.progressRatio, closeTo(12 / 20, 0.001));
  });

  test('parses completion breakdown datamock', () {
    final result = AchivementCompletionResult.fromJson(
      achivementCompletionDatamock,
    );

    expect(result.pointsAwarded, 192);
    expect(result.basePoints, 100);
    expect(result.missionPoints, 60);
    expect(result.multiplierUsed, 1.2);
    expect(result.missionsCompleted, 2);
    expect(result.formulaLabel, '(100 + 60) × 1.2 = 192 điểm');
  });

  test('formats points and CTA labels', () {
    expect(achivementPointsLabel(192, withPlus: true), '+192');
    expect(achivementPointsLabel(1500, withUnit: true), '1.500 pts');
    expect(achivementMissionCtaLabel(TripMissionCta.memories), 'Album');
    expect(
      achivementTierNextHint(
        TravelTier.fromJson(
          achivementProgressDatamock['travelTier'] as Map<String, dynamic>,
        ),
      ),
      contains('Nhà thám hiểm'),
    );
  });
}
