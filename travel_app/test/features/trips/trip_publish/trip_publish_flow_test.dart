import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/home/presentation/widgets/explore_create_trip_banner.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/application/publish_entry.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/data/datamock/trip_publish_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/data/models/trip_publish_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/presentation/recruitment_impact_dialog.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/presentation/sheet/publish_trip_sheet.dart';

void main() {
  test('summary error keeps the fallback banner label', () {
    expect(publishBannerLabel(summaryFailed: true), 'Đăng chuyến đi');
    expect(publishBannerLabel(activeCount: 2), 'Quản lý bài đăng');
    expect(
      publishProfileReady(displayName: 'Lan', avatarUrl: 'https://img'),
      isTrue,
    );
    expect(
      publishProfileReady(displayName: 'Lan', avatarId: null, avatarUrl: ''),
      isFalse,
    );
  });

  test('upcoming trips open the sheet and a lone draft asks to continue', () {
    final mine = publishSheetMine();
    expect(decidePublishEntry(mine), isA<PublishEntrySheet>());
    expect(
      decidePublishEntry(
        RecruitmentMine(
          activeRecruitmentCount: 0,
          latestPublishDraft: mine.latestPublishDraft,
        ),
      ),
      isA<PublishEntryAskDraft>(),
    );
    expect(
      decidePublishEntry(const RecruitmentMine(activeRecruitmentCount: 0)),
      isA<PublishEntryCreateTrip>(),
    );
  });

  test('expiry label includes the device offset', () {
    final label = formatRecruitmentInstant(DateTime.utc(2026, 9, 14, 14));
    expect(label, contains('UTC'));
    expect(label, isNot('UTC'));
  });

  testWidgets('fallback banner label stays tappable', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExploreCreateTripBanner(
            label: publishBannerLabel(summaryFailed: true),
            onCreateTrip: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Đăng chuyến đi'), findsOneWidget);
    await tester.tap(find.text('Đăng chuyến đi'));
    expect(tapped, isTrue);
  });

  testWidgets('Đăng opens manage and Tạo mới opens create trip', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    PublishSheetChoice? choice;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PublishTripSheet(
            mine: publishSheetMine(),
            onChoice: (value) => choice = value,
          ),
        ),
      ),
    );

    final publish = find.text('Đăng');
    await tester.ensureVisible(publish);
    await tester.pumpAndSettle();
    await tester.tap(publish);
    expect(choice, isA<PublishSheetManage>());
    expect((choice! as PublishSheetManage).tripId, 'trip-new');

    final create = find.text('Tạo chuyến đi mới');
    await tester.ensureVisible(create);
    await tester.pumpAndSettle();
    await tester.tap(create);
    expect(choice, isA<PublishSheetCreateTrip>());

    final draft = find.text('Tiếp tục nháp');
    await tester.ensureVisible(draft);
    await tester.pumpAndSettle();
    await tester.tap(draft);
    expect(choice, isA<PublishSheetContinueDraft>());
    expect((choice! as PublishSheetContinueDraft).tripId, 'draft-1');
  });

  testWidgets('acknowledge code opens the confirm dialog', (tester) async {
    expect(
      isRecruitmentImpactAck(
        const ApiException(
          message: 'ack',
          code: recruitmentImpactAckCode,
          statusCode: 400,
        ),
      ),
      isTrue,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: TextButton(
                onPressed: () => showRecruitmentImpactDialog(context),
                child: const Text('Mở'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Mở'));
    await tester.pumpAndSettle();
    expect(find.text('Xác nhận'), findsOneWidget);
    await tester.tap(find.text('Xác nhận'));
    await tester.pumpAndSettle();
    expect(find.text('Xác nhận'), findsNothing);
  });
}
