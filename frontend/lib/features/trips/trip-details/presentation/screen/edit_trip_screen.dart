import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';
import 'package:travel_frontend_v1/core/widget/app_top_bar.dart';

import '../../../application/update_trip_controller.dart';
import '../../../data/models/trip_enums.dart';
import '../../../data/models/update_trip_request.dart';
import '../../../trip-publish/presentation/recruitment_impact_dialog.dart';
import '../../application/trip_detail_overview_controller.dart';
import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';
import '../widgets/trip_detail_feedback.dart';

class EditTripScreen extends ConsumerStatefulWidget {
  const EditTripScreen({super.key, required this.tripId});

  final String tripId;

  @override
  ConsumerState<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends ConsumerState<EditTripScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxMembersController = TextEditingController();

  TripBudgetLevel? _budgetLevel;
  TripType _tripType = TripType.friends;
  TripVisibility _visibility = TripVisibility.public;
  bool _seeded = false;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _maxMembersController.dispose();
    super.dispose();
  }

  void _seedFrom(TripDetailOverview trip) {
    if (_seeded) return;
    _seeded = true;
    _nameController.text = trip.name;
    _descriptionController.text = trip.description ?? '';
    _maxMembersController.text = '${trip.maxMembers}';
    _budgetLevel = switch (trip.budgetLevel) {
      TripDetailBudgetLevel.low => TripBudgetLevel.low,
      TripDetailBudgetLevel.medium => TripBudgetLevel.medium,
      TripDetailBudgetLevel.high => TripBudgetLevel.high,
      null => null,
    };
    _tripType = switch (trip.tripType) {
      TripDetailType.solo => TripType.solo,
      TripDetailType.couple => TripType.couple,
      TripDetailType.family => TripType.family,
      TripDetailType.friends => TripType.friends,
      TripDetailType.backpacker => TripType.backpacker,
      TripDetailType.other => TripType.other,
    };
    _visibility = switch (trip.visibility) {
      TripDetailVisibility.public => TripVisibility.public,
      TripDetailVisibility.private => TripVisibility.private,
    };
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(tripDetailOverviewControllerProvider(widget.tripId));

    return AppScaffold(
      topBar: AppTopBar(
        title: 'Chỉnh sửa chuyến đi',
        onBack: () => context.pop(),
      ),
      body: switch (detail) {
        AsyncValue(:final value?) => _buildBody(value),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không tải được chuyến đi',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref.invalidate(
            tripDetailOverviewControllerProvider(widget.tripId),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Widget _buildBody(TripDetailOverview value) {
    if (!value.canEditTrip) {
      return const AppErrorView(
        title: 'Không có quyền',
        message: 'Chỉ chủ chuyến mới được chỉnh sửa.',
      );
    }
    _seedFrom(value);
    return _EditForm(
      nameController: _nameController,
      descriptionController: _descriptionController,
      maxMembersController: _maxMembersController,
      budgetLevel: _budgetLevel,
      tripType: _tripType,
      visibility: _visibility,
      saving: _saving,
      onBudgetChanged: (v) => setState(() => _budgetLevel = v),
      onTripTypeChanged: (v) => setState(() => _tripType = v),
      onVisibilityChanged: (v) => setState(() => _visibility = v),
      onSave: () => _save(),
    );
  }

  Future<void> _save() async {
    if (_saving) return;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showTripDetailMessage(context, 'Nhập tên chuyến đi.');
      return;
    }
    final maxMembers = int.tryParse(_maxMembersController.text.trim());
    if (maxMembers == null || maxMembers < 1) {
      showTripDetailMessage(context, 'Số thành viên tối đa không hợp lệ.');
      return;
    }

    var request = UpdateTripRequest(
      name: name,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      budgetLevel: _budgetLevel,
      maxMembers: maxMembers,
      tripType: _tripType,
      visibility: _visibility,
    );

    setState(() => _saving = true);
    try {
      await _submitWithAck(request);
      if (!mounted) return;
      showTripDetailMessage(context, 'Đã lưu thay đổi.');
      context.pop();
    } catch (error) {
      if (!mounted) return;
      showTripDetailMessage(
        context,
        error is ApiException ? error.message : 'Không lưu được. Thử lại.',
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _submitWithAck(UpdateTripRequest request) async {
    final notifier = ref.read(updateTripControllerProvider.notifier);
    try {
      await notifier.submit(widget.tripId, request);
    } catch (error) {
      if (!isRecruitmentImpactAck(error)) rethrow;
      if (!mounted) return;
      final ok = await showRecruitmentImpactDialog(context);
      if (!ok) rethrow;
      await notifier.submit(
        widget.tripId,
        request.copyWith(acknowledgeRecruitmentImpact: true),
      );
    }
  }
}

class _EditForm extends StatelessWidget {
  const _EditForm({
    required this.nameController,
    required this.descriptionController,
    required this.maxMembersController,
    required this.budgetLevel,
    required this.tripType,
    required this.visibility,
    required this.saving,
    required this.onBudgetChanged,
    required this.onTripTypeChanged,
    required this.onVisibilityChanged,
    required this.onSave,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController maxMembersController;
  final TripBudgetLevel? budgetLevel;
  final TripType tripType;
  final TripVisibility visibility;
  final bool saving;
  final ValueChanged<TripBudgetLevel?> onBudgetChanged;
  final ValueChanged<TripType> onTripTypeChanged;
  final ValueChanged<TripVisibility> onVisibilityChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.safeBottom,
      ),
      children: [
        Text('Thông tin cơ bản', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: nameController,
          label: 'Tên chuyến đi',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: descriptionController,
          label: 'Mô tả',
          maxLines: 4,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: maxMembersController,
          label: 'Số thành viên tối đa',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: AppSpacing.section),
        Text('Ngân sách', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            for (final level in TripBudgetLevel.values)
              ChoiceChip(
                label: Text(switch (level) {
                  TripBudgetLevel.low => 'Thấp',
                  TripBudgetLevel.medium => 'Trung bình',
                  TripBudgetLevel.high => 'Cao',
                }),
                selected: budgetLevel == level,
                onSelected: (_) => onBudgetChanged(level),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        Text('Loại chuyến', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<TripType>(
          initialValue: tripType,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: [
            for (final type in TripType.values)
              DropdownMenuItem(value: type, child: Text(_tripTypeLabel(type))),
          ],
          onChanged: (value) {
            if (value != null) onTripTypeChanged(value);
          },
        ),
        const SizedBox(height: AppSpacing.section),
        Text('Chế độ hiển thị', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        SegmentedButton<TripVisibility>(
          segments: const [
            ButtonSegment(
              value: TripVisibility.public,
              label: Text('Công khai'),
            ),
            ButtonSegment(
              value: TripVisibility.private,
              label: Text('Riêng tư'),
            ),
          ],
          selected: {visibility},
          onSelectionChanged: (value) => onVisibilityChanged(value.first),
        ),
        const SizedBox(height: AppSpacing.section),
        AppButton(
          label: 'Lưu thay đổi',
          isLoading: saving,
          onPressed: saving ? null : onSave,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Đổi điểm đến hoặc lịch trình ở màn lịch trình chuyến đi.',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  static String _tripTypeLabel(TripType type) => switch (type) {
    TripType.solo => 'Một mình',
    TripType.couple => 'Cặp đôi',
    TripType.family => 'Gia đình',
    TripType.friends => 'Bạn bè',
    TripType.backpacker => 'Balo phượt',
    TripType.other => 'Khác',
  };
}
