import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/application/place_detail_controller.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/application/place_detail_view.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/datamock/place_detail_datamock.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/datasources/place_detail_remote_datasource.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/models/place_detail_models.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/repositories/place_detail_repository.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/provider/place_detail_provider.dart';

class _FakePlaceDetailSource implements PlaceDetailDataSource {
  _FakePlaceDetailSource(this.raw);

  final Map<String, dynamic> raw;
  var reviewCalls = 0;
  var failNextPage = false;
  var failPlace = false;

  PlaceDetailApi get place => PlaceDetailApi.fromJson(
    jsonDecode(jsonEncode(raw['place'])) as Map<String, dynamic>,
  );

  @override
  Future<PlaceDetailApi> getPlace(String placeId) async {
    if (failPlace) {
      throw const ApiException(
        message: 'Phiên đăng nhập đã hết hạn',
        statusCode: 401,
      );
    }
    return place;
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
    reviewCalls += 1;
    if (page > 1 && failNextPage) throw Exception('offline');
    if (page == 1) {
      return PlaceReviewsPage.fromJson(
        jsonDecode(jsonEncode(raw['reviews'])) as Map<String, dynamic>,
      );
    }
    return PlaceReviewsPage(
      data: [
        PlaceReviewApi(
          id: 'review-more',
          userId: 'user-more',
          placeId: placeId,
          rating: 5,
          comment: 'Trang sau',
          createdAt: '2026-10-20T00:00:00.000Z',
          updatedAt: '2026-10-20T00:00:00.000Z',
          user: const PlaceReviewUserApi(id: 'user-more', username: 'more'),
        ),
      ],
      meta: const PlacePageMeta(
        page: 2,
        limit: 10,
        total: 128,
        totalPages: 13,
        hasNextPage: false,
        hasPreviousPage: true,
      ),
    );
  }

  @override
  Future<PlaceReviewApi?> getMyReview(String placeId) async => null;

  @override
  Future<PlaceReviewApi> createReview(
    String placeId, {
    required int rating,
    String? comment,
  }) async {
    return PlaceReviewApi(
      id: 'review-me',
      userId: 'me',
      placeId: placeId,
      rating: rating.toDouble(),
      comment: comment,
      createdAt: '2026-11-01T00:00:00.000Z',
      updatedAt: '2026-11-01T00:00:00.000Z',
      user: const PlaceReviewUserApi(id: 'me', username: 'me'),
    );
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

Map<String, dynamic> _raw() =>
    jsonDecode(jsonEncode(placeDetailDatamock['placeDetail']))
        as Map<String, dynamic>;

Future<ProviderContainer> _container(_FakePlaceDetailSource source) async {
  final container = ProviderContainer(
    overrides: [
      placeDetailRepositoryProvider.overrideWithValue(
        PlaceDetailRepository(dataSource: source),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('loads the place and filters reviews without another request', () async {
    final source = _FakePlaceDetailSource(_raw());
    final container = await _container(source);
    final state = await container.read(
      placeDetailControllerProvider('pho-co-hoi-an').future,
    );

    expect(state.place.name, 'Phố Cổ Hội An');
    expect(state.saved, isTrue);
    expect(state.moments.single.username, 'lanphuong.travel');
    expect(source.reviewCalls, 1);

    container
        .read(placeDetailControllerProvider('pho-co-hoi-an').notifier)
        .selectFilter(PlaceReviewFilter.five);

    final filtered = container
        .read(placeDetailControllerProvider('pho-co-hoi-an'))
        .requireValue;
    expect(filtered.viewAt(DateTime.utc(2026, 11, 1)).reviews, hasLength(1));
    expect(source.reviewCalls, 1);
  });

  test('keeps loaded reviews when the next page fails', () async {
    final source = _FakePlaceDetailSource(_raw())..failNextPage = true;
    final container = await _container(source);
    await container.read(placeDetailControllerProvider('pho-co-hoi-an').future);

    await container
        .read(placeDetailControllerProvider('pho-co-hoi-an').notifier)
        .loadMoreReviews();

    final state = container
        .read(placeDetailControllerProvider('pho-co-hoi-an'))
        .requireValue;
    expect(state.reviews, hasLength(2));
    expect(state.reviewsError, 'Đã xảy ra lỗi. Vui lòng thử lại.');
    expect(state.loadingMore, isFalse);
  });

  test('unauthorized place load stays an error without a retry loop', () async {
    final source = _FakePlaceDetailSource(_raw())..failPlace = true;
    final container = await _container(source);

    await expectLater(
      container.read(placeDetailControllerProvider('pho-co-hoi-an').future),
      throwsA(isA<ApiException>()),
    );
    expect(source.reviewCalls, 0);
  });

  test('submits a review and puts it first', () async {
    final source = _FakePlaceDetailSource(_raw());
    final container = await _container(source);
    await container.read(placeDetailControllerProvider('pho-co-hoi-an').future);

    await container
        .read(placeDetailControllerProvider('pho-co-hoi-an').notifier)
        .submitReview(rating: 5, comment: 'Đẹp');

    final state = container
        .read(placeDetailControllerProvider('pho-co-hoi-an'))
        .requireValue;
    expect(state.myReview?.id, 'review-me');
    expect(state.reviews.first.id, 'review-me');
    expect(state.submittingReview, isFalse);
  });
}
