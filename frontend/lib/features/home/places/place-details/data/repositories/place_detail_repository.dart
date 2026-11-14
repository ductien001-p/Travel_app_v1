import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../datasources/place_detail_remote_datasource.dart';
import '../models/place_detail_models.dart';

typedef PlaceMediaUrlResolver = Future<String?> Function(String mediaId);
typedef PlaceCollectionLookup = Future<bool> Function(String placeId);

class PlaceMoment {
  const PlaceMoment({
    required this.id,
    required this.username,
    required this.likes,
    this.imageUrl,
    this.caption,
  });

  final String id;
  final String username;
  final int likes;
  final String? imageUrl;
  final String? caption;
}

class PlaceDetailSnapshot {
  const PlaceDetailSnapshot({
    required this.place,
    required this.summary,
    required this.reviews,
    required this.saved,
    required this.myReview,
    required this.moments,
    required this.momentTotal,
    this.sectionError,
  });

  final PlaceDetailApi place;
  final PlaceRatingSummaryApi summary;
  final PlaceReviewsPage reviews;
  final bool saved;
  final PlaceReviewApi? myReview;
  final List<PlaceMoment> moments;
  final int momentTotal;
  final Object? sectionError;
}

class PlaceDetailRepository {
  const PlaceDetailRepository({
    required PlaceDetailDataSource dataSource,
    this.resolveMediaUrl,
    this.savedInCollection,
  }) : _dataSource = dataSource;

  final PlaceDetailDataSource _dataSource;
  final PlaceMediaUrlResolver? resolveMediaUrl;
  final PlaceCollectionLookup? savedInCollection;

  Future<PlaceDetailSnapshot> load(String placeId) async {
    final place = await _dataSource.getPlace(placeId);
    final summary = await _dataSource.getSummary(placeId);
    final reviews = await _dataSource.getReviews(placeId, page: 1);
    final myReviewResult = await _myReview(placeId);
    final postsResult = await _posts(placeId);
    final savedResult = await _saved(placeId);
    final sectionError =
        myReviewResult.error ?? postsResult.error ?? savedResult.error;
    final posts = postsResult.value ?? _emptyPosts();
    final moments = await _moments(posts.data);
    return PlaceDetailSnapshot(
      place: place,
      summary: summary,
      reviews: reviews,
      saved: savedResult.value ?? false,
      myReview: myReviewResult.value,
      moments: moments,
      momentTotal: posts.meta.total,
      sectionError: sectionError,
    );
  }

  Future<PlaceReviewsPage> getReviews(String placeId, {required int page}) {
    return _dataSource.getReviews(placeId, page: page);
  }

  Future<PlaceRatingSummaryApi> getSummary(String placeId) {
    return _dataSource.getSummary(placeId);
  }

  Future<PlaceReviewApi> createReview(
    String placeId, {
    required int rating,
    String? comment,
  }) {
    return _dataSource.createReview(placeId, rating: rating, comment: comment);
  }

  Future<void> deleteReview(String reviewId) {
    return _dataSource.deleteReview(reviewId);
  }

  Future<bool> isSaved(String placeId) async {
    final saved = await _saved(placeId);
    if (saved.error != null) throw saved.error!;
    return saved.value ?? false;
  }

  Future<_Optional<bool>> _saved(String placeId) async {
    try {
      if (await _dataSource.getSaveStatus(placeId)) {
        return const _Optional(true);
      }
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return _Optional(null, error: error);
    } catch (error) {
      return _Optional(null, error: error);
    }

    final lookup = savedInCollection;
    if (lookup == null) return const _Optional(false);
    try {
      return _Optional(await lookup(placeId));
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return _Optional(null, error: error);
    } catch (error) {
      return _Optional(null, error: error);
    }
  }

  Future<_Optional<PlaceReviewApi?>> _myReview(String placeId) async {
    try {
      return _Optional(await _dataSource.getMyReview(placeId));
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return _Optional(null, error: error);
    } catch (error) {
      return _Optional(null, error: error);
    }
  }

  Future<_Optional<PlacePostsPage>> _posts(String placeId) async {
    try {
      return _Optional(await _dataSource.getPosts(placeId, page: 1));
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return _Optional(null, error: error);
    } catch (error) {
      return _Optional(null, error: error);
    }
  }

  Future<List<PlaceMoment>> _moments(List<PlacePostApi> posts) async {
    final resolver = resolveMediaUrl;
    final moments = <PlaceMoment>[];
    for (final post in posts) {
      String? imageUrl;
      if (resolver != null && post.postMedias.isNotEmpty) {
        final ordered = [...post.postMedias]
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        try {
          final url = await resolver(ordered.first.mediaId);
          final trimmed = url?.trim();
          if (trimmed != null && trimmed.isNotEmpty) imageUrl = trimmed;
        } catch (_) {}
      }
      moments.add(
        PlaceMoment(
          id: post.id,
          username: post.author.username,
          likes: post.likesCount,
          imageUrl: imageUrl,
          caption: post.caption,
        ),
      );
    }
    return moments;
  }
}

class _Optional<T> {
  const _Optional(this.value, {this.error});

  final T? value;
  final Object? error;
}

PlacePostsPage _emptyPosts() {
  return const PlacePostsPage(
    meta: PlacePageMeta(
      page: 1,
      limit: 8,
      total: 0,
      totalPages: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    ),
  );
}
