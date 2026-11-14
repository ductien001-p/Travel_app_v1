import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_showcase_controller.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_showcase_models.dart';
import 'package:travel_frontend_v1/features/travel-dna/application/travel_dna_radar_controller.dart';
import 'package:travel_frontend_v1/features/travel-dna/application/travel_dna_radar_view.dart';
import 'package:travel_frontend_v1/features/travel-dna/data/models/travel_dna_models.dart';
import 'package:travel_frontend_v1/features/travel-dna/presentation/screen/travel_dna_companions_screen.dart';
import 'package:travel_frontend_v1/features/travel-dna/presentation/screen/travel_dna_radar_screen.dart';
import 'package:travel_frontend_v1/features/travel-dna/presentation/widgets/travel_dna_radar_body.dart';

import '../profile/profile_showcase_fixture.dart';

void main() {
  test('radar view maps the radar payload', () {
    final view = buildTravelDnaRadarView(
      radar: _radar(),
      identity: const TravelDnaIdentityInput(
        displayName: 'Alex Nguyễn',
        initials: 'AN',
        verified: true,
        rankChip: 'Hạng Thám hiểm • 1.450 pts',
      ),
      now: DateTime.utc(2026, 10, 27),
    );

    expect(view.identity.personaTitle, 'Foodie Traveler 🍜');
    expect(view.identity.spotlight, 'Top 4% Ẩm Thực');
    expect(view.identity.summary, 'Mo ta');
    expect(view.radarAxes, hasLength(6));
    expect(
      view.radarAxes.map((axis) => axis.type),
      isNot(contains('GROUP_TRAVELER')),
    );
    expect(view.details, hasLength(7));
    expect(view.chartTitle, 'Radar 6 Chiều Bản Sắc');
    expect(view.stats.tripsAnalyzed, 5);
    expect(view.stats.checkIns, 32);
    expect(view.stats.portraitMatch, 88);
    expect(view.radarAxes.first.communityScore, 62);
    expect(view.radarAxes.first.evidence, '🍜 16 điểm ẩm thực check-in');
    expect(view.radarAxes.first.badgeLabel, 'Huy hiệu: Bậc thầy vị giác');
    expect(view.radarAxes.first.fitLabel, 'Hợp: Tour Hội An, Chợ Côn Đảo');
    expect(
      view.details.firstWhere((axis) => axis.type == 'ADVENTURE_TRAVELER'),
      predicate<TravelDnaAxisView>(
        (axis) =>
            axis.potential &&
            axis.badgeLabel == 'Trục tiềm năng mở rộng' &&
            axis.fitLabel == 'Gợi ý: Trekking Tà Năng',
      ),
    );
    expect(view.updatedLabel, 'Cập nhật 2 ngày trước');
    expect(view.journey?.tripId, 'trip-hue');
    expect(view.journey?.matchPercent, 98);
    expect(view.journey?.durationLabel, '3 Ngày 2 Đêm');
    expect(view.journey?.highlightLabel, '12 hoạt động');
    expect(view.companions, hasLength(4));
    expect(view.companionPreview, hasLength(3));
    expect(view.companions.map((item) => item.fitLabel), [
      'Cực kỳ hợp',
      'Rất ăn ý',
      'Khá ổn',
      'Khá ổn',
    ]);
    expect(
      travelDnaRankChip(rank: 'ADVENTURER', totalPoints: 1450),
      'Hạng Thám hiểm • 1.450 pts',
    );
    expect(travelDnaShareMessage(view), contains('Ẩm Thực: 88/100'));
  });

  test('hides the spotlight and journey when the payload omits them', () {
    final full = _radar();
    final view = buildTravelDnaRadarView(
      radar: full.copyWith(dominantPercentile: null, journey: null),
      identity: const TravelDnaIdentityInput(displayName: 'An', initials: 'A'),
      now: DateTime.utc(2026, 10, 27),
    );

    expect(view.identity.spotlight, isNull);
    expect(view.journey, isNull);
  });

  test('portrait match stays inside 0 to 100', () {
    final badge = _badge(
      type: 'FOODIE_TRAVELER',
      name: 'Foodie Traveler',
      icon: '🍜',
      shortLabel: 'Ẩm Thực',
      badgeTitle: 'Bậc thầy vị giác',
      score: 140,
    );
    final view = buildTravelDnaRadarView(
      radar: TravelDnaRadar(
        dna: TravelDnaSnapshot(
          dominant: badge,
          topBadges: [badge],
          all: [badge],
        ),
        community: const [],
        fitPlaces: const [],
        companions: const [],
      ),
      identity: const TravelDnaIdentityInput(displayName: 'An', initials: 'A'),
      now: DateTime.utc(2026, 10, 27),
    );

    expect(view.stats.portraitMatch, 100);
    expect(view.chartTitle, 'Radar 1 Chiều Bản Sắc');
    expect(view.hasDna, isTrue);
  });

  test('parses the radar payload', () {
    final radar = TravelDnaRadar.fromJson({
      'dna': {
        'dominant': _badgeJson(),
        'topBadges': [_badgeJson()],
        'all': [_badgeJson()],
      },
      'community': [
        {'type': 'FOODIE_TRAVELER', 'averageScore': 62.4, 'sampleCount': 40},
      ],
      'dominantPercentile': 96,
      'fitPlaces': [
        {
          'type': 'FOODIE_TRAVELER',
          'places': [
            {'id': 'place-1', 'name': 'Cao lầu', 'city': 'Hội An'},
          ],
        },
        {'type': 'PHOTOGRAPHY_LOVER', 'places': <Map<String, dynamic>>[]},
      ],
      'journey': null,
      'companions': [
        {
          'userId': 'user-2',
          'displayName': 'Lan Phương',
          'username': 'lanphuong',
          'avatarUrl': null,
          'matchPercent': 94,
          'persona': {'name': 'Foodie Traveler', 'icon': '🍜'},
        },
      ],
    });

    expect(radar.dna.dominant?.shortLabel, 'Ẩm Thực');
    expect(radar.community.single.averageScore, 62);
    expect(radar.dominantPercentile, 96);
    expect(radar.fitPlaces.last.places, isEmpty);
    expect(radar.journey, isNull);
    expect(radar.companions.single.displayName, 'Lan Phương');
  });

  testWidgets('radar body hides a missing journey and the group invite', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final full = _radar();
    final view = buildTravelDnaRadarView(
      radar: TravelDnaRadar(
        dna: TravelDnaSnapshot(
          dominant: full.dna.dominant,
          topBadges: full.dna.topBadges,
          all: full.dna.all.take(3).toList(),
        ),
        community: full.community,
        fitPlaces: full.fitPlaces,
        companions: full.companions,
      ),
      identity: const TravelDnaIdentityInput(
        displayName: 'Alex Nguyễn',
        initials: 'AN',
      ),
      now: DateTime.utc(2026, 10, 27),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TravelDnaRadarBody(
            view: view,
            onOpenJourney: () {},
            onFindCompanions: () {},
          ),
        ),
      ),
    );

    expect(find.text('Radar 3 Chiều Bản Sắc'), findsOneWidget);
    expect(find.text('Trung bình cộng đồng'), findsOneWidget);
    expect(find.text('Xem Hành Trình'), findsNothing);
    expect(find.byIcon(Icons.group_add_rounded), findsNothing);
    expect(find.textContaining('Lan Phương'), findsOneWidget);
    expect(find.textContaining('Mai'), findsNothing);

    await tester.tap(find.text('So sánh cộng đồng'));
    await tester.pump();

    expect(find.text('Trung bình cộng đồng'), findsNothing);
  });

  testWidgets('view journey opens trip detail and find opens companions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = _router();
    await tester.pumpWidget(_app(router, _radar()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Xem Hành Trình'));
    await tester.pumpAndSettle();

    expect(find.text('trip trip-hue'), findsOneWidget);

    router.pop();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tìm Bạn Đồng Hành Hợp Gu DNA'));
    await tester.pumpAndSettle();

    expect(find.text('Bạn Đồng Hành'), findsOneWidget);
    expect(find.textContaining('Mai'), findsOneWidget);
    expect(find.byIcon(Icons.group_add_rounded), findsNothing);
  });

  testWidgets('companions screen shows an empty state', (tester) async {
    final router = _router();
    await tester.pumpWidget(_app(router, _radar(companions: const [])));
    await tester.pumpAndSettle();

    router.go('/profile/travel-dna/companions');
    await tester.pumpAndSettle();

    expect(find.text('Chưa có bạn hợp gu'), findsOneWidget);
  });
}

Widget _app(GoRouter router, TravelDnaRadar radar) {
  return ProviderScope(
    overrides: [
      travelDnaRadarControllerProvider.overrideWith(() => _ReadyRadar(radar)),
      profileControllerProvider.overrideWith(_ReadyProfile.new),
      profileShowcaseControllerProvider.overrideWith(
        () => _ReadyShowcase(sampleProfileShowcase()),
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

GoRouter _router() {
  return GoRouter(
    initialLocation: '/profile/travel-dna',
    routes: [
      GoRoute(
        path: '/profile/travel-dna',
        name: RouteNames.travelDnaRadar,
        builder: (context, state) => const TravelDnaRadarScreen(),
        routes: [
          GoRoute(
            path: 'companions',
            name: RouteNames.travelDnaCompanions,
            builder: (context, state) => const TravelDnaCompanionsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/trips/:tripId',
        name: RouteNames.tripDetail,
        builder: (context, state) =>
            Text('trip ${state.pathParameters['tripId']}'),
      ),
    ],
  );
}

class _ReadyRadar extends TravelDnaRadarController {
  _ReadyRadar(this.radar);

  final TravelDnaRadar radar;

  @override
  TravelDnaRadar build() => radar;
}

class _ReadyProfile extends ProfileController {
  @override
  ProfileModel build() => const ProfileModel(
    id: 'user-1',
    displayName: 'Alex Nguyễn',
    username: 'alex_wander',
    email: 'alex@example.com',
    avatarId: null,
    bio: null,
    phone: null,
    address: null,
    location: null,
    gender: null,
    dateOfBirth: null,
    budgetLevel: null,
    travelStyle: [],
    languages: [],
    interests: [],
    notificationEnabled: true,
    visitedCount: 0,
  );
}

class _ReadyShowcase extends ProfileShowcaseController {
  _ReadyShowcase(this.showcase);

  final ProfileShowcase showcase;

  @override
  ProfileShowcase build() => showcase;
}

TravelDnaRadar _radar({List<TravelDnaCompanion>? companions}) {
  final badges = [
    _badge(
      type: 'FOODIE_TRAVELER',
      name: 'Foodie Traveler',
      icon: '🍜',
      shortLabel: 'Ẩm Thực',
      badgeTitle: 'Bậc thầy vị giác',
      score: 88,
      activityCount: 16,
      updatedAt: '2026-10-25T00:00:00.000Z',
    ),
    _badge(
      type: 'CULTURE_TRAVELER',
      name: 'Culture Traveler',
      icon: '🏛️',
      shortLabel: 'Văn Hóa',
      badgeTitle: 'Người kể chuyện di sản',
      score: 76,
      activityCount: 8,
    ),
    _badge(
      type: 'PHOTOGRAPHY_LOVER',
      name: 'Photography Lover',
      icon: '📸',
      shortLabel: 'Săn Ảnh',
      badgeTitle: 'Ống kính nghệ thuật',
      score: 72,
      activityCount: 1,
    ),
    _badge(
      type: 'BEACH_LOVER',
      name: 'Beach Lover',
      icon: '🏖️',
      shortLabel: 'Biển Đảo',
      badgeTitle: 'Tín đồ hoàng hôn biển',
      score: 64,
      activityCount: 5,
    ),
    _badge(
      type: 'BACKPACKER',
      name: 'Backpacker',
      icon: '🎒',
      shortLabel: 'Phượt Bụi',
      badgeTitle: 'Trục tiềm năng mở rộng',
      score: 58,
      tripTypeCount: 4,
    ),
    _badge(
      type: 'ADVENTURE_TRAVELER',
      name: 'Adventure Traveler',
      icon: '🧗',
      shortLabel: 'Dã Ngoại',
      badgeTitle: 'Trục tiềm năng mở rộng',
      score: 52,
      activityCount: 2,
    ),
    _badge(
      type: 'GROUP_TRAVELER',
      name: 'Group Traveler',
      icon: '👥',
      shortLabel: 'Nhóm bạn',
      badgeTitle: 'Trục tiềm năng mở rộng',
      score: 20,
      tripTypeCount: 1,
    ),
  ];
  return TravelDnaRadar(
    dna: TravelDnaSnapshot(
      dominant: badges.first,
      topBadges: badges.take(3).toList(),
      all: badges,
    ),
    community: const [
      TravelDnaCommunityScore(
        type: 'FOODIE_TRAVELER',
        averageScore: 62,
        sampleCount: 40,
      ),
    ],
    dominantPercentile: 96,
    fitPlaces: const [
      TravelDnaFitPlaces(
        type: 'FOODIE_TRAVELER',
        places: [
          TravelDnaPlace(id: 'p1', name: 'Tour Hội An', city: 'Hội An'),
          TravelDnaPlace(id: 'p2', name: 'Chợ Côn Đảo', city: 'Côn Đảo'),
        ],
      ),
      TravelDnaFitPlaces(
        type: 'ADVENTURE_TRAVELER',
        places: [
          TravelDnaPlace(
            id: 'p3',
            name: 'Trekking Tà Năng',
            city: 'Bình Thuận',
          ),
        ],
      ),
    ],
    journey: const TravelDnaJourney(
      tripId: 'trip-hue',
      name: 'Khám phá ẩm thực Huế',
      matchPercent: 98,
      startDate: '2026-11-01T00:00:00.000Z',
      endDate: '2026-11-03T00:00:00.000Z',
      activityCount: 12,
    ),
    companions:
        companions ??
        const [
          TravelDnaCompanion(
            userId: 'u1',
            displayName: 'Lan Phương',
            username: 'lanphuong',
            matchPercent: 94,
            persona: TravelDnaPersona(name: 'Foodie Traveler', icon: '🍜'),
          ),
          TravelDnaCompanion(
            userId: 'u2',
            displayName: 'Quốc Bảo',
            username: 'bao',
            matchPercent: 89,
            persona: TravelDnaPersona(name: 'Photography Lover', icon: '📸'),
          ),
          TravelDnaCompanion(
            userId: 'u3',
            displayName: 'Hoàng Nam',
            username: 'nam',
            matchPercent: 75,
            persona: TravelDnaPersona(name: 'Adventure Traveler', icon: '🧗'),
          ),
          TravelDnaCompanion(
            userId: 'u4',
            displayName: 'Mai',
            username: 'mai',
            matchPercent: 70,
            persona: TravelDnaPersona(name: 'Beach Lover', icon: '🏖️'),
          ),
        ],
  );
}

TravelDnaBadge _badge({
  required String type,
  required String name,
  required String icon,
  required String shortLabel,
  required String badgeTitle,
  required int score,
  int tripTypeCount = 0,
  int activityCount = 0,
  String updatedAt = '2026-10-20T00:00:00.000Z',
}) {
  return TravelDnaBadge(
    type: type,
    name: name,
    icon: icon,
    description: 'Mo ta',
    score: score,
    tripTypeCount: tripTypeCount,
    activityCount: activityCount,
    createdAt: '2026-10-01T00:00:00.000Z',
    updatedAt: updatedAt,
    shortLabel: shortLabel,
    badgeTitle: badgeTitle,
  );
}

Map<String, dynamic> _badgeJson() => {
  'type': 'FOODIE_TRAVELER',
  'name': 'Foodie Traveler',
  'icon': '🍜',
  'description': 'Mo ta',
  'score': 88,
  'tripTypeCount': 0,
  'activityCount': 16,
  'createdAt': '2026-10-01T00:00:00.000Z',
  'updatedAt': '2026-10-25T00:00:00.000Z',
  'shortLabel': 'Ẩm Thực',
  'badgeTitle': 'Bậc thầy vị giác',
};
