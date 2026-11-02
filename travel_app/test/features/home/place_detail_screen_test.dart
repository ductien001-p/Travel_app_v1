import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/datamock/place_detail_datamock.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/datasources/place_detail_remote_datasource.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/models/place_detail_models.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/repositories/place_detail_repository.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/presentation/screen/place_detail_screen.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/provider/place_detail_provider.dart';

class _ScreenSource implements PlaceDetailDataSource {
  final Map<String, dynamic> raw =
      jsonDecode(jsonEncode(placeDetailDatamock['placeDetail']))
          as Map<String, dynamic>;

  @override
  Future<PlaceDetailApi> getPlace(String placeId) async {
    return PlaceDetailApi.fromJson(
      jsonDecode(jsonEncode(raw['place'])) as Map<String, dynamic>,
    );
  }

  @override
  Future<PlaceRatingSummaryApi> getSummary(String placeId) async {
    return PlaceRatingSummaryApi.fromJson(
      jsonDecode(jsonEncode(raw['summary'])) as Map<String, dynamic>,
    );
  }

  @override
  Future<PlaceReviewsPage> getReviews(
    String placeId, {
    required int page,
    int limit = 10,
  }) async {
    return PlaceReviewsPage.fromJson(
      jsonDecode(jsonEncode(raw['reviews'])) as Map<String, dynamic>,
    );
  }

  @override
  Future<PlaceReviewApi?> getMyReview(String placeId) async => null;

  @override
  Future<PlaceReviewApi> createReview(
    String placeId, {
    required int rating,
    String? comment,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReview(String reviewId) async {}

  @override
  Future<bool> getSaveStatus(String placeId) async => true;

  @override
  Future<PlacePostsPage> getPosts(
    String placeId, {
    required int page,
    int limit = 8,
  }) async {
    return PlacePostsPage.fromJson(
      jsonDecode(jsonEncode(raw['posts'])) as Map<String, dynamic>,
    );
  }
}

void main() {
  testWidgets('shows the place detail and filters reviews on the device', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer(
      overrides: [
        placeDetailRepositoryProvider.overrideWithValue(
          PlaceDetailRepository(dataSource: _ScreenSource()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: PlaceDetailScreen(placeId: 'pho-co-hoi-an'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('PHỐ CỔ'), findsWidgets);
    expect(find.text('128 đánh giá'), findsWidgets);
    expect(find.text('Xem thêm'), findsOneWidget);
    expect(find.text('Hoàng hôn trên sông Hoài rất đẹp.'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('place-detail-expand')));
    await tester.pump();
    expect(find.text('Thu gọn'), findsOneWidget);

    await tester.ensureVisible(
      find.byKey(const Key('place-review-filter-five')),
    );
    await tester.tap(find.byKey(const Key('place-review-filter-five')));
    await tester.pump();

    expect(find.text('Hoàng hôn trên sông Hoài rất đẹp.'), findsOneWidget);
    expect(
      find.text('Cuối tuần khá đông nhưng đèn lồng rất đẹp.'),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });
}
