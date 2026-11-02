import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/application/place_detail_view.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/datamock/place_detail_datamock.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/models/place_detail_models.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/data/repositories/place_detail_repository.dart';

void main() {
  final raw = placeDetailDatamock['placeDetail'] as Map<String, dynamic>;
  final place = PlaceDetailApi.fromJson(
    jsonDecode(jsonEncode(raw['place'])) as Map<String, dynamic>,
  );
  final summary = PlaceRatingSummaryApi.fromJson(
    jsonDecode(jsonEncode(raw['summary'])) as Map<String, dynamic>,
  );
  final reviews = PlaceReviewsPage.fromJson(
    jsonDecode(jsonEncode(raw['reviews'])) as Map<String, dynamic>,
  );
  const moments = [
    PlaceMoment(id: 'post-lan', username: 'lanphuong.travel', likes: 184),
  ];

  PlaceDetailView view({PlaceReviewFilter filter = PlaceReviewFilter.all}) {
    return buildPlaceDetailView(
      place: place,
      summary: summary,
      reviews: reviews.data,
      hasNextReviewPage: reviews.meta.hasNextPage,
      moments: moments,
      momentTotal: 46,
      filter: filter,
      now: DateTime.utc(2026, 11, 2, 9),
    );
  }

  test('maps the place contract into the detail view', () {
    final result = view();

    expect(place.name, 'Phố Cổ Hội An');
    expect(result.categoryLabel, 'PHỐ CỔ');
    expect(result.addressLine, 'Trần Phú, Phường Minh An, Hội An');
    expect(result.ratingLabel, '4.8');
    expect(result.reviewCountLabel, '128 đánh giá');
    expect(result.photoCount, 0);
    expect(result.bars.first.stars, 5);
    expect(result.bars.first.count, 88);
    expect(result.bars.first.fraction, 88 / 128);
    expect(result.reviews.map((review) => review.username), [
      'lanphuong',
      'thutrang',
    ]);
    expect(result.reviews.first.ageLabel, '3 ngày trước');
    expect(result.showMoments, isTrue);
    expect(result.loadMoreLabel, 'Xem thêm đánh giá');
    expect(
      placeMapLink(place.latitude, place.longitude),
      'https://www.google.com/maps/search/?api=1&query=15.8801,108.338',
    );
  });

  test('star filter keeps only matching loaded reviews', () {
    final result = view(filter: PlaceReviewFilter.five);

    expect(result.reviews.map((review) => review.id), ['review-lan']);
  });

  test('parses a reviews page when meta flags and updatedAt are absent', () {
    final page = PlaceReviewsPage.fromJson({
      'data': [
        {
          'id': 'review-lan',
          'userId': 'user-lan',
          'placeId': 'pho-co-hoi-an',
          'rating': 5,
          'comment': 'Hoàng hôn trên sông Hoài rất đẹp.',
          'createdAt': '2026-10-30T08:00:00.000Z',
          'user': {'id': 'user-lan', 'username': 'lanphuong'},
        },
      ],
      'meta': {'page': 1, 'limit': 10, 'total': 12, 'totalPages': 2},
    });

    expect(page.meta.hasNextPage, isTrue);
    expect(page.meta.hasPreviousPage, isFalse);
    expect(page.data.single.updatedAt, '2026-10-30T08:00:00.000Z');
  });
}
