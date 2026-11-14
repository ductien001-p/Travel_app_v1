import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/networks/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_empty_view.dart';
import '../../../../core/widget/app_error_view.dart';
import '../../../../core/widget/app_loading.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../app/router/router_names.dart';
import '../../trip-itineraies/application/add_itinerary_activity_state.dart';
import '../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../../trip-itineraies/data/models/itinerary_models.dart';
import '../../trip-publish/presentation/recruitment_impact_dialog.dart';
import 'create_trip_flow_widgets.dart';

class CreateTripItineraryScreen extends ConsumerStatefulWidget {
  const CreateTripItineraryScreen({super.key, required this.tripId});
  final String tripId;

  @override
  ConsumerState<CreateTripItineraryScreen> createState() =>
      _CreateTripItineraryScreenState();
}

class _CreateTripItineraryScreenState
    extends ConsumerState<CreateTripItineraryScreen> {
  String? _selectedDayId;
  bool _mutating = false;

  @override
  Widget build(BuildContext context) {
    final itinerary = ref.watch(tripItineraryControllerProvider(widget.tripId));
    return AppScaffold(
      topBar: CreateTripHeader(
        step: 2,
        subtitle: 'Lịch trình & Hoạt động chi tiết',
        onBack: () => context.pop(),
        onCancel: () => context.go('/trips'),
      ),
      bottomNavigationBar: CreateTripBottomBar(
        primaryLabel: 'Tiếp tục: Mời thành viên →',
        secondaryLabel: 'Quay lại',
        loading: _mutating,
        onSecondary: () => context.pop(),
        onPrimary: () => context.push('/trips/create/${widget.tripId}/confirm'),
      ),
      body: itinerary.when(
        loading: () => const AppLoading(),
        error: (error, _) => AppErrorView(
          title: 'Không thể tải lịch trình',
          message: _errorMessage(error),
          onRetry: () => ref
              .read(tripItineraryControllerProvider(widget.tripId).notifier)
              .refresh(),
        ),
        data: (itineraryData) {
          final destinations = itineraryData.destinations;
          final days = destinations
              .expand(
                (destination) => destination.days.map(
                  (day) => (destination: destination, day: day),
                ),
              )
              .toList();
          if (days.isEmpty) {
            return const AppEmptyView(
              title: 'Chưa có ngày hành trình',
              description: 'Quay lại bước 1 để thêm điểm đến và ngày đi.',
              icon: Icons.calendar_month_outlined,
            );
          }
          final activeId = _selectedDayId ?? days.first.day.id;
          final selected = days.firstWhere(
            (entry) => entry.day.id == activeId,
            orElse: () => days.first,
          );
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.md,
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
            ),
            children: [
              _TripRouteSummary(
                destinations: destinations,
                onDeleteDestination: destinations.length > 1
                    ? (destination) => _deleteDestination(destination)
                    : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Lịch trình từng ngày', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.xs),
                  itemBuilder: (_, index) {
                    final entry = days[index];
                    final active = entry.day.id == selected.day.id;
                    return ChoiceChip(
                      selected: active,
                      label: Text(
                        'Ngày ${entry.day.dayNumber}  ${_shortDate(entry.day.date)}\n'
                        '${entry.destination.city}',
                      ),
                      onSelected: (_) =>
                          setState(() => _selectedDayId = entry.day.id),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _DaySummary(day: selected.day),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Danh sách hoạt động',
                      style: AppTypography.sectionTitle,
                    ),
                  ),
                  Text('${selected.day.activities.length} mục'),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              if (selected.day.activities.isEmpty)
                const AppEmptyView(
                  title: 'Ngày này chưa có hoạt động',
                  description: 'Thêm địa điểm đầu tiên để bắt đầu lịch trình.',
                  icon: Icons.route_outlined,
                )
              else
                _ActivityList(
                  activities: selected.day.activities,
                  canManage: itineraryData.canManageItinerary,
                  onDelete: _deleteActivity,
                  onReorder: (oldIndex, newIndex) =>
                      _reorder(selected.day, oldIndex, newIndex),
                ),
              if (itineraryData.canManageItinerary) ...[
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: _mutating
                      ? null
                      : () => _openActivityPicker(
                          destination: selected.destination,
                          day: selected.day,
                          canManageItinerary: itineraryData.canManageItinerary,
                        ),
                  icon: const Icon(Icons.add_circle_outline),
                  label: Text(
                    'Thêm địa điểm / hoạt động vào Ngày ${selected.day.dayNumber}',
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _openActivityPicker({
    required DestinationItinerary destination,
    required ItineraryDay day,
    required bool canManageItinerary,
  }) async {
    await context.pushNamed(
      RouteNames.addItineraryActivity,
      pathParameters: {'tripId': widget.tripId},
      extra: AddItineraryActivityArgs(
        tripId: widget.tripId,
        dayId: day.id,
        destinationId: destination.id,
        dayNumber: day.dayNumber,
        dayDate: day.date,
        city: destination.city,
        country: destination.country,
        insertionChoices: List.unmodifiable(day.activities),
        canManageItinerary: canManageItinerary,
      ),
    );
  }

  Future<void> _deleteActivity(String activityId) async {
    await _run(
      () => ref
          .read(tripItineraryControllerProvider(widget.tripId).notifier)
          .deleteActivity(activityId),
    );
  }

  Future<void> _deleteDestination(DestinationItinerary destination) async {
    final activityCount = destination.days.fold<int>(
      0,
      (sum, day) => sum + day.activities.length,
    );
    if (activityCount > 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Xóa hết hoạt động của điểm đến này trước khi gỡ khỏi chuyến.',
          ),
        ),
      );
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa điểm đến?'),
        content: Text(
          'Gỡ “${destination.city}” khỏi chuyến đi. Không thể hoàn tác.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await _run(() async {
      await _deleteDestinationWithAck(destination.id);
      if (mounted) setState(() => _selectedDayId = null);
      return null;
    });
  }

  Future<void> _deleteDestinationWithAck(String destinationId) async {
    final notifier = ref.read(
      tripItineraryControllerProvider(widget.tripId).notifier,
    );
    try {
      await notifier.deleteDestination(destinationId);
    } catch (error) {
      if (!isRecruitmentImpactAck(error)) rethrow;
      if (!mounted) return;
      final ok = await showRecruitmentImpactDialog(context);
      if (!ok) rethrow;
      await notifier.deleteDestination(
        destinationId,
        acknowledgeRecruitmentImpact: true,
      );
    }
  }

  Future<void> _reorder(ItineraryDay day, int oldIndex, int newIndex) async {
    final ids = day.activities.map((item) => item.id).toList();
    if (newIndex > oldIndex) newIndex--;
    final moved = ids.removeAt(oldIndex);
    ids.insert(newIndex, moved);
    await _run(
      () => ref
          .read(tripItineraryControllerProvider(widget.tripId).notifier)
          .reorderItems(day.id, ids),
    );
  }

  Future<void> _run(Future<Object?> Function() action) async {
    setState(() => _mutating = true);
    try {
      await action();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorMessage(error))));
      }
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }
}

class _TripRouteSummary extends StatelessWidget {
  const _TripRouteSummary({
    required this.destinations,
    this.onDeleteDestination,
  });
  final List<DestinationItinerary> destinations;
  final ValueChanged<DestinationItinerary>? onDeleteDestination;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.explore_outlined, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinations.map((item) => item.city).join(' → '),
                      style: AppTypography.cardTitle,
                    ),
                    Text(
                      '${destinations.first.startDate.day}/${destinations.first.startDate.month} – '
                      '${destinations.last.endDate.day}/${destinations.last.endDate.month}/${destinations.last.endDate.year}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (onDeleteDestination != null) ...[
            const SizedBox(height: AppSpacing.sm),
            for (final destination in destinations)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(destination.city),
                subtitle: Text(
                  '${destination.days.fold<int>(0, (n, d) => n + d.activities.length)} hoạt động',
                ),
                trailing: IconButton(
                  tooltip: 'Xóa điểm đến',
                  icon: const Icon(Icons.delete_outline),
                  color: AppColors.danger,
                  onPressed: () => onDeleteDestination!(destination),
                ),
              ),
          ],
        ],
      ),
    ),
  );
}

class _DaySummary extends StatelessWidget {
  const _DaySummary({required this.day});
  final ItineraryDay day;

  @override
  Widget build(BuildContext context) {
    final minutes = day.activities.fold<int>(
      0,
      (sum, item) => sum + (item.estimatedDuration ?? 0),
    );
    final cost = day.activities.fold<double>(
      0,
      (sum, item) => sum + (item.estimatedCost ?? 0),
    );
    return Card(
      color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${(minutes / 60).toStringAsFixed(1)} giờ hoạt động • '
                '${day.activities.length} điểm đến',
                style: AppTypography.cardTitle,
              ),
            ),
            Text('${cost.toStringAsFixed(0)}đ'),
          ],
        ),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  const _ActivityList({
    required this.activities,
    required this.canManage,
    required this.onDelete,
    required this.onReorder,
  });
  final List<ItineraryActivity> activities;
  final bool canManage;
  final ValueChanged<String> onDelete;
  final ReorderCallback onReorder;

  @override
  Widget build(BuildContext context) => ReorderableListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    buildDefaultDragHandles: canManage,
    itemCount: activities.length,
    onReorder: canManage ? onReorder : (_, _) {},
    itemBuilder: (_, index) {
      final activity = activities[index];
      return Card(
        key: ValueKey(activity.id),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox.square(
                  dimension: 76,
                  child: activity.place?.imageUrl == null
                      ? const ColoredBox(
                          color: AppColors.primaryLight,
                          child: Icon(
                            Icons.place_outlined,
                            color: AppColors.primary,
                          ),
                        )
                      : Image.network(
                          activity.place!.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(activity.title, style: AppTypography.cardTitle),
                    if (activity.startTime != null)
                      Text(_timeLabel(activity.startTime!)),
                    if (activity.place?.address != null)
                      Text(
                        activity.place!.address!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Text(
                      '${activity.estimatedDuration ?? 0} phút • '
                      '${activity.estimatedCost?.toStringAsFixed(0) ?? '0'}đ',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryActive,
                      ),
                    ),
                  ],
                ),
              ),
              if (canManage) ...[
                IconButton(
                  onPressed: () => onDelete(activity.id),
                  icon: const Icon(Icons.delete_outline),
                ),
                ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_indicator),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

String _shortDate(DateTime value) => '${value.day}/${value.month}';
String _timeLabel(DateTime value) =>
    '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
String _errorMessage(Object error) =>
    error is ApiException ? error.message : 'Đã xảy ra lỗi. Vui lòng thử lại.';
