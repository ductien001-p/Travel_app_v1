import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';

import '../../application/saved_places_controller.dart';
import '../../application/saved_places_view.dart';
import '../widgets/saved_place_add_trip_sheet.dart';
import '../widgets/saved_places_body.dart';
import '../widgets/saved_places_map_sheet.dart';

class SavedPlacesScreen extends ConsumerStatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  ConsumerState<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends ConsumerState<SavedPlacesScreen> {
  late final TextEditingController _query;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController(
      text: ref.read(savedPlacesFilterProvider).query,
    );
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placesState = ref.watch(savedPlacesControllerProvider);
    final filter = ref.watch(savedPlacesFilterProvider);

    return AppScaffold(
      key: E2eKeys.savedPlacesScreenRoot,
      topBar: _TopBar(
        onBack: () => _back(context),
        onResetFilters: _resetFilters,
        onMap: _openMap,
      ),
      body: _body(placesState, filter),
    );
  }

  Widget _body(
    AsyncValue<SavedPlacesState> placesState,
    SavedPlacesFilterState filter,
  ) {
    if (!placesState.hasValue && placesState.isLoading) {
      return const _Skeleton();
    }
    if (placesState.hasError && !placesState.hasValue) {
      return _Failure(
        error: placesState.error!,
        onRetry: () =>
            ref.read(savedPlacesControllerProvider.notifier).refresh(),
      );
    }
    final places = placesState.requireValue;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: _refresh,
      child: SavedPlacesBody(
        places: places,
        filter: filter,
        queryController: _query,
        onQueryChanged: (value) =>
            ref.read(savedPlacesFilterProvider.notifier).setQuery(value),
        onSelectGroup: (group) =>
            ref.read(savedPlacesFilterProvider.notifier).selectGroup(group),
        onSelectCollection: _selectCollection,
        onCreateCollection: () => _createCollection(context),
        onUnsave: _unsave,
        onAddToTrip: _addToTrip,
        onShare: _share,
        onMore: _more,
        onLoadMore: () =>
            ref.read(savedPlacesControllerProvider.notifier).loadMore(),
        onRetryCollection: _retryCollection,
      ),
    );
  }

  void _resetFilters() {
    _query.clear();
    ref.read(savedPlacesFilterProvider.notifier).reset();
    ref.read(savedPlacesControllerProvider.notifier).syncCollection(null);
  }

  void _selectCollection(String id) {
    ref.read(savedPlacesFilterProvider.notifier).selectCollection(id);
    final selected = ref.read(savedPlacesFilterProvider).collectionId;
    ref.read(savedPlacesControllerProvider.notifier).syncCollection(selected);
  }

  void _retryCollection() {
    final selected = ref.read(savedPlacesFilterProvider).collectionId;
    ref.read(savedPlacesControllerProvider.notifier).syncCollection(selected);
  }

  void _openMap() {
    final places = ref.read(savedPlacesControllerProvider).value;
    final filter = ref.read(savedPlacesFilterProvider);
    if (places == null) return;
    final collection = places.selectedCollection;
    final showingCollection =
        filter.collectionId != null && collection?.id == filter.collectionId;
    final pins = savedPlaceMapPins(
      items: places.items,
      group: filter.group,
      query: filter.query,
      onlyPlaceIds: showingCollection
          ? collection!.places.map((item) => item.id).toSet()
          : null,
    );
    showAppBottomSheet<void>(
      context: context,
      child: SavedPlacesMapSheet(pins: pins),
    );
  }

  Future<void> _createCollection(BuildContext context) async {
    final name = await showAppBottomSheet<String>(
      context: context,
      child: const _CreateCollectionSheet(),
    );
    if (name == null || name.isEmpty || !context.mounted) return;
    final ok = await ref
        .read(savedPlacesControllerProvider.notifier)
        .createCollection(name);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tạo được bộ sưu tập.')),
      );
    }
  }

  Future<void> _refresh() async {
    final ok = await ref.read(savedPlacesControllerProvider.notifier).refresh();
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không làm mới được danh sách đã lưu.')),
      );
    }
  }

  Future<void> _addToTrip(SavedPlaceRow place) async {
    final added = await showAppBottomSheet<bool>(
      context: context,
      child: SavedPlaceAddTripSheet(place: place),
    );
    if (added == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã thêm vào lịch trình.')));
    }
  }

  Future<void> _unsave(SavedPlaceRow place) async {
    final ok = await ref
        .read(savedPlacesControllerProvider.notifier)
        .unsave(place.placeId);
    if (!ok && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không bỏ lưu được.')));
    }
  }

  Future<void> _share(SavedPlaceRow place) {
    final box = context.findRenderObject();
    final origin = box is RenderBox
        ? box.localToGlobal(Offset.zero) & box.size
        : null;
    return SharePlus.instance.share(
      ShareParams(
        text: savedPlaceShareText(place),
        sharePositionOrigin: origin,
      ),
    );
  }

  Future<void> _more(SavedPlaceRow place) async {
    final action = await showAppBottomSheet<String>(
      context: context,
      child: Builder(
        builder: (sheetContext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Chia sẻ'),
                onTap: () => Navigator.of(sheetContext).pop('share'),
              ),
              if (place.canUnsave)
                ListTile(
                  leading: const Icon(Icons.bookmark_remove_outlined),
                  title: const Text('Bỏ lưu'),
                  onTap: () => Navigator.of(sheetContext).pop('unsave'),
                ),
            ],
          );
        },
      ),
    );
    if (!mounted || action == null) return;
    if (action == 'share') {
      await _share(place);
      return;
    }
    await _unsave(place);
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onBack,
    required this.onResetFilters,
    required this.onMap,
  });

  final VoidCallback onBack;
  final VoidCallback onResetFilters;
  final VoidCallback onMap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.glass85,
        border: Border(bottom: BorderSide(color: AppColors.glassBorder)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              AppIconButton(
                icon: Icons.arrow_back_rounded,
                iconColor: AppColors.primary,
                semanticLabel: 'Quay lại hồ sơ',
                onPressed: onBack,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Điểm Đến Đã Lưu',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.screenTitle,
                    ),
                    Text(
                      'Hồ sơ cá nhân • Saved Bucket List',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              AppIconButton(
                icon: Icons.tune_rounded,
                semanticLabel: 'Đặt lại bộ lọc',
                onPressed: onResetFilters,
              ),
              const SizedBox(width: AppSpacing.xxs),
              AppIconButton(
                icon: Icons.map_outlined,
                iconColor: AppColors.primary,
                semanticLabel: 'Xem trên bản đồ',
                onPressed: onMap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: const [
        AppSkeleton(width: 220, height: 28),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 48),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 120),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 140),
      ],
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({required this.error, required this.onRetry});

  final Object error;
  final Future<bool> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = error;
    final unauthorized = failure is ApiException && failure.statusCode == 401;
    final message = unauthorized
        ? 'Đăng nhập lại để xem địa điểm đã lưu.'
        : failure is ApiException
        ? failure.message
        : 'Đã xảy ra lỗi. Vui lòng thử lại.';
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không thể tải địa điểm đã lưu',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : () => onRetry(),
    );
  }
}

class _CreateCollectionSheet extends StatefulWidget {
  const _CreateCollectionSheet();

  @override
  State<_CreateCollectionSheet> createState() => _CreateCollectionSheetState();
}

class _CreateCollectionSheetState extends State<_CreateCollectionSheet> {
  final _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _title.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Bộ sưu tập mới', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _title,
          hint: 'Tên bộ sưu tập',
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(label: 'Tạo', onPressed: _submit),
      ],
    );
  }
}

void _back(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }
  context.goNamed(RouteNames.profile);
}
