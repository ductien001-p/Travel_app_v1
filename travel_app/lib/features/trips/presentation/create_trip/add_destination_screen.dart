import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/location/device_location_service.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_card.dart';
import '../../../../core/widget/app_empty_view.dart';
import '../../../../core/widget/app_error_view.dart';
import '../../../../core/widget/app_icon_button.dart';
import '../../../../core/widget/app_loading.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../application/trip_creation_support_controller.dart';
import '../../application/device_location_controller.dart';
import '../../data/models/trip_creation_models.dart';
import 'destination_map_overview.dart';

class AddDestinationRouteData {
  const AddDestinationRouteData({
    required this.existingDestinationNames,
    required this.existingDestinationIds,
    required this.existingDestinations,
  });
  final List<String> existingDestinationNames;
  final List<String> existingDestinationIds;
  final List<DestinationCatalogItem> existingDestinations;
}

class AddDestinationResult {
  const AddDestinationResult(
    this.item,
    this.startDate,
    this.endDate,
    this.pendingPlaces,
  );
  final DestinationCatalogItem item;
  final DateTime startDate;
  final DateTime endDate;
  final List<PlanningPlace> pendingPlaces;
}

class AddDestinationScreen extends ConsumerStatefulWidget {
  const AddDestinationScreen({super.key, required this.data});
  final AddDestinationRouteData data;

  @override
  ConsumerState<AddDestinationScreen> createState() =>
      _AddDestinationScreenState();
}

class _AddDestinationScreenState extends ConsumerState<AddDestinationScreen> {
  final _searchController = TextEditingController();
  DestinationCatalogItem? _selected;
  DateTime? _startDate;
  DateTime? _endDate;
  String _query = '';
  final Map<String, PlanningPlace> _pendingPlaces = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(deviceLocationControllerProvider.notifier).locate();
    });
  }

  int get _stopNumber => widget.data.existingDestinationNames.length + 1;
  List<DestinationCatalogItem> _results(
    List<DestinationCatalogItem> destinations,
  ) {
    final query = _query.trim().toLowerCase();
    final existingIds = widget.data.existingDestinationIds.toSet();
    return destinations
        .where((item) {
          return !existingIds.contains(item.id) &&
              (query.isEmpty ||
                  item.name.toLowerCase().contains(query) ||
                  item.country.toLowerCase().contains(query) ||
                  item.highlights.any(
                    (value) => value.toLowerCase().contains(query),
                  ));
        })
        .toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reset() {
    _searchController.clear();
    setState(() {
      _query = '';
      _selected = null;
      _startDate = null;
      _endDate = null;
      _pendingPlaces.clear();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _query = '';
      _selected = null;
    });
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateUtils.dateOnly(DateTime.now());
    final firstDate = isStart ? now : (_startDate ?? now);
    final initialDate = isStart
        ? (_startDate ?? now)
        : (_endDate ?? _startDate ?? now);
    final value = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (value == null) return;
    setState(() {
      if (isStart) {
        _startDate = value;
        if (_endDate != null && _endDate!.isBefore(value)) _endDate = null;
      } else {
        _endDate = value;
      }
    });
  }

  void _select(DestinationCatalogItem item) {
    _searchController.text = '${item.name}, ${item.country}';
    setState(() {
      _selected = item;
      _query = _searchController.text;
    });
  }

  void _confirm() {
    if (_selected == null || _startDate == null || _endDate == null) return;
    context.pop(
      AddDestinationResult(
        _selected!,
        _startDate!,
        _endDate!,
        _pendingPlaces.values.toList(growable: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(destinationCatalogProvider(null));
    final locationState = ref.watch(deviceLocationControllerProvider);
    final currentLocation = locationState.asData?.value;
    ref.listen(deviceLocationControllerProvider, (previous, next) {
      if (!next.hasError || previous?.error == next.error) return;
      final error = next.error;
      final message = error is DeviceLocationException
          ? switch (error.failure) {
              DeviceLocationFailure.serviceDisabled =>
                'Dịch vụ vị trí đang tắt.',
              DeviceLocationFailure.denied => 'Quyền vị trí đã bị từ chối.',
              DeviceLocationFailure.deniedForever =>
                'Quyền vị trí bị từ chối vĩnh viễn. Hãy mở Cài đặt để cấp quyền.',
              DeviceLocationFailure.unavailable =>
                'Không thể lấy vị trí hiện tại.',
            }
          : 'Không thể lấy vị trí hiện tại.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    });
    return AppScaffold(
      topBar: _Header(
        stopNumber: _stopNumber,
        onClose: () => context.pop(),
        onReset: _reset,
        onLocation: locationState.isLoading
            ? null
            : () =>
                  ref.read(deviceLocationControllerProvider.notifier).locate(),
      ),
      bottomNavigationBar: _BottomBar(
        stopNumber: _stopNumber,
        canConfirm: _selected != null && _startDate != null && _endDate != null,
        onConfirm: _confirm,
      ),
      body: catalog.when(
        loading: () => const AppLoading(message: 'Đang tải điểm đến...'),
        error: (error, _) => AppErrorView(
          title: 'Không thể tải điểm đến',
          message: 'Vui lòng kiểm tra kết nối và thử lại.',
          onRetry: () => ref.invalidate(destinationCatalogProvider(null)),
        ),
        data: (destinations) {
          final available = destinations
              .where(
                (item) => !widget.data.existingDestinationIds.contains(item.id),
              )
              .toList(growable: false);
          if (available.isEmpty) {
            return const AppEmptyView(
              title: 'Không còn điểm đến để thêm',
              description:
                  'Danh mục hiện không có điểm đến mới phù hợp với hành trình.',
              icon: Icons.location_off_outlined,
            );
          }
          final mapDestinations = [
            ...widget.data.existingDestinations,
            if (_selected != null) _selected!,
          ];
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              AppSpacing.safeBottom,
            ),
            children: [
              _DestinationSearch(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                onClear: _query.isEmpty ? null : _clearSearch,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: _FilterChip(
                  label: 'Tất cả',
                  icon: '🔥',
                  selected: true,
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              DestinationMapOverview(
                stops: mapDestinations
                    .map(
                      (item) => DestinationMapStop(
                        id: item.id,
                        name: item.name,
                        country: item.country,
                        latitude: item.lat,
                        longitude: item.lng,
                      ),
                    )
                    .toList(growable: false),
                currentLocation: currentLocation == null
                    ? null
                    : LatLng(
                        currentLocation.latitude,
                        currentLocation.longitude,
                      ),
                highlightedIndex: _selected == null
                    ? null
                    : mapDestinations.length - 1,
              ),
              const SizedBox(height: 32),
              if (_selected == null)
                _DestinationResults(
                  items: _results(available),
                  onSelect: _select,
                )
              else ...[
                _SelectedDestinationCard(
                  destination: _selected!,
                  startDate: _startDate,
                  endDate: _endDate,
                  stopNumber: _stopNumber,
                  existingDestinationNames:
                      widget.data.existingDestinationNames,
                  onStartDate: () => _pickDate(isStart: true),
                  onEndDate: _startDate == null
                      ? null
                      : () => _pickDate(isStart: false),
                ),
                const SizedBox(height: 32),
                _PlacesSection(
                  destination: _selected!,
                  selectedIds: _pendingPlaces.keys.toSet(),
                  onToggle: (place) => setState(() {
                    if (_pendingPlaces.remove(place.id) == null) {
                      _pendingPlaces[place.id] = place;
                    }
                  }),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.stopNumber,
    required this.onClose,
    required this.onReset,
    required this.onLocation,
  });
  final int stopNumber;
  final VoidCallback onClose;
  final VoidCallback onReset;
  final VoidCallback? onLocation;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(20, 8, 12, 12),
    decoration: const BoxDecoration(
      color: AppColors.glass85,
      border: Border(bottom: BorderSide(color: AppColors.borderBrandSoft)),
    ),
    child: Row(
      children: [
        AppIconButton(
          icon: Icons.close_rounded,
          onPressed: onClose,
          semanticLabel: 'Đóng',
          backgroundColor: AppColors.surfaceSubdued,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thêm Điểm Đến Mới',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.screenTitle.copyWith(fontSize: 23),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Chặng dừng thứ $stopNumber của hành trình',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryActive,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppIconButton(
          icon: Icons.my_location_rounded,
          onPressed: onLocation,
          semanticLabel: 'Dùng vị trí hiện tại',
          backgroundColor: AppColors.primaryLight,
          iconColor: AppColors.primaryActive,
        ),
        TextButton(
          onPressed: onReset,
          child: Text(
            'Đặt lại',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ),
      ],
    ),
  );
}

class _DestinationSearch extends StatelessWidget {
  const _DestinationSearch({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) => Container(
    height: 58,
    decoration: BoxDecoration(
      color: AppColors.surfaceSubdued,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      border: Border.all(color: AppColors.borderBrandSoft),
    ),
    child: Row(
      children: [
        const SizedBox(width: 20),
        const Icon(Icons.search_rounded, color: AppColors.primary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontSize: 15,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Tìm thành phố, tỉnh thành hoặc địa danh',
              isCollapsed: true,
            ),
          ),
        ),
        if (onClear != null)
          IconButton(
            onPressed: onClear,
            icon: const Icon(Icons.cancel, size: 22),
            color: AppColors.textTertiary,
            tooltip: 'Xóa tìm kiếm',
          )
        else
          const SizedBox(width: 16),
      ],
    ),
  );
}

class _DestinationResults extends StatelessWidget {
  const _DestinationResults({required this.items, required this.onSelect});
  final List<DestinationCatalogItem> items;
  final ValueChanged<DestinationCatalogItem> onSelect;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty)
      return const AppCard(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(child: Text('Không tìm thấy điểm đến phù hợp.')),
        ),
      );
    return AppCard(
      padding: const EdgeInsets.all(16),
      radius: AppRadius.hero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chọn điểm đến', style: AppTypography.sectionTitle),
          const SizedBox(height: 8),
          ...items.map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: _DestinationImage(url: item.coverImageUrl, size: 56),
              title: Text(item.name, style: AppTypography.cardTitle),
              subtitle: Text(item.country, style: AppTypography.caption),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primary,
              ),
              onTap: () => onSelect(item),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedDestinationCard extends StatelessWidget {
  const _SelectedDestinationCard({
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.stopNumber,
    required this.existingDestinationNames,
    required this.onStartDate,
    required this.onEndDate,
  });
  final DestinationCatalogItem destination;
  final DateTime? startDate;
  final DateTime? endDate;
  final int stopNumber;
  final List<String> existingDestinationNames;
  final VoidCallback onStartDate;
  final VoidCallback? onEndDate;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.all(24),
    radius: AppRadius.hero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DestinationImage(url: destination.coverImageUrl, size: 94),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TypeBadge('ĐIỂM ĐẾN CHỌN LỌC'),
                  const SizedBox(height: 4),
                  Text(destination.name, style: AppTypography.sectionTitle),
                  Text(
                    destination.country,
                    style: AppTypography.body.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: AppColors.primaryActive,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${destination.lat.toStringAsFixed(4)}° N, ${destination.lng.toStringAsFixed(4)}° E',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.verified_outlined,
              color: AppColors.primaryActive,
              size: 24,
            ),
          ],
        ),
        const Divider(height: 38, color: AppColors.borderNeutral),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.primaryActive,
              size: 21,
            ),
            const SizedBox(width: 8),
            Text('Thời gian lưu trú', style: AppTypography.cardTitle),
            const Spacer(),
            if (startDate != null && endDate != null)
              _TypeBadge(
                '${endDate!.difference(startDate!).inDays + 1} ngày • ${endDate!.difference(startDate!).inDays} đêm',
              ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _DateField(
                label: 'Ngày đến\n(startDate)',
                value: startDate,
                onTap: onStartDate,
                isArrival: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DateField(
                label: 'Ngày đi (endDate)',
                value: endDate,
                onTap: onEndDate,
                isArrival: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.borderBrandSoft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.alt_route_rounded,
                    color: AppColors.primaryActive,
                    size: 21,
                  ),
                  const SizedBox(width: 8),
                  Text('Thứ tự chặng', style: AppTypography.cardTitle),
                  const Spacer(),
                  const _RoundIcon(icon: Icons.arrow_upward_rounded),
                  const SizedBox(width: 6),
                  const _RoundIcon(icon: Icons.arrow_downward_rounded),
                ],
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...existingDestinationNames.asMap().entries.expand(
                      (entry) => [
                        _StopChip(number: entry.key + 1, name: entry.value),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.textTertiary,
                          size: 18,
                        ),
                      ],
                    ),
                    _StopChip(
                      number: stopNumber,
                      name: '${destination.name} (Mới)',
                      selected: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PlacesSection extends ConsumerWidget {
  const _PlacesSection({
    required this.destination,
    required this.selectedIds,
    required this.onToggle,
  });

  final DestinationCatalogItem destination;
  final Set<String> selectedIds;
  final ValueChanged<PlanningPlace> onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = (catalogId: destination.id, category: null as String?);
    final result = ref.watch(catalogPlacesProvider(query));
    return result.when(
      loading: () => const AppLoading(message: 'Đang tải địa điểm...'),
      error: (error, _) => AppErrorView(
        title: 'Không thể tải địa điểm',
        message: 'Vui lòng thử lại.',
        onRetry: () => ref.invalidate(catalogPlacesProvider(query)),
      ),
      data: (page) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khám phá tiêu biểu tại ${destination.name}',
                      style: AppTypography.sectionTitle,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Thêm nhanh vào danh sách kế hoạch sau',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tất cả (${page.total})',
                style: AppTypography.badge.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (page.items.isEmpty)
            const AppEmptyView(
              title: 'Chưa có địa điểm',
              description: 'Không có Place đã duyệt trong khu vực này.',
              icon: Icons.place_outlined,
            )
          else
            SizedBox(
              height: 232,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: page.items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final place = page.items[index];
                  return _PlaceCard(
                    place: place,
                    selected: selectedIds.contains(place.id),
                    onToggle: () => onToggle(place),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({
    required this.place,
    required this.selected,
    required this.onToggle,
  });

  final PlanningPlace place;
  final bool selected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) => Container(
    width: 176,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.cardLarge),
      border: Border.all(color: AppColors.borderBrandSoft),
      boxShadow: AppShadows.level1,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 112,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (place.thumbnailUrl == null || place.thumbnailUrl!.isEmpty)
                const ColoredBox(
                  color: AppColors.primaryLight,
                  child: Icon(
                    Icons.place_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                )
              else
                Image.network(
                  place.thumbnailUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: AppColors.primaryLight,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 144),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.76),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    place.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textInverse,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  place.description?.trim().isNotEmpty == true
                      ? place.description!
                      : place.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(fontSize: 11),
                ),
                const Spacer(),
                const Divider(height: 1, color: AppColors.borderNeutral),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 15,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      place.averageRating?.toStringAsFixed(1) ?? '—',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.warning,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    Material(
                      color: selected
                          ? AppColors.primary
                          : AppColors.primaryLight,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onToggle,
                        customBorder: const CircleBorder(),
                        child: SizedBox.square(
                          dimension: 26,
                          child: Icon(
                            selected ? Icons.check_rounded : Icons.add_rounded,
                            size: 16,
                            color: selected
                                ? AppColors.textInverse
                                : AppColors.primaryActive,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.stopNumber,
    required this.canConfirm,
    required this.onConfirm,
  });
  final int stopNumber;
  final bool canConfirm;
  final VoidCallback onConfirm;
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: const BoxDecoration(
        color: AppColors.glass90,
        border: Border(top: BorderSide(color: AppColors.borderNeutral)),
        boxShadow: AppShadows.level2,
      ),
      child: Row(
        children: [
          const AppButton(
            label: 'Gợi ý AI',
            onPressed: null,
            variant: AppButtonVariant.glass,
            leadingIcon: Icons.smart_toy_outlined,
            expand: false,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              label: 'Xác nhận & Thêm chặng $stopNumber',
              onPressed: canConfirm ? onConfirm : null,
              trailingIcon: Icons.arrow_forward_rounded,
            ),
          ),
        ],
      ),
    ),
  );
}

class _DestinationImage extends StatelessWidget {
  const _DestinationImage({required this.url, required this.size});
  final String? url;
  final double size;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(AppRadius.image),
    child: SizedBox.square(
      dimension: size,
      child: url == null || url!.isEmpty
          ? const ColoredBox(
              color: AppColors.primaryLight,
              child: Icon(
                Icons.location_city_outlined,
                color: AppColors.primary,
              ),
            )
          : Image.network(
              url!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const ColoredBox(
                color: AppColors.primaryLight,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
    ),
  );
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
    required this.isArrival,
  });
  final String label;
  final DateTime? value;
  final VoidCallback? onTap;
  final bool isArrival;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.card),
    child: Container(
      constraints: const BoxConstraints(minHeight: 122),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.body.copyWith(color: AppColors.textTertiary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  value == null ? 'Chọn ngày' : _date(value!),
                  maxLines: 1,
                  style: AppTypography.cardTitle.copyWith(fontSize: 18),
                ),
              ),
              Icon(
                isArrival ? Icons.event_outlined : Icons.edit_calendar_outlined,
                size: 20,
                color: AppColors.primary,
              ),
            ],
          ),
          if (value != null) ...[
            const SizedBox(height: 8),
            Text(_weekday(value!), style: AppTypography.caption),
          ],
        ],
      ),
    ),
  );
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String icon;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ActionChip(
    avatar: Text(icon, style: const TextStyle(fontSize: 13)),
    label: Text(label),
    onPressed: onTap,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    backgroundColor: selected
        ? AppColors.primaryActive
        : AppColors.primaryLight,
    side: BorderSide(
      color: selected ? AppColors.primaryActive : AppColors.borderBrandSoft,
    ),
    shape: const StadiumBorder(),
    labelStyle: AppTypography.badge.copyWith(
      color: selected ? AppColors.textInverse : AppColors.textSecondary,
    ),
  );
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFF9CEDE7),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Text(
      label,
      style: AppTypography.badge.copyWith(color: AppColors.primaryActive),
    ),
  );
}

class _StopChip extends StatelessWidget {
  const _StopChip({
    required this.number,
    required this.name,
    this.selected = false,
  });
  final int number;
  final String name;
  final bool selected;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: selected ? AppColors.primaryLight : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      border: selected ? Border.all(color: AppColors.borderBrandSoft) : null,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : const Color(0xFFDCE9EC),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: AppTypography.caption.copyWith(
              color: selected ? AppColors.textInverse : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: AppTypography.bodyMedium.copyWith(
            color: selected ? AppColors.primaryActive : AppColors.textTertiary,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    width: 34,
    height: 34,
    decoration: const BoxDecoration(
      color: AppColors.surfaceSubdued,
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: 19, color: AppColors.textSecondary),
  );
}

String _date(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
String _weekday(DateTime value) => const [
  'Thứ hai',
  'Thứ ba',
  'Thứ tư',
  'Thứ năm',
  'Thứ sáu',
  'Thứ bảy',
  'Chủ nhật',
][value.weekday - 1];
