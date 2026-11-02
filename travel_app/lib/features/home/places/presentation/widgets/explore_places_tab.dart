import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../application/explore_places_controller.dart';
import '../../place-details/presentation/place_detail_navigation.dart';
import 'featured_place_card.dart';
import 'nearby_place_tile.dart';
import 'place_collection_card.dart';
import 'place_collection_detail_sheet.dart';
import 'place_save_sheet.dart';

class ExplorePlacesTab extends ConsumerWidget {
  const ExplorePlacesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesState = ref.watch(explorePlacesControllerProvider);

    return placesState.when(
      loading: () => const _PlacesLoading(),
      error: (error, _) => _PlacesFailure(
        error: error,
        onRetry: () =>
            ref.read(explorePlacesControllerProvider.notifier).refresh(),
      ),
      data: (view) {
        if (view.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
            child: AppEmptyView(
              title: 'Chưa có địa điểm',
              description: 'Các điểm đến nổi bật sẽ xuất hiện tại đây.',
              icon: Icons.explore_outlined,
            ),
          );
        }
        return _PlacesContent(
          view: view,
          onOpenCollection: (id) => showPlaceCollectionDetailSheet(
            context: context,
            collectionId: id,
          ),
          onBookmark: (id) =>
              showPlaceSaveSheet(context: context, ref: ref, placeId: id),
          onSeeAllFeatured: () =>
              context.pushNamed(RouteNames.featuredDestinations),
          onRadius: (km) =>
              ref.read(explorePlacesControllerProvider.notifier).setRadius(km),
        );
      },
    );
  }
}

class _PlacesContent extends StatelessWidget {
  const _PlacesContent({
    required this.view,
    required this.onOpenCollection,
    required this.onBookmark,
    required this.onRadius,
    required this.onSeeAllFeatured,
  });

  final ExplorePlacesViewState view;
  final ValueChanged<String> onOpenCollection;
  final ValueChanged<String> onBookmark;
  final ValueChanged<int> onRadius;
  final VoidCallback onSeeAllFeatured;

  @override
  Widget build(BuildContext context) {
    final feed = view.feed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (feed.featured.isNotEmpty) ...[
          _PlacesSectionTitle(
            title: 'Điểm Đến Nổi Bật',
            subtitle: feed.featuredSubtitle,
            trailing: TextButton(
              key: const Key('featured-see-all'),
              onPressed: onSeeAllFeatured,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Xem tất cả',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 308,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: feed.featured.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final place = feed.featured[index];
                return FeaturedPlaceCard(
                  place: place,
                  bookmarked: view.isBookmarked(place.id),
                  onOpen: () => openPlaceDetail(context, place.id),
                  onBookmark: () => onBookmark(place.id),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.section),
        ],
        if (feed.nearby.isNotEmpty || view.nearbyMessage != null) ...[
          _PlacesSectionTitle(
            title: 'Gần Bạn Nhất',
            subtitle: feed.nearbySubtitle,
            trailing: _RadiusChoices(
              selectedKm: view.radiusKm,
              onSelected: onRadius,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (view.nearbyMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(view.nearbyMessage!, style: AppTypography.body),
            ),
          for (final place in feed.nearby) ...[
            NearbyPlaceTile(
              place: place,
              onOpen: () => openPlaceDetail(context, place.id),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.md),
        ],
        if (feed.collections.isNotEmpty) ...[
          _PlacesSectionTitle(
            title: 'Bộ Sưu Tập Điểm Đến',
            subtitle: feed.collectionsSubtitle,
            trailing: const Icon(
              Icons.collections_bookmark_outlined,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 128,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: feed.collections.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final collection = feed.collections[index];
                return PlaceCollectionCard(
                  collection: collection,
                  onOpen: () => onOpenCollection(collection.id),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _PlacesSectionTitle extends StatelessWidget {
  const _PlacesSectionTitle({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.sectionTitle),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppSpacing.xs),
          trailing!,
        ],
      ],
    );
  }
}

class _RadiusChoices extends StatelessWidget {
  const _RadiusChoices({required this.selectedKm, required this.onSelected});

  final int selectedKm;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final km in const [10, 5, 1]) ...[
          if (km != 10) const SizedBox(width: 4),
          _RadiusChoice(
            label: '$km km',
            selected: selectedKm == km,
            onTap: () => onSelected(km),
          ),
        ],
      ],
    );
  }
}

class _RadiusChoice extends StatelessWidget {
  const _RadiusChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : AppColors.primaryLight,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        key: Key('nearby-radius-$label'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            label,
            style: AppTypography.caption.copyWith(
              color: selected ? AppColors.textInverse : AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlacesLoading extends StatelessWidget {
  const _PlacesLoading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSkeleton(width: 180, height: 18),
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 220, radius: 20),
        SizedBox(height: AppSpacing.section),
        AppSkeleton(width: 140, height: 18),
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 88, radius: 20),
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 88, radius: 20),
      ],
    );
  }
}

class _PlacesFailure extends StatelessWidget {
  const _PlacesFailure({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final unauthorized = homeFailureIsUnauthorized(error);
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không tải được địa điểm',
      message: unauthorized
          ? 'Đăng nhập lại để xem điểm đến quanh bạn.'
          : homeFailureMessage(error),
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : onRetry,
    );
  }
}
