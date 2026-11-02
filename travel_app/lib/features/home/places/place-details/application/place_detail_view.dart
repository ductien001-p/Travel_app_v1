import '../data/models/place_detail_models.dart';
import '../data/repositories/place_detail_repository.dart';
import '../../application/featured_destinations_view.dart';

enum PlaceReviewFilter { all, five, four, three, two, one }

class PlaceRatingBar {
  const PlaceRatingBar({
    required this.stars,
    required this.count,
    required this.fraction,
  });

  final int stars;
  final int count;
  final double fraction;
}

class PlaceReviewCard {
  const PlaceReviewCard({
    required this.id,
    required this.username,
    required this.ratingLabel,
    required this.ageLabel,
    required this.comment,
    required this.initial,
  });

  final String id;
  final String username;
  final String ratingLabel;
  final String ageLabel;
  final String comment;
  final String initial;
}

class PlaceDetailView {
  const PlaceDetailView({
    required this.categoryLabel,
    required this.addressLine,
    required this.ratingLabel,
    required this.reviewCountLabel,
    required this.photoCount,
    required this.bars,
    required this.reviews,
    required this.filter,
    required this.hasDescription,
    required this.showMoments,
    required this.momentTitleCount,
    required this.loadMoreLabel,
  });

  final String categoryLabel;
  final String addressLine;
  final String ratingLabel;
  final String reviewCountLabel;
  final int photoCount;
  final List<PlaceRatingBar> bars;
  final List<PlaceReviewCard> reviews;
  final PlaceReviewFilter filter;
  final bool hasDescription;
  final bool showMoments;
  final int momentTitleCount;
  final String? loadMoreLabel;
}

PlaceDetailView buildPlaceDetailView({
  required PlaceDetailApi place,
  required PlaceRatingSummaryApi summary,
  required List<PlaceReviewApi> reviews,
  required bool hasNextReviewPage,
  required List<PlaceMoment> moments,
  required int momentTotal,
  required PlaceReviewFilter filter,
  required DateTime now,
}) {
  final address = place.address.trim();
  final city = place.city.trim();
  final country = place.country.trim();
  final addressLine = address.isNotEmpty
      ? address
      : [if (city.isNotEmpty) city, if (country.isNotEmpty) country].join(', ');

  return PlaceDetailView(
    categoryLabel: featuredCategoryLabel(place.category).toUpperCase(),
    addressLine: addressLine,
    ratingLabel: placeRatingLabel(summary.averageRating),
    reviewCountLabel: '${summary.totalReviews} đánh giá',
    photoCount: place.coverImageUrls
        .where((url) => url.trim().isNotEmpty)
        .length,
    bars: _bars(summary),
    reviews: [
      for (final review in reviews)
        if (_matches(review, filter))
          PlaceReviewCard(
            id: review.id,
            username: review.user.username,
            ratingLabel: placeRatingLabel(review.rating),
            ageLabel: placeReviewAge(
              DateTime.parse(review.createdAt),
              now: now,
            ),
            comment: review.comment?.trim() ?? '',
            initial: _initial(review.user.username),
          ),
    ],
    filter: filter,
    hasDescription: place.description?.trim().isNotEmpty ?? false,
    showMoments: moments.isNotEmpty,
    momentTitleCount: momentTotal,
    loadMoreLabel: hasNextReviewPage ? 'Xem thêm đánh giá' : null,
  );
}

String placeRatingLabel(double rating) => rating.toStringAsFixed(1);

String placeReviewAge(DateTime time, {required DateTime now}) {
  final age = now.difference(time.toUtc());
  if (age.inMinutes < 1) return 'Vừa xong';
  if (age.inHours < 1) return '${age.inMinutes} phút trước';
  if (age.inDays < 1) return '${age.inHours} giờ trước';
  if (age.inDays == 1) return 'Hôm qua';
  if (age.inDays < 7) return '${age.inDays} ngày trước';
  if (age.inDays < 30) return '${age.inDays ~/ 7} tuần trước';
  final utc = time.toUtc();
  final day = utc.day.toString().padLeft(2, '0');
  final month = utc.month.toString().padLeft(2, '0');
  return '$day/$month/${utc.year}';
}

String placeMapLink(double latitude, double longitude) {
  return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
}

String placeShareText({
  required String name,
  required double latitude,
  required double longitude,
}) {
  return '$name\n${placeMapLink(latitude, longitude)}';
}

int placeReviewFilterStars(PlaceReviewFilter filter) {
  return switch (filter) {
    PlaceReviewFilter.all => 0,
    PlaceReviewFilter.five => 5,
    PlaceReviewFilter.four => 4,
    PlaceReviewFilter.three => 3,
    PlaceReviewFilter.two => 2,
    PlaceReviewFilter.one => 1,
  };
}

List<PlaceRatingBar> _bars(PlaceRatingSummaryApi summary) {
  final distribution = summary.distribution;
  final counts = {
    5: distribution.five,
    4: distribution.four,
    3: distribution.three,
    2: distribution.two,
    1: distribution.one,
  };
  final total = summary.totalReviews;
  return [
    for (final stars in [5, 4, 3, 2, 1])
      PlaceRatingBar(
        stars: stars,
        count: counts[stars] ?? 0,
        fraction: total <= 0 ? 0 : (counts[stars] ?? 0) / total,
      ),
  ];
}

bool _matches(PlaceReviewApi review, PlaceReviewFilter filter) {
  final stars = placeReviewFilterStars(filter);
  if (stars == 0) return true;
  return review.rating.round() == stars;
}

String _initial(String username) {
  final trimmed = username.trim();
  if (trimmed.isEmpty) return '?';
  return String.fromCharCode(trimmed.runes.first).toUpperCase();
}
