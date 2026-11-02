import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widget/app_bottom_sheet.dart';
import '../../../../core/widget/app_error_view.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../trip-itineraies/application/add_itinerary_activity_controller.dart';
import '../../trip-itineraies/application/add_itinerary_activity_state.dart';
import 'add_itinerary_activity_widgets.dart';

class AddItineraryActivityScreen extends ConsumerStatefulWidget {
  const AddItineraryActivityScreen({super.key, required this.args});
  final AddItineraryActivityArgs args;

  @override
  ConsumerState<AddItineraryActivityScreen> createState() =>
      _AddItineraryActivityScreenState();
}

class _AddItineraryActivityScreenState
    extends ConsumerState<AddItineraryActivityScreen> {
  final _query = TextEditingController();
  final _title = TextEditingController();
  final _duration = TextEditingController();
  final _cost = TextEditingController();
  final _notes = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    _title.dispose();
    _duration.dispose();
    _cost.dispose();
    _notes.dispose();
    super.dispose();
  }

  AddItineraryActivityController get _controller =>
      ref.read(addItineraryActivityControllerProvider(widget.args).notifier);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      addItineraryActivityControllerProvider(widget.args),
    );
    if (!widget.args.hasValidContext) {
      return AppScaffold(
        body: AppErrorView(
          title: 'Không thể mở biểu mẫu',
          message: 'Thông tin ngày hành trình không hợp lệ.',
          onRetry: context.pop,
          actionLabel: 'Quay lại',
        ),
      );
    }
    if (!widget.args.canManageItinerary) {
      return AppScaffold(
        body: AppErrorView(
          title: 'Không có quyền quản lý lịch trình',
          message:
              'Chỉ Owner hoặc Admin đang hoạt động mới có thể quản lý hoạt động.',
          onRetry: context.pop,
          actionLabel: 'Quay lại',
        ),
      );
    }

    _syncController(_title, state.title);
    if (state.notes.isNotEmpty && _notes.text.isEmpty) {
      _syncController(_notes, state.notes);
    }
    if (state.estimatedDurationMinutes != null && _duration.text.isEmpty) {
      _syncController(_duration, state.estimatedDurationMinutes.toString());
    }
    if (state.estimatedCost != null && _cost.text.isEmpty) {
      _syncController(_cost, state.estimatedCost.toString());
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleClose();
      },
      child: AppScaffold(
        topBar: AddActivityTaskHeader(
          dayNumber: widget.args.dayNumber,
          dayDate: widget.args.dayDate,
          city: widget.args.city,
          country: widget.args.country,
          onClose: _handleClose,
        ),
        bottomNavigationBar: AddActivityActionDock(
          dayNumber: widget.args.dayNumber,
          canSubmit: state.canSubmit,
          isSubmitting: state.isSubmitting,
          onSubmit: _submit,
          onSaveDraft: _saveDraft,
        ),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
            AppSpacing.screenHorizontal,
            AppSpacing.safeBottom,
          ),
          children: [
            ActivityPlaceSection(
              queryController: _query,
              query: state.query,
              selectedCategory: state.selectedCategory,
              results: state.searchResults,
              selectedPlace: state.selectedPlace,
              loading: state.isSearchingPlaces,
              error: state.searchError,
              onQueryChanged: _onQueryChanged,
              onCategorySelected: _controller.setCategory,
              onClear: () {
                _query.clear();
                _controller.clearSearch();
              },
              onRetry: _controller.retrySearchPlaces,
              onSelect: _controller.selectPlace,
              onChangePlace: _controller.changePlace,
            ),
            if (state.fieldErrors['placeId'] != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(
                  state.fieldErrors['placeId']!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: AppSpacing.section),
            ActivityDetailsSection(
              titleController: _title,
              durationController: _duration,
              costController: _cost,
              notesController: _notes,
              activities: widget.args.insertionChoices,
              insertAfterActivityId: state.insertAfterActivityId,
              selectedTime: state.selectedTime,
              budgetCurrency: widget.args.budgetCurrency,
              fieldErrors: state.fieldErrors,
              onTitleChanged: _controller.setTitle,
              onChooseStartTime: _chooseStartTime,
              onDurationChanged: (value) =>
                  _controller.setDurationMinutes(_parseOptionalInt(value)),
              onCostChanged: (value) =>
                  _controller.setEstimatedCost(_parseOptionalInt(value)),
              onNotesChanged: _controller.setNotes,
              onChooseInsertion: _chooseInsertion,
              onSelectCostPreset: _selectCostPreset,
            ),
            if (state.submitError != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Text(
                  state.submitError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onQueryChanged(String value) {
    _controller.setSearchQuery(value);
    _debounce?.cancel();
    if (value.trim().isEmpty) return;
    _debounce = Timer(
      const Duration(milliseconds: 450),
      _controller.searchPlaces,
    );
  }

  Future<void> _chooseStartTime() async {
    final current = ref
        .read(addItineraryActivityControllerProvider(widget.args))
        .selectedTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: current ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      _controller.setStartTime(picked);
    }
  }

  void _selectCostPreset(int? preset) {
    if (preset != null) {
      _cost.text = preset.toString();
      _controller.setEstimatedCost(preset);
    } else {
      _cost.clear();
      _controller.setEstimatedCost(null);
    }
  }

  Future<void> _saveDraft() async {
    await _controller.saveDraft();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã lưu vào kho nháp'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleClose() async {
    final state = ref.read(addItineraryActivityControllerProvider(widget.args));
    if (!state.isDirty) {
      context.pop();
      return;
    }

    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hủy thay đổi?'),
        content: const Text(
          'Bạn có các thông tin chưa lưu. Bạn có chắc chắn muốn thoát và hủy các thay đổi này?',
        ),
        actions: [
          TextButton(
            key: const ValueKey('add_itinerary_discard_cancel'),
            onPressed: () => ctx.pop(false),
            child: const Text('Tiếp tục chỉnh sửa'),
          ),
          FilledButton(
            key: const ValueKey('add_itinerary_discard_confirm'),
            onPressed: () => ctx.pop(true),
            child: const Text('Hủy thay đổi'),
          ),
        ],
      ),
    );

    if (discard == true && mounted) {
      await _controller.discardChanges();
      if (mounted) context.pop();
    }
  }

  Future<void> _chooseInsertion() async {
    final current = ref.read(
      addItineraryActivityControllerProvider(widget.args),
    );
    const appendValue = '__append_to_end__';
    final value = await showAppBottomSheet<String>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RadioListTile<String>(
            value: appendValue,
            groupValue: current.insertAfterActivityId ?? appendValue,
            title: const Text('Thêm vào cuối ngày'),
            onChanged: context.pop,
          ),
          ...widget.args.insertionChoices.map(
            (activity) => RadioListTile<String>(
              value: activity.id,
              groupValue: current.insertAfterActivityId,
              title: Text('Sau: ${activity.title}'),
              onChanged: context.pop,
            ),
          ),
        ],
      ),
    );
    if (!mounted || value == null) return;
    _controller.setInsertAfterActivityId(value == appendValue ? null : value);
  }

  Future<void> _submit() async {
    final created = await _controller.submit();
    if (created != null && mounted) context.pop(created);
  }
}

int? _parseOptionalInt(String value) {
  final normalized = value.trim();
  if (normalized.isEmpty) return null;
  return int.tryParse(normalized);
}

void _syncController(TextEditingController controller, String value) {
  if (controller.text == value) return;
  controller.value = TextEditingValue(
    text: value,
    selection: TextSelection.collapsed(offset: value.length),
  );
}
