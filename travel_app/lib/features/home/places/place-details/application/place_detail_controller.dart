import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';

import '../data/models/place_detail_models.dart';
import '../data/repositories/place_detail_repository.dart';
import '../provider/place_detail_provider.dart';
import 'place_detail_view.dart';

class PlaceDetailState {
  const PlaceDetailState({
    required this.place,
    required this.summary,
    required this.reviews,
    required this.reviewsMeta,
    required this.saved,
    required this.myReview,
    required this.moments,
    required this.momentTotal,
    this.filter = PlaceReviewFilter.all,
    this.loadingMore = false,
    this.submittingReview = false,
    this.reviewsError,
  });

  final PlaceDetailApi place;
  final PlaceRatingSummaryApi summary;
  final List<PlaceReviewApi> reviews;
  final PlacePageMeta reviewsMeta;
  final bool saved;
  final PlaceReviewApi? myReview;
  final List<PlaceMoment> moments;
  final int momentTotal;
  final PlaceReviewFilter filter;
  final bool loadingMore;
  final bool submittingReview;
  final String? reviewsError;

  PlaceDetailView viewAt(DateTime now) {
    return buildPlaceDetailView(
      place: place,
      summary: summary,
      reviews: reviews,
      hasNextReviewPage: reviewsMeta.hasNextPage,
      moments: moments,
      momentTotal: momentTotal,
      filter: filter,
      now: now,
    );
  }

  PlaceDetailState copyWith({
    PlaceDetailApi? place,
    PlaceRatingSummaryApi? summary,
    List<PlaceReviewApi>? reviews,
    PlacePageMeta? reviewsMeta,
    bool? saved,
    Object? myReview = _keepReview,
    List<PlaceMoment>? moments,
    int? momentTotal,
    PlaceReviewFilter? filter,
    bool? loadingMore,
    bool? submittingReview,
    Object? reviewsError = _keepError,
  }) {
    return PlaceDetailState(
      place: place ?? this.place,
      summary: summary ?? this.summary,
      reviews: reviews ?? this.reviews,
      reviewsMeta: reviewsMeta ?? this.reviewsMeta,
      saved: saved ?? this.saved,
      myReview: identical(myReview, _keepReview)
          ? this.myReview
          : myReview as PlaceReviewApi?,
      moments: moments ?? this.moments,
      momentTotal: momentTotal ?? this.momentTotal,
      filter: filter ?? this.filter,
      loadingMore: loadingMore ?? this.loadingMore,
      submittingReview: submittingReview ?? this.submittingReview,
      reviewsError: identical(reviewsError, _keepError)
          ? this.reviewsError
          : reviewsError as String?,
    );
  }
}

const _keepReview = Object();
const _keepError = Object();

final placeDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<PlaceDetailController, PlaceDetailState, String>(
      PlaceDetailController.new,
      retry: (_, _) => null,
    );

class PlaceDetailController extends AsyncNotifier<PlaceDetailState> {
  PlaceDetailController(this.placeId);

  final String placeId;
  int _generation = 0;

  @override
  FutureOr<PlaceDetailState> build() {
    _generation++;
    return _load();
  }

  Future<void> refresh() async {
    final previous = state.value;
    if (previous == null) state = const AsyncLoading();
    final generation = ++_generation;
    try {
      final next = await _load();
      if (generation != _generation) return;
      state = AsyncData(next.copyWith(filter: previous?.filter));
    } catch (error, stackTrace) {
      if (generation != _generation) return;
      if (previous != null) {
        state = AsyncData(previous);
        Error.throwWithStackTrace(error, stackTrace);
      }
      state = AsyncError(error, stackTrace);
    }
  }

  void selectFilter(PlaceReviewFilter filter) {
    final current = state.value;
    if (current == null || current.filter == filter) return;
    state = AsyncData(current.copyWith(filter: filter));
  }

  Future<void> loadMoreReviews() async {
    final current = state.value;
    if (current == null ||
        current.loadingMore ||
        !current.reviewsMeta.hasNextPage) {
      return;
    }
    final generation = _generation;
    state = AsyncData(current.copyWith(loadingMore: true, reviewsError: null));
    try {
      final page = await ref
          .read(placeDetailRepositoryProvider)
          .getReviews(placeId, page: current.reviewsMeta.page + 1);
      if (generation != _generation) return;
      final latest = state.value;
      if (latest == null) return;
      state = AsyncData(
        latest.copyWith(
          reviews: [...latest.reviews, ...page.data],
          reviewsMeta: page.meta,
          loadingMore: false,
        ),
      );
    } catch (error) {
      if (generation != _generation) return;
      final latest = state.value;
      if (latest == null) return;
      state = AsyncData(
        latest.copyWith(
          loadingMore: false,
          reviewsError: homeFailureMessage(error),
        ),
      );
    }
  }

  Future<void> refreshSaved() async {
    final current = state.value;
    if (current == null) return;
    final saved = await ref
        .read(placeDetailRepositoryProvider)
        .isSaved(placeId);
    final latest = state.value;
    if (latest == null) return;
    state = AsyncData(latest.copyWith(saved: saved));
  }

  Future<void> submitReview({required int rating, String? comment}) async {
    final current = state.value;
    if (current == null || current.submittingReview) return;
    if (rating < 1 || rating > 5) {
      throw ArgumentError.value(rating, 'rating');
    }
    state = AsyncData(current.copyWith(submittingReview: true));
    try {
      final repository = ref.read(placeDetailRepositoryProvider);
      final created = await repository.createReview(
        placeId,
        rating: rating,
        comment: comment,
      );
      final summary = await repository.getSummary(placeId);
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          submittingReview: false,
          myReview: created,
          summary: summary,
          reviews: _upsert(latest.reviews, created),
          reviewsError: null,
        ),
      );
    } catch (error) {
      final latest = state.value ?? current;
      state = AsyncData(latest.copyWith(submittingReview: false));
      rethrow;
    }
  }

  Future<void> deleteMyReview() async {
    final current = state.value;
    final mine = current?.myReview;
    if (current == null || mine == null || current.submittingReview) return;
    state = AsyncData(current.copyWith(submittingReview: true));
    try {
      final repository = ref.read(placeDetailRepositoryProvider);
      await repository.deleteReview(mine.id);
      final summary = await repository.getSummary(placeId);
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          submittingReview: false,
          myReview: null,
          summary: summary,
          reviews: [
            for (final review in latest.reviews)
              if (review.id != mine.id) review,
          ],
        ),
      );
    } catch (error) {
      final latest = state.value ?? current;
      state = AsyncData(latest.copyWith(submittingReview: false));
      rethrow;
    }
  }

  Future<PlaceDetailState> _load() async {
    final snapshot = await ref
        .read(placeDetailRepositoryProvider)
        .load(placeId);
    return PlaceDetailState(
      place: snapshot.place,
      summary: snapshot.summary,
      reviews: snapshot.reviews.data,
      reviewsMeta: snapshot.reviews.meta,
      saved: snapshot.saved,
      myReview: snapshot.myReview,
      moments: snapshot.moments,
      momentTotal: snapshot.momentTotal,
    );
  }
}

List<PlaceReviewApi> _upsert(
  List<PlaceReviewApi> reviews,
  PlaceReviewApi created,
) {
  final without = [
    for (final review in reviews)
      if (review.id != created.id && review.userId != created.userId) review,
  ];
  return [created, ...without];
}
