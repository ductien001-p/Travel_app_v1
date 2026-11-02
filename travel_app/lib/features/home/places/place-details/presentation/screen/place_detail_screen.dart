import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';
import 'package:travel_frontend_v1/features/home/places/presentation/widgets/explore_place_cover.dart';
import 'package:travel_frontend_v1/features/home/places/presentation/widgets/place_save_sheet.dart';

import '../../application/place_detail_controller.dart';
import '../../application/place_detail_view.dart';
import '../../data/repositories/place_detail_repository.dart';
import '../widgets/place_itinerary_sheet.dart';
import '../widgets/place_review_sheet.dart';

class PlaceDetailScreen extends ConsumerStatefulWidget {
  const PlaceDetailScreen({super.key, required this.placeId});

  final String placeId;

  @override
  ConsumerState<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends ConsumerState<PlaceDetailScreen> {
  var _photoIndex = 0;
  var _descriptionExpanded = false;

  void _back() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.placeId.trim().isEmpty) {
      return AppScaffold(
        body: const AppErrorView(
          title: 'Không mở được địa điểm',
          message: 'Thiếu mã địa điểm.',
        ),
      );
    }

    final async = ref.watch(placeDetailControllerProvider(widget.placeId));
    return AppScaffold(
      bottomNavigationBar: async.asData == null
          ? null
          : _PlaceDetailBar(
              saved: async.requireValue.saved,
              onSave: () => _save(widget.placeId),
              onAdd: () => _addToTrip(async.requireValue),
            ),
      body: async.when(
        loading: () => const _PlaceDetailLoading(),
        error: (error, _) => AppErrorView(
          title: homeFailureIsUnauthorized(error)
              ? 'Phiên đăng nhập đã hết hạn'
              : 'Không tải được địa điểm',
          message: homeFailureMessage(error),
          actionLabel: 'Thử lại',
          onRetry: homeFailureIsUnauthorized(error)
              ? null
              : () => ref
                    .read(
                      placeDetailControllerProvider(widget.placeId).notifier,
                    )
                    .refresh(),
        ),
        data: (state) => _PlaceDetailBody(
          state: state,
          photoIndex: _photoIndex,
          descriptionExpanded: _descriptionExpanded,
          onBack: _back,
          onPhotoChanged: (index) => setState(() => _photoIndex = index),
          onToggleDescription: () =>
              setState(() => _descriptionExpanded = !_descriptionExpanded),
          onShare: () => _share(state),
          onDirections: () => _directions(state),
          onSave: () => _save(state.place.id),
          onReview: () => showPlaceReviewSheet(
            context: context,
            ref: ref,
            placeId: state.place.id,
          ),
          onAdd: () => _addToTrip(state),
          onFilter: (filter) => ref
              .read(placeDetailControllerProvider(widget.placeId).notifier)
              .selectFilter(filter),
          onLoadMore: () => ref
              .read(placeDetailControllerProvider(widget.placeId).notifier)
              .loadMoreReviews(),
          onRefresh: _refresh,
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    try {
      await ref
          .read(placeDetailControllerProvider(widget.placeId).notifier)
          .refresh();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(homeFailureMessage(error))));
    }
  }

  Future<void> _save(String placeId) async {
    await showPlaceSaveSheet(context: context, ref: ref, placeId: placeId);
    if (!mounted) return;
    await ref
        .read(placeDetailControllerProvider(placeId).notifier)
        .refreshSaved();
  }

  Future<void> _addToTrip(PlaceDetailState state) async {
    final added = await showPlaceItinerarySheet(
      context: context,
      placeId: state.place.id,
      placeName: state.place.name,
    );
    if (!added || !mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã thêm vào lịch trình.')));
  }

  Future<void> _share(PlaceDetailState state) {
    final place = state.place;
    return _shareText(
      placeShareText(
        name: place.name,
        latitude: place.latitude,
        longitude: place.longitude,
      ),
    );
  }

  Future<void> _directions(PlaceDetailState state) {
    final place = state.place;
    return _shareText(placeMapLink(place.latitude, place.longitude));
  }

  Future<void> _shareText(String text) {
    final box = context.findRenderObject();
    final origin = box is RenderBox
        ? box.localToGlobal(Offset.zero) & box.size
        : null;
    return SharePlus.instance.share(
      ShareParams(text: text, sharePositionOrigin: origin),
    );
  }
}

class _PlaceDetailBody extends StatelessWidget {
  const _PlaceDetailBody({
    required this.state,
    required this.photoIndex,
    required this.descriptionExpanded,
    required this.onBack,
    required this.onPhotoChanged,
    required this.onToggleDescription,
    required this.onShare,
    required this.onDirections,
    required this.onSave,
    required this.onReview,
    required this.onAdd,
    required this.onFilter,
    required this.onLoadMore,
    required this.onRefresh,
  });

  final PlaceDetailState state;
  final int photoIndex;
  final bool descriptionExpanded;
  final VoidCallback onBack;
  final ValueChanged<int> onPhotoChanged;
  final VoidCallback onToggleDescription;
  final VoidCallback onShare;
  final VoidCallback onDirections;
  final VoidCallback onSave;
  final VoidCallback onReview;
  final VoidCallback onAdd;
  final ValueChanged<PlaceReviewFilter> onFilter;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final view = state.viewAt(DateTime.now());
    final place = state.place;
    final photos = [
      for (final url in place.coverImageUrls)
        if (url.trim().isNotEmpty) url.trim(),
    ];
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        children: [
          _Hero(
            photos: photos,
            photoIndex: photoIndex,
            categoryLabel: view.categoryLabel,
            saved: state.saved,
            onBack: onBack,
            onSave: onSave,
            onShare: onShare,
            onPhotoChanged: onPhotoChanged,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              0,
              AppSpacing.screenHorizontal,
              0,
            ),
            child: Transform.translate(
              offset: const Offset(0, -12),
              child: _OverviewCard(
                name: place.name,
                categoryLabel: view.categoryLabel,
                address: view.addressLine,
                ratingLabel: view.ratingLabel,
                reviewCountLabel: view.reviewCountLabel,
                onDirections: onDirections,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: _QuickActions(
              onAdd: onAdd,
              onReview: onReview,
              onDirections: onDirections,
              onShare: onShare,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: _AboutCard(
              description: place.description?.trim() ?? '',
              expanded: descriptionExpanded,
              hasDescription: view.hasDescription,
              onToggle: onToggleDescription,
            ),
          ),
          if (view.showMoments) ...[
            const SizedBox(height: AppSpacing.xl),
            _Moments(moments: state.moments, total: view.momentTitleCount),
          ],
          const SizedBox(height: AppSpacing.xl),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: _Reviews(
              view: view,
              summaryLabel: view.ratingLabel,
              onFilter: onFilter,
              onLoadMore: onLoadMore,
              loadingMore: state.loadingMore,
              reviewsError: state.reviewsError,
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({
    required this.photos,
    required this.photoIndex,
    required this.categoryLabel,
    required this.saved,
    required this.onBack,
    required this.onSave,
    required this.onShare,
    required this.onPhotoChanged,
  });

  final List<String> photos;
  final int photoIndex;
  final String categoryLabel;
  final bool saved;
  final VoidCallback onBack;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final ValueChanged<int> onPhotoChanged;

  @override
  Widget build(BuildContext context) {
    final index = photos.isEmpty ? 0 : photoIndex.clamp(0, photos.length - 1);
    return SizedBox(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (photos.isEmpty)
            const ExplorePlaceCover(url: '')
          else
            PageView.builder(
              itemCount: photos.length,
              onPageChanged: onPhotoChanged,
              itemBuilder: (context, page) =>
                  ExplorePlaceCover(url: photos[page]),
            ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.40),
                  Color.fromRGBO(0, 0, 0, 0),
                  AppColors.canvasMint,
                ],
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.screenHorizontal,
            right: AppSpacing.screenHorizontal,
            top: AppSpacing.xs,
            child: Row(
              children: [
                AppIconButton(
                  icon: Icons.chevron_left_rounded,
                  onPressed: onBack,
                  semanticLabel: 'Quay lại',
                  iconColor: AppColors.primary,
                ),
                const Spacer(),
                AppIconButton(
                  icon: saved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  onPressed: onSave,
                  semanticLabel: 'Lưu địa điểm này',
                  iconColor: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                AppIconButton(
                  icon: Icons.share_rounded,
                  onPressed: onShare,
                  semanticLabel: 'Chia sẻ điểm đến',
                ),
              ],
            ),
          ),
          Positioned(
            left: AppSpacing.screenHorizontal,
            right: AppSpacing.screenHorizontal,
            bottom: AppSpacing.xl,
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.glass90,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Text(
                      categoryLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                if (photos.isNotEmpty) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.40),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      '${index + 1}/${photos.length} ảnh',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.name,
    required this.categoryLabel,
    required this.address,
    required this.ratingLabel,
    required this.reviewCountLabel,
    required this.onDirections,
  });

  final String name;
  final String categoryLabel;
  final String address;
  final String ratingLabel;
  final String reviewCountLabel;
  final VoidCallback onDirections;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryLabel,
            style: AppTypography.badge.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            name,
            key: const Key('place-detail-name'),
            style: AppTypography.display.copyWith(fontSize: 32, height: 1.15),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Expanded(
                child: Text(
                  address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium,
                ),
              ),
              TextButton.icon(
                onPressed: onDirections,
                icon: const Icon(Icons.map_rounded, size: 16),
                label: const Text('Bản đồ'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(Icons.star_rounded, size: 16, color: AppColors.warning),
              const SizedBox(width: AppSpacing.xxs),
              Text(ratingLabel, style: AppTypography.cardTitle),
              const SizedBox(width: AppSpacing.xs),
              Text(reviewCountLabel, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onAdd,
    required this.onReview,
    required this.onDirections,
    required this.onShare,
  });

  final VoidCallback onAdd;
  final VoidCallback onReview;
  final VoidCallback onDirections;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Action(
          icon: Icons.add_circle_rounded,
          label: 'Lịch trình',
          onTap: onAdd,
        ),
        _Action(
          icon: Icons.rate_review_rounded,
          label: 'Đánh giá',
          onTap: onReview,
        ),
        _Action(
          icon: Icons.near_me_rounded,
          label: 'Chỉ đường',
          onTap: onDirections,
        ),
        _Action(icon: Icons.share_rounded, label: 'Chia sẻ', onTap: onShare),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
        child: Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.input),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(color: AppColors.borderBrandSoft),
              ),
              child: Column(
                children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.description,
    required this.expanded,
    required this.hasDescription,
    required this.onToggle,
  });

  final String description;
  final bool expanded;
  final bool hasDescription;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giới thiệu', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.xs),
          Text(
            hasDescription ? description : 'Chưa có giới thiệu.',
            key: const Key('place-detail-description'),
            maxLines: expanded || !hasDescription ? null : 3,
            overflow: expanded || !hasDescription
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            style: AppTypography.body,
          ),
          if (hasDescription)
            TextButton(
              key: const Key('place-detail-expand'),
              onPressed: onToggle,
              child: Text(expanded ? 'Thu gọn' : 'Xem thêm'),
            ),
        ],
      ),
    );
  }
}

class _Moments extends StatelessWidget {
  const _Moments({required this.moments, required this.total});

  final List<PlaceMoment> moments;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Text(
            'Khoảnh khắc từ du khách ($total)',
            style: AppTypography.sectionTitle,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            itemCount: moments.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final moment = moments[index];
              return SizedBox(
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ExplorePlaceCover(url: moment.imageUrl ?? ''),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0),
                              Color.fromRGBO(0, 0, 0, 0.70),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: AppSpacing.xs,
                        right: AppSpacing.xs,
                        bottom: AppSpacing.xs,
                        child: Text(
                          '@${moment.username}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse,
                          ),
                        ),
                      ),
                      Positioned(
                        top: AppSpacing.xs,
                        right: AppSpacing.xs,
                        child: Text(
                          '${moment.likes}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({
    required this.view,
    required this.summaryLabel,
    required this.onFilter,
    required this.onLoadMore,
    required this.loadingMore,
    required this.reviewsError,
  });

  final PlaceDetailView view;
  final String summaryLabel;
  final ValueChanged<PlaceReviewFilter> onFilter;
  final VoidCallback onLoadMore;
  final bool loadingMore;
  final String? reviewsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Đánh giá từ cộng đồng',
                style: AppTypography.sectionTitle,
              ),
            ),
            Text(view.reviewCountLabel, style: AppTypography.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: _cardDecoration(),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    summaryLabel,
                    style: AppTypography.display.copyWith(fontSize: 40),
                  ),
                  Text(view.reviewCountLabel, style: AppTypography.caption),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  children: [
                    for (final bar in view.bars)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                              child: Text(
                                '${bar.stars}',
                                style: AppTypography.caption,
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                                child: LinearProgressIndicator(
                                  value: bar.fraction,
                                  minHeight: 8,
                                  backgroundColor: AppColors.surfaceSubdued,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            SizedBox(
                              width: 28,
                              child: Text(
                                '${bar.count}',
                                textAlign: TextAlign.right,
                                style: AppTypography.caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final filter in PlaceReviewFilter.values) ...[
                AppChip(
                  key: Key('place-review-filter-${filter.name}'),
                  label: _filterLabel(filter),
                  selected: view.filter == filter,
                  onTap: () => onFilter(filter),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (view.reviews.isEmpty)
          const SizedBox(
            height: 220,
            child: AppEmptyView(
              title: 'Chưa có đánh giá',
              description: 'Hãy là người đầu tiên chia sẻ trải nghiệm.',
            ),
          )
        else
          for (final review in view.reviews)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                key: Key('place-review-${review.id}'),
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: _cardDecoration(radius: AppRadius.cardLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primaryLight,
                          child: Text(
                            review.initial,
                            style: AppTypography.cardTitle.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.username,
                                style: AppTypography.cardTitle,
                              ),
                              Text(
                                review.ageLabel,
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          review.ratingLabel,
                          style: AppTypography.cardTitle,
                        ),
                      ],
                    ),
                    if (review.comment.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(review.comment, style: AppTypography.body),
                    ],
                  ],
                ),
              ),
            ),
        if (reviewsError != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              reviewsError!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ),
        if (view.loadMoreLabel != null)
          AppButton(
            key: const Key('place-reviews-more'),
            label: loadingMore ? 'Đang tải' : view.loadMoreLabel!,
            variant: AppButtonVariant.secondary,
            isLoading: loadingMore,
            onPressed: loadingMore ? null : onLoadMore,
          ),
      ],
    );
  }
}

String _filterLabel(PlaceReviewFilter filter) {
  if (filter == PlaceReviewFilter.all) return 'Tất cả';
  return '${placeReviewFilterStars(filter)} sao';
}

class _PlaceDetailBar extends StatelessWidget {
  const _PlaceDetailBar({
    required this.saved,
    required this.onSave,
    required this.onAdd,
  });

  final bool saved;
  final VoidCallback onSave;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: AppGlassSurface(
        radius: AppRadius.hero,
        padding: const EdgeInsets.all(AppSpacing.sm),
        shadows: AppShadows.level2,
        child: Row(
          children: [
            AppIconButton(
              icon: saved
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              onPressed: onSave,
              semanticLabel: 'Lưu địa điểm này',
              iconColor: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: 'Thêm vào lịch trình',
                leadingIcon: Icons.luggage_rounded,
                onPressed: onAdd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceDetailLoading extends StatelessWidget {
  const _PlaceDetailLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.screenHorizontal),
      child: Column(
        children: [
          AppSkeleton(
            width: double.infinity,
            height: 220,
            radius: AppRadius.hero,
          ),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(
            width: double.infinity,
            height: 140,
            radius: AppRadius.hero,
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration({double radius = AppRadius.hero}) {
  return BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.borderBrandSoft),
    boxShadow: AppShadows.level1,
  );
}
