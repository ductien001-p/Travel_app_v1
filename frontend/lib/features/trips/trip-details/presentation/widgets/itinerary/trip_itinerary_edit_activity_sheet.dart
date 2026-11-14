import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';

import '../../../../trip-itineraies/data/models/itinerary_models.dart';
import '../../../application/trip_itinerary_edit_activity_controller.dart';

/// Edits title, start time, duration, cost and notes of one activity.
///
/// Pops `true` once the change is saved.
class TripItineraryEditActivitySheet extends ConsumerStatefulWidget {
  const TripItineraryEditActivitySheet({
    super.key,
    required this.tripId,
    required this.activity,
    required this.dayDate,
  });

  final String tripId;
  final ItineraryActivity activity;
  final DateTime dayDate;

  @override
  ConsumerState<TripItineraryEditActivitySheet> createState() =>
      _TripItineraryEditActivitySheetState();
}

class _TripItineraryEditActivitySheetState
    extends ConsumerState<TripItineraryEditActivitySheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _duration;
  late final TextEditingController _cost;
  late final TextEditingController _notes;
  int? _startMinutes;

  @override
  void initState() {
    super.initState();
    final initial = TripActivityEditInput.of(widget.activity);
    _title = TextEditingController(text: initial.title);
    _duration = TextEditingController(text: initial.duration);
    _cost = TextEditingController(text: initial.cost);
    _notes = TextEditingController(text: initial.notes);
    _startMinutes = initial.startMinutes;
  }

  @override
  void dispose() {
    _title.dispose();
    _duration.dispose();
    _cost.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = tripItineraryEditActivityControllerProvider(widget.tripId);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    String? errorOf(TripActivityEditField field) => state.fieldErrors[field];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Sửa hoạt động', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _title,
                label: 'Tên hoạt động',
                leadingIcon: Icons.edit_outlined,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                    TripActivityEditLimits.titleMaxLength,
                  ),
                ],
                validator: (_) => errorOf(TripActivityEditField.title),
                onChanged: (_) =>
                    controller.clearFieldError(TripActivityEditField.title),
              ),
              const SizedBox(height: AppSpacing.sm),
              _StartTimeField(
                minutes: _startMinutes,
                error: errorOf(TripActivityEditField.startTime),
                onPick: _pickStartTime,
                onClear: () {
                  setState(() => _startMinutes = null);
                  controller.clearFieldError(TripActivityEditField.startTime);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _duration,
                      label: 'Thời lượng (phút)',
                      leadingIcon: Icons.timer_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (_) => errorOf(TripActivityEditField.duration),
                      onChanged: (_) => controller.clearFieldError(
                        TripActivityEditField.duration,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppTextField(
                      controller: _cost,
                      label: 'Chi phí (VND)',
                      leadingIcon: Icons.payments_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (_) => errorOf(TripActivityEditField.cost),
                      onChanged: (_) => controller.clearFieldError(
                        TripActivityEditField.cost,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                controller: _notes,
                label: 'Ghi chú',
                hint: 'Ví dụ: mang theo kem chống nắng',
                leadingIcon: Icons.sticky_note_2_outlined,
                maxLines: 4,
                minLines: 3,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                    TripActivityEditLimits.notesMaxLength,
                  ),
                ],
                validator: (_) => errorOf(TripActivityEditField.notes),
                onChanged: (_) =>
                    controller.clearFieldError(TripActivityEditField.notes),
              ),
              if (state.errorMessage case final message?) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.danger,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Lưu thay đổi',
                leadingIcon: Icons.check_rounded,
                isLoading: state.isSubmitting,
                onPressed: state.isSubmitting ? null : _submit,
              ),
              const SizedBox(height: AppSpacing.xs),
              AppButton(
                label: 'Hủy',
                variant: AppButtonVariant.secondary,
                onPressed: state.isSubmitting ? null : () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickStartTime() async {
    final current = _startMinutes ?? 8 * 60;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null || !mounted) return;
    setState(() => _startMinutes = picked.hour * 60 + picked.minute);
    ref
        .read(
          tripItineraryEditActivityControllerProvider(widget.tripId).notifier,
        )
        .clearFieldError(TripActivityEditField.startTime);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final outcome = await ref
        .read(
          tripItineraryEditActivityControllerProvider(widget.tripId).notifier,
        )
        .submit(
          original: widget.activity,
          dayDate: widget.dayDate,
          input: TripActivityEditInput(
            title: _title.text,
            startMinutes: _startMinutes,
            duration: _duration.text,
            cost: _cost.text,
            notes: _notes.text,
          ),
        );
    if (!mounted) return;
    switch (outcome) {
      case TripActivityEditOutcome.saved:
        context.pop(true);
      case TripActivityEditOutcome.unchanged:
        context.pop(false);
      case TripActivityEditOutcome.rejected:
        _formKey.currentState?.validate();
    }
  }
}

class _StartTimeField extends StatelessWidget {
  const _StartTimeField({
    required this.minutes,
    required this.error,
    required this.onPick,
    required this.onClear,
  });

  final int? minutes;
  final String? error;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final value = minutes;
    final hasError = error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppPressable(
          onTap: onPick,
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: AppSizes.inputMinHeight,
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.glass90,
              borderRadius: BorderRadius.circular(AppRadius.input),
              border: Border.all(
                color: hasError ? AppColors.danger : AppColors.borderNeutral,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    value == null
                        ? 'Giờ bắt đầu: chưa đặt'
                        : 'Giờ bắt đầu: ${_clock(value)}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: value == null
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                if (value != null)
                  IconButton(
                    onPressed: onClear,
                    tooltip: 'Bỏ giờ bắt đầu',
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (error case final message?)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.sm,
              top: AppSpacing.xxs,
            ),
            child: Text(
              message,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ),
      ],
    );
  }

  static String _clock(int minutes) {
    String two(int value) => value.toString().padLeft(2, '0');
    return '${two(minutes ~/ 60)}:${two(minutes % 60)}';
  }
}
