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
  });

  final PlaceDetailApi place;
  final PlaceRatingSummaryApi summary;
  final PlaceReviewsPage reviews;
  final bool saved;
  final PlaceReviewApi? myReview;
  final List<PlaceMoment> moments;
  final int momentTotal;
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
    final myReview = await _myReviewOrNull(placeId);
    final posts = await _postsOrEmpty(placeId);
    final moments = await _moments(posts.data);
    final saved = await isSaved(placeId);
    return PlaceDetailSnapshot(
      place: place,
      summary: summary,
      reviews: reviews,
      saved: saved,
      myReview: myReview,
      moments: moments,
      momentTotal: posts.meta.total,
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
    try {
      if (await _dataSource.getSaveStatus(placeId)) return true;
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
    } catch (_) {}

    final lookup = savedInCollection;
    if (lookup == null) return false;
    try {
      return await lookup(placeId);
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<PlaceReviewApi?> _myReviewOrNull(String placeId) async {
    try {
      return await _dataSource.getMyReview(placeId);
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return null;
    }
  }

  Future<PlacePostsPage> _postsOrEmpty(String placeId) async {
    try {
      return await _dataSource.getPosts(placeId, page: 1);
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return _emptyPosts();
    } catch (_) {
      return _emptyPosts();
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
