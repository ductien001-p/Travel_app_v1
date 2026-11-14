import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_badge.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_card.dart';
import '../../../../core/widget/app_chip.dart';
import '../../../../core/widget/app_glass_surface.dart';
import '../../../../core/widget/app_text_field.dart';
import '../../trip-itineraies/application/add_itinerary_activity_state.dart';
import '../../trip-itineraies/data/models/itinerary_models.dart';
import '../../trip-itineraies/utils/destination_time_converter.dart';

class AddActivityTaskHeader extends StatelessWidget {
  const AddActivityTaskHeader({
    super.key,
    required this.dayNumber,
    required this.dayDate,
    required this.city,
    required this.country,
    required this.onClose,
  });

  final int dayNumber;
  final DateTime dayDate;
  final String city;
  final String country;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.xs,
      AppSpacing.xs,
      AppSpacing.screenHorizontal,
      AppSpacing.sm,
    ),
    child: Row(
      children: [
        IconButton(
          key: const ValueKey('add_itinerary_close'),
          tooltip: 'Đóng',
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thêm Hoạt Động Mới', style: AppTypography.cardTitle),
              Text(
                'Ngày $dayNumber • ${_dateLabel(dayDate)} • $city, $country',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class PlaceCategoryChipRail extends StatelessWidget {
  const PlaceCategoryChipRail({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  final PlaceCategoryGroup selectedCategory;
  final ValueChanged<PlaceCategoryGroup> onSelected;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: PlaceCategoryGroup.values.map((group) {
        final isSelected = group == selectedCategory;
        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.xs),
          child: AppChip(
            key: ValueKey('add_itinerary_category_${group.name}'),
            label: group.label,
            selected: isSelected,
            onTap: () => onSelected(group),
          ),
        );
      }).toList(),
    ),
  );
}

class ActivityPlaceSection extends StatelessWidget {
  const ActivityPlaceSection({
    super.key,
    required this.queryController,
    required this.query,
    required this.selectedCategory,
    required this.results,
    required this.selectedPlace,
    required this.loading,
    required this.error,
    required this.onQueryChanged,
    required this.onCategorySelected,
    required this.onClear,
    required this.onRetry,
    required this.onSelect,
    required this.onChangePlace,
  });

  final TextEditingController queryController;
  final String query;
  final PlaceCategoryGroup selectedCategory;
  final List<PlaceSearchResult> results;
  final PlaceSearchResult? selectedPlace;
  final bool loading;
  final String? error;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<PlaceCategoryGroup> onCategorySelected;
  final VoidCallback onClear;
  final VoidCallback onRetry;
  final ValueChanged<PlaceSearchResult> onSelect;
  final VoidCallback onChangePlace;

  @override
  Widget build(BuildContext context) => _Section(
    number: 1,
    title: 'Tìm kiếm & Chọn Địa Điểm',
    trailing: 'BẮT BUỘC',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (selectedPlace == null) ...[
          AppTextField(
            key: const ValueKey('add_itinerary_place_search'),
            controller: queryController,
            hint: 'Tìm địa điểm',
            leadingIcon: Icons.search,
            onChanged: onQueryChanged,
            trailing: loading
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : query.isEmpty
                ? null
                : IconButton(
                    key: const ValueKey('add_itinerary_clear_search_btn'),
                    tooltip: 'Xóa tìm kiếm',
                    onPressed: onClear,
                    icon: const Icon(Icons.close),
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
          PlaceCategoryChipRail(
            selectedCategory: selectedCategory,
            onSelected: onCategorySelected,
          ),
          if (error != null)
            _InlineMessage(message: error!, onRetry: onRetry)
          else if (!loading && query.trim().isNotEmpty && results.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.sm),
              child: Text('Không tìm thấy địa điểm phù hợp.'),
            )
          else
            ...results.map(
              (place) => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: _RichPlaceCard(
                  place: place,
                  onTap: () => onSelect(place),
                ),
              ),
            ),
        ] else
          _RichPlaceCard(
            key: const ValueKey('add_itinerary_selected_place'),
            place: selectedPlace!,
            selected: true,
            onChangePlace: onChangePlace,
          ),
      ],
    ),
  );
}

class ActivityDetailsSection extends StatelessWidget {
  const ActivityDetailsSection({
    super.key,
    required this.titleController,
    required this.durationController,
    required this.costController,
    required this.notesController,
    required this.activities,
    required this.insertAfterActivityId,
    required this.selectedTime,
    required this.budgetCurrency,
    required this.fieldErrors,
    required this.onTitleChanged,
    required this.onChooseStartTime,
    required this.onDurationChanged,
    required this.onCostChanged,
    required this.onNotesChanged,
    required this.onChooseInsertion,
    required this.onSelectCostPreset,
  });

  final TextEditingController titleController;
  final TextEditingController durationController;
  final TextEditingController costController;
  final TextEditingController notesController;
  final List<ItineraryActivity> activities;
  final String? insertAfterActivityId;
  final TimeOfDay? selectedTime;
  final String budgetCurrency;
  final Map<String, String> fieldErrors;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onChooseStartTime;
  final ValueChanged<String> onDurationChanged;
  final ValueChanged<String> onCostChanged;
  final ValueChanged<String> onNotesChanged;
  final VoidCallback onChooseInsertion;
  final ValueChanged<int?> onSelectCostPreset;

  @override
  Widget build(BuildContext context) {
    final parsedMinutes = int.tryParse(durationController.text.trim());
    return _Section(
      number: 2,
      title: 'Chi Tiết Hoạt Động',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  key: const ValueKey('add_itinerary_title'),
                  controller: titleController,
                  label: 'Tên hoạt động',
                  hint: 'Mặc định dùng tên địa điểm',
                  leadingIcon: Icons.edit_note_outlined,
                  onChanged: onTitleChanged,
                ),
                _FieldError(fieldErrors['title']),
                const SizedBox(height: AppSpacing.sm),
                _buildStartTimeControl(context),
                _FieldError(fieldErrors['startTime']),
                const SizedBox(height: AppSpacing.sm),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final durationField = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          key: const ValueKey('add_itinerary_duration'),
                          controller: durationController,
                          label: 'Thời lượng (phút)',
                          leadingIcon: Icons.hourglass_bottom_outlined,
                          keyboardType: TextInputType.number,
                          inputFormatters: [_integerInputFormatter],
                          onChanged: onDurationChanged,
                        ),
                        if (parsedMinutes != null && parsedMinutes > 0)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppSpacing.xxs,
                              left: AppSpacing.xs,
                            ),
                            child: Text(
                              _derivedDurationLabel(parsedMinutes),
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    );
                    final costField = AppTextField(
                      key: const ValueKey('add_itinerary_cost'),
                      controller: costController,
                      label: 'Chi phí ($budgetCurrency)',
                      leadingIcon: Icons.payments_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [_integerInputFormatter],
                      onChanged: onCostChanged,
                    );
                    if (constraints.maxWidth < 340) {
                      return Column(
                        children: [
                          durationField,
                          const SizedBox(height: AppSpacing.sm),
                          costField,
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: durationField),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: costField),
                      ],
                    );
                  },
                ),
                _FieldError(fieldErrors['estimatedDuration']),
                _FieldError(fieldErrors['estimatedCost']),
                const SizedBox(height: AppSpacing.xs),
                _buildQuickCostPresets(context),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  key: const ValueKey('add_itinerary_insertion'),
                  onPressed: onChooseInsertion,
                  icon: const Icon(Icons.account_tree_outlined),
                  label: Text(_insertionLabel()),
                ),
                _FieldError(fieldErrors['insertAfterActivityId']),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  key: const ValueKey('add_itinerary_notes'),
                  controller: notesController,
                  label: 'Ghi chú (tùy chọn)',
                  hint: 'Chuẩn bị đồ đạc, trang phục, dặn dò...',
                  leadingIcon: Icons.notes_outlined,
                  maxLines: 3,
                  onChanged: onNotesChanged,
                ),
                _FieldError(fieldErrors['notes']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartTimeControl(BuildContext context) {
    final formattedTime = selectedTime != null
        ? DestinationTimeConverter.formatTimeOfDay(selectedTime!)
        : 'Chọn giờ';
    final period = selectedTime != null
        ? DestinationTimeConverter.timeOfDayPeriodLabel(selectedTime!)
        : '';

    return InkWell(
      key: const ValueKey('add_itinerary_start_time'),
      onTap: onChooseStartTime,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedTime != null
                ? AppColors.primary
                : AppColors.borderNeutral,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giờ bắt đầu (UTC)', style: AppTypography.caption),
                  Text(
                    selectedTime != null
                        ? '$formattedTime • $period (UTC)'
                        : 'Chưa chọn giờ bắt đầu',
                    style: AppTypography.bodyMedium.copyWith(
                      color: selectedTime != null
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickCostPresets(BuildContext context) {
    final currentCost = int.tryParse(costController.text.trim());
    final presets = [
      (label: '0đ', value: 0),
      (label: '50.000đ', value: 50000),
      (label: '100.000đ', value: 100000),
      (label: '200.000đ', value: 200000),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...presets.map((preset) {
            final isSelected = currentCost == preset.value;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: AppChip(
                key: ValueKey('add_itinerary_quick_cost_${preset.value}'),
                label: preset.label,
                selected: isSelected,
                onTap: () => onSelectCostPreset(preset.value),
              ),
            );
          }),
          AppChip(
            key: const ValueKey('add_itinerary_quick_cost_custom'),
            label: 'Tùy chỉnh',
            selected:
                currentCost != null &&
                !presets.any((p) => p.value == currentCost),
            onTap: () => onSelectCostPreset(null),
          ),
        ],
      ),
    );
  }

  String _insertionLabel() {
    if (insertAfterActivityId == null) return 'Thêm vào cuối ngày';
    for (final activity in activities) {
      if (activity.id == insertAfterActivityId) {
        return 'Sau: ${activity.title}';
      }
    }
    return 'Chọn vị trí trong ngày';
  }

  String _derivedDurationLabel(int minutes) {
    if (minutes < 60) return '~$minutes phút';
    final hours = (minutes / 60).toStringAsFixed(1);
    return '$hours giờ (~$minutes phút)';
  }
}

class AddActivityActionDock extends StatelessWidget {
  const AddActivityActionDock({
    super.key,
    required this.dayNumber,
    required this.canSubmit,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onSaveDraft,
  });

  final int dayNumber;
  final bool canSubmit;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final VoidCallback onSaveDraft;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: AppGlassSurface(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AppButton(
              key: const ValueKey('add_itinerary_save_draft'),
              label: 'Lưu nháp',
              variant: AppButtonVariant.glass,
              leadingIcon: Icons.bookmark_border_outlined,
              onPressed: isSubmitting ? null : onSaveDraft,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 3,
            child: AppButton(
              key: const ValueKey('add_itinerary_submit'),
              label: 'Thêm vào Ngày $dayNumber',
              onPressed: canSubmit ? onSubmit : null,
              isLoading: isSubmitting,
              trailingIcon: Icons.arrow_forward,
            ),
          ),
        ],
      ),
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({
    required this.number,
    required this.title,
    required this.child,
    this.trailing,
  });
  final int number;
  final String title;
  final String? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          const Icon(Icons.circle, size: 9, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text('$number. $title', style: AppTypography.sectionTitle),
          ),
          if (trailing != null) Text(trailing!, style: AppTypography.badge),
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      child,
    ],
  );
}

class _RichPlaceCard extends StatelessWidget {
  const _RichPlaceCard({
    super.key,
    required this.place,
    this.onTap,
    this.selected = false,
    this.onChangePlace,
  });

  final PlaceSearchResult place;
  final VoidCallback? onTap;
  final bool selected;
  final VoidCallback? onChangePlace;

  @override
  Widget build(BuildContext context) => AppCard(
    borderColor: selected ? AppColors.primary : AppColors.borderBrandSoft,
    child: InkWell(
      onTap: selected ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox.square(
                  dimension: 72,
                  child:
                      place.thumbnailUrl != null &&
                          place.thumbnailUrl!.trim().isNotEmpty
                      ? Image.network(
                          place.thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _fallbackCover(),
                        )
                      : _fallbackCover(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            place.name,
                            style: AppTypography.cardTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (place.category != null &&
                            place.category!.trim().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: AppBadge(
                              label: place.category!,
                              tone: AppBadgeTone.neutral,
                            ),
                          ),
                      ],
                    ),
                    if (place.address != null &&
                        place.address!.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          place.address!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (place.averageRating != null) ...[
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.borderBrandSoft,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            place.averageRating!.toStringAsFixed(1),
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          '(${place.reviewCount} đánh giá)',
                          style: AppTypography.caption,
                        ),
                        const Spacer(),
                        Text(
                          '${place.distanceKm.toStringAsFixed(1)} km',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primaryActive,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (selected) ...[
            const Divider(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                key: const ValueKey('add_itinerary_change_place_btn'),
                onPressed: onChangePlace,
                icon: const Icon(Icons.swap_horiz, size: 18),
                label: const Text('Đổi địa điểm khác'),
              ),
            ),
          ],
        ],
      ),
    ),
  );

  Widget _fallbackCover() => const ColoredBox(
    color: AppColors.primaryLight,
    child: Icon(Icons.place_outlined, size: 32, color: AppColors.primary),
  );
}

class _InlineMessage extends StatelessWidget {
  const _InlineMessage({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Row(
      children: [
        Expanded(
          child: Text(
            message,
            style: AppTypography.body.copyWith(color: AppColors.danger),
          ),
        ),
        TextButton(onPressed: onRetry, child: const Text('Thử lại')),
      ],
    ),
  );
}

class _FieldError extends StatelessWidget {
  const _FieldError(this.message);
  final String? message;

  @override
  Widget build(BuildContext context) => message == null
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xxs),
          child: Text(
            message!,
            style: AppTypography.caption.copyWith(color: AppColors.danger),
          ),
        );
}

String _dateLabel(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/'
    '${value.month.toString().padLeft(2, '0')}/${value.year}';

final _integerInputFormatter = TextInputFormatter.withFunction(
  (oldValue, newValue) =>
      RegExp(r'^\d*$').hasMatch(newValue.text) ? newValue : oldValue,
);
