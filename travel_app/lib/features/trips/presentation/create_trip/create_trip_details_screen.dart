import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/router/router_names.dart';
import '../../../../core/networks/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_chip.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_card.dart';
import '../../../../core/widget/app_loading.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../core/widget/app_text_field.dart';
import '../../application/create_trip_controller.dart';
import '../../application/device_location_controller.dart';
import '../../application/trip_cover_controller.dart';
import '../../application/trip_creation_support_controller.dart';
import '../../application/trip_interests_controller.dart';
import '../../data/models/create_trip.dart';
import '../../data/models/requets-create-trip/create_trip_destination_request.dart';
import '../../data/models/trip.dart';
import '../../data/models/trip_creation_models.dart';
import 'add_destination_screen.dart';
import 'create_trip_flow_widgets.dart';
import 'destination_map_overview.dart';
import 'trip_cover_picker.dart';

class CreateTripDetailsScreen extends ConsumerStatefulWidget {
  const CreateTripDetailsScreen({super.key});

  @override
  ConsumerState<CreateTripDetailsScreen> createState() =>
      _CreateTripDetailsScreenState();
}

class _CreateTripDetailsScreenState
    extends ConsumerState<CreateTripDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final List<AddDestinationResult> _destinations = [];
  final Set<String> _interestIds = {};
  String _tripType = 'FRIENDS';
  String _budgetLevel = 'MEDIUM';
  String _visibility = 'PUBLIC';
  int _maxMembers = 6;
  bool _submitting = false;
  int? _selectedDestinationIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(deviceLocationControllerProvider.notifier).locate();
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save({required bool continueFlow}) async {
    if (continueFlow && !(_formKey.currentState?.validate() ?? false)) return;
    if (continueFlow && _destinations.isEmpty) {
      _message('Hãy chọn ít nhất một điểm đến.');
      return;
    }
    final cover = ref.read(tripCoverControllerProvider);
    if (cover.isUploading) {
      _message('Ảnh bìa đang được tải lên, vui lòng đợi trong giây lát.');
      return;
    }
    if (continueFlow && cover.mediaId == null) {
      _message('Hãy thêm ảnh bìa cho chuyến đi.');
      return;
    }
    for (var index = 1; index < _destinations.length; index++) {
      if (!_destinations[index].startDate.isAfter(
        _destinations[index - 1].endDate,
      )) {
        _message(
          'Ngày đến ${_destinations[index].item.name} phải sau ngày rời '
          '${_destinations[index - 1].item.name}.',
        );
        return;
      }
    }
    setState(() => _submitting = true);
    try {
      final request = CreateTripDraftRequest(
        name: _trimmedOrNull(_name.text),
        description: _trimmedOrNull(_description.text),
        tripType: _tripType,
        budgetLevel: _budgetLevel,
        maxMembers: _maxMembers,
        visibility: _visibility,
        interestIds: _interestIds.toList(growable: false),
        coverMediaId: cover.mediaId,
        destinations: _destinations
            .asMap()
            .entries
            .map(
              (entry) => CreateTripDestinationRequest(
                destinationId: entry.value.item.id,
                city: entry.value.item.name,
                country: entry.value.item.country,
                latitude: entry.value.item.lat,
                longitude: entry.value.item.lng,
                order: entry.key + 1,
                startDate: entry.value.startDate,
                endDate: entry.value.endDate,
                pendingPlaceIds: entry.value.pendingPlaces
                    .map((place) => place.id)
                    .toList(growable: false),
              ),
            )
            .toList(growable: false),
      );
      final Trip trip = await ref
          .read(createTripControllerProvider.notifier)
          .saveDraft(request);
      if (!mounted) return;
      if (continueFlow) {
        context.push('/trips/create/${trip.id}/itinerary');
      } else {
        _message('Đã lưu bản nháp.');
        context.go('/trips');
      }
    } catch (error) {
      if (mounted) _message(_errorMessage(error));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final interests = ref.watch(tripInterestsControllerProvider);
    final currentLocation = ref
        .watch(deviceLocationControllerProvider)
        .asData
        ?.value;
    final cover = ref.watch(tripCoverControllerProvider);
    return AppScaffold(
      topBar: CreateTripHeader(
        step: 1,
        subtitle: 'Thông tin chung & Điểm đến',
        onBack: () => context.pop(),
        onCancel: () => context.go('/trips'),
      ),
      bottomNavigationBar: CreateTripBottomBar(
        primaryLabel: 'Tiếp tục: Lên lịch trình →',
        secondaryLabel: 'Lưu nháp',
        loading: _submitting,
        onPrimary: () => _save(continueFlow: true),
        onSecondary: () => _save(continueFlow: false),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.xl,
          ),
          children: [
            CreateTripSection(
              title: 'Ảnh bìa *',
              subtitle: 'Ảnh đại diện cho hành trình của bạn',
              icon: Icons.image_outlined,
              child: TripCoverPicker(
                state: cover,
                onPick: _pickCover,
                onRetry: ref.read(tripCoverControllerProvider.notifier).retry,
                onRemove: ref.read(tripCoverControllerProvider.notifier).clear,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            CreateTripSection(
              title: 'Thông tin cơ bản',
              subtitle: 'Đặt tên & thiết lập phong cách du lịch',
              icon: Icons.luggage_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    controller: _name,
                    label: 'Tên chuyến đi *',
                    hint: 'Mùa hè rực rỡ xuyên miền Trung 2025',
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return 'Tên chuyến đi là bắt buộc.';
                      if (text.length > 80) return 'Tên tối đa 80 ký tự.';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    controller: _description,
                    label: 'Mô tả hành trình',
                    hint: 'Mô tả ngắn về kế hoạch và phong cách du lịch...',
                    minLines: 3,
                    maxLines: 4,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _Label('Kiểu chuyến đi'),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children:
                        const {
                              'FRIENDS': (
                                'Đi cùng bạn bè',
                                Icons.groups_outlined,
                              ),
                              'SOLO': ('Solo', Icons.person_outline),
                              'COUPLE': ('Cặp đôi', Icons.favorite_border),
                              'BACKPACKER': (
                                'Phượt tự do',
                                Icons.hiking_outlined,
                              ),
                              'FAMILY': (
                                'Gia đình',
                                Icons.family_restroom_outlined,
                              ),
                              'OTHER': ('Khác', Icons.more_horiz),
                            }.entries
                            .map(
                              (entry) => AppChip(
                                label: entry.value.$1,
                                leadingIcon: entry.value.$2,
                                selected: _tripType == entry.key,
                                onTap: () =>
                                    setState(() => _tripType = entry.key),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _Label('Mức kinh phí'),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'LOW', label: Text('Tiết kiệm')),
                      ButtonSegment(value: 'MEDIUM', label: Text('Tiêu chuẩn')),
                      ButtonSegment(value: 'HIGH', label: Text('Cao cấp')),
                    ],
                    selected: {_budgetLevel},
                    onSelectionChanged: (value) =>
                        setState(() => _budgetLevel = value.first),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const _Label('Số lượng thành viên tối đa'),
                  _MemberCounter(
                    value: _maxMembers,
                    onDecrease: _maxMembers > 1
                        ? () => setState(() => _maxMembers--)
                        : null,
                    onIncrease: _maxMembers < 100
                        ? () => setState(() => _maxMembers++)
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            CreateTripSection(
              title: 'Điểm đến trong chuyến đi',
              subtitle:
                  '${_destinations.length} chặng dừng chân đã lên kế hoạch',
              icon: Icons.map_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DestinationMapOverview(
                    stops: _destinations
                        .map(
                          (value) => DestinationMapStop(
                            id: value.item.id,
                            name: value.item.name,
                            country: value.item.country,
                            latitude: value.item.lat,
                            longitude: value.item.lng,
                          ),
                        )
                        .toList(growable: false),
                    currentLocation: currentLocation == null
                        ? null
                        : LatLng(
                            currentLocation.latitude,
                            currentLocation.longitude,
                          ),
                    highlightedIndex: _selectedDestinationIndex,
                    onStopTap: (index) =>
                        setState(() => _selectedDestinationIndex = index),
                  ),
                  if (_selectedDestinationIndex case final index?
                      when index >= 0 && index < _destinations.length) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _SelectedDestinationDetails(
                      index: index,
                      value: _destinations[index],
                      onEdit: () => _editDestinationDates(index),
                      onDelete: () => setState(() {
                        _destinations.removeAt(index);
                        _selectedDestinationIndex = null;
                      }),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Thêm điểm đến',
                    leadingIcon: Icons.add_location_alt_outlined,
                    variant: AppButtonVariant.secondary,
                    onPressed: _openAddDestination,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            CreateTripSection(
              title: 'Sở thích chuyến đi',
              subtitle: 'Giúp gợi ý hoạt động và bạn đồng hành',
              icon: Icons.interests_outlined,
              trailing: Text(
                '${_interestIds.length} đã chọn',
                style: AppTypography.badge.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
              child: interests.when(
                loading: () => const AppLoading(),
                error: (error, _) =>
                    Text(_errorMessage(error), style: AppTypography.body),
                data: (items) {
                  if (items.isEmpty) {
                    return const Text(
                      'Chưa có dữ liệu sở thích chuyến đi từ hệ thống.',
                      style: AppTypography.body,
                    );
                  }
                  return Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: items
                        .map(
                          (item) => AppChip(
                            label: item.name,
                            leadingIcon: Icons.interests_outlined,
                            selected: _interestIds.contains(item.id),
                            onTap: () => setState(() {
                              if (!_interestIds.add(item.id)) {
                                _interestIds.remove(item.id);
                              }
                            }),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            CreateTripSection(
              title: 'Quyền riêng tư & Hiển thị',
              subtitle: 'Ai có thể thấy hành trình này?',
              icon: Icons.visibility_outlined,
              child: Column(
                children: [
                  ListTile(
                    selected: _visibility == 'PUBLIC',
                    onTap: () => setState(() => _visibility = 'PUBLIC'),
                    leading: Icon(
                      _visibility == 'PUBLIC'
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                    ),
                    title: const Text('Công khai (PUBLIC)'),
                    subtitle: const Text(
                      'Mọi người có thể khám phá hành trình.',
                    ),
                  ),
                  ListTile(
                    selected: _visibility == 'PRIVATE',
                    onTap: () => setState(() => _visibility = 'PRIVATE'),
                    leading: Icon(
                      _visibility == 'PRIVATE'
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                    ),
                    title: const Text('Riêng tư (PRIVATE)'),
                    subtitle: const Text(
                      'Chỉ những bạn được mời mới xem chi tiết.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addDestination(List<DestinationCatalogItem> items) async {
    final selected = await context.pushNamed<AddDestinationResult>(
      RouteNames.addTripDestination,
      extra: AddDestinationRouteData(
        existingDestinationNames: _destinations
            .map((value) => value.item.name)
            .toList(growable: false),
        existingDestinationIds: _destinations
            .map((value) => value.item.id)
            .toList(growable: false),
        existingDestinations: _destinations
            .map((value) => value.item)
            .toList(growable: false),
      ),
    );
    if (selected != null) {
      setState(() {
        _destinations.add(selected);
        _selectedDestinationIndex = _destinations.length - 1;
      });
    }
  }

  Future<void> _openAddDestination() async {
    try {
      final items = await ref.read(destinationCatalogProvider(null).future);
      if (!mounted) return;
      await _addDestination(items);
    } catch (error) {
      if (!mounted) return;
      _message(_errorMessage(error));
      ref.invalidate(destinationCatalogProvider(null));
    }
  }

  Future<void> _pickCover() async {
    final XFile? file;
    try {
      file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        imageQuality: 85,
      );
    } catch (_) {
      if (mounted) _message('Không thể mở thư viện ảnh.');
      return;
    }
    if (file == null || !mounted) return;
    try {
      await ref.read(tripCoverControllerProvider.notifier).select(file);
    } on TripCoverException catch (error) {
      if (mounted) _message(error.message);
    }
  }

  void _message(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  Future<void> _editDestinationDates(int index) async {
    final destination = _destinations[index];
    final range = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: destination.startDate,
        end: destination.endDate,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      helpText: 'Chỉnh sửa ngày tại ${destination.item.name}',
    );
    if (range == null) return;
    if (index > 0 && !range.start.isAfter(_destinations[index - 1].endDate)) {
      _message(
        'Ngày đến phải sau ngày rời ${_destinations[index - 1].item.name}.',
      );
      return;
    }
    if (index < _destinations.length - 1 &&
        !range.end.isBefore(_destinations[index + 1].startDate)) {
      _message(
        'Ngày rời phải trước ngày đến ${_destinations[index + 1].item.name}.',
      );
      return;
    }
    setState(() {
      _destinations[index] = AddDestinationResult(
        destination.item,
        range.start,
        range.end,
        destination.pendingPlaces,
      );
    });
  }
}

class _MemberCounter extends StatelessWidget {
  const _MemberCounter({
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int value;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) => Container(
    height: 44,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
    decoration: BoxDecoration(
      color: AppColors.surfaceSubdued,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      border: Border.all(color: AppColors.borderBrandSoft),
    ),
    child: Row(
      children: [
        _CounterButton(
          icon: Icons.remove_rounded,
          onPressed: onDecrease,
          filled: false,
          semanticLabel: 'Giảm số lượng thành viên',
        ),
        Expanded(
          child: Text(
            '$value thành viên',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _CounterButton(
          icon: Icons.add_rounded,
          onPressed: onIncrease,
          filled: true,
          semanticLabel: 'Tăng số lượng thành viên',
        ),
      ],
    ),
  );
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.icon,
    required this.onPressed,
    required this.filled,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: semanticLabel,
    child: SizedBox.square(
      dimension: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: filled ? AppColors.primary : AppColors.surface,
          foregroundColor: filled
              ? AppColors.textInverse
              : AppColors.textSecondary,
          disabledBackgroundColor: filled
              ? AppColors.primaryLight
              : AppColors.surface,
          side: filled
              ? BorderSide.none
              : const BorderSide(color: AppColors.borderNeutral),
        ),
        icon: Icon(icon, size: 18),
      ),
    ),
  );
}

class _SelectedDestinationDetails extends StatelessWidget {
  const _SelectedDestinationDetails({
    required this.index,
    required this.value,
    required this.onEdit,
    required this.onDelete,
  });

  final int index;
  final AddDestinationResult value;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.warning,
              foregroundColor: Colors.white,
              child: Text('${index + 1}'),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value.item.name, style: AppTypography.cardTitle),
                  Text(
                    value.item.country,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Điểm dừng #${index + 1}',
          style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          '${_date(value.startDate)} → ${_date(value.endDate)}',
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Chỉnh sửa',
                leadingIcon: Icons.edit_outlined,
                variant: AppButtonVariant.secondary,
                onPressed: onEdit,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: 'Xóa',
                leadingIcon: Icons.delete_outline,
                variant: AppButtonVariant.destructive,
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
    child: Text(
      text,
      style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700),
    ),
  );
}

String _date(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
String? _trimmedOrNull(String value) =>
    value.trim().isEmpty ? null : value.trim();
String _errorMessage(Object error) =>
    error is ApiException ? error.message : 'Đã xảy ra lỗi. Vui lòng thử lại.';
