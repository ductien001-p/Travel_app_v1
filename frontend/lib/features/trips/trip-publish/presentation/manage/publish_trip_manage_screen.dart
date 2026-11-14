import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_loading.dart';

import '../../application/publish_entry.dart';
import '../../application/trip_publish_providers.dart';
import '../../data/models/trip_publish_models.dart';

class PublishTripManageScreen extends ConsumerStatefulWidget {
  const PublishTripManageScreen({super.key, required this.tripId});

  final String tripId;

  @override
  ConsumerState<PublishTripManageScreen> createState() =>
      _PublishTripManageScreenState();
}

class _PublishTripManageScreenState
    extends ConsumerState<PublishTripManageScreen> {
  RecruitmentMineTrip? _trip;
  Object? _error;
  bool _loading = true;
  bool _saving = false;
  bool _urgent = false;
  late final TextEditingController _requirements;
  late final TextEditingController _amount;

  @override
  void initState() {
    super.initState();
    _requirements = TextEditingController();
    _amount = TextEditingController();
    _load();
  }

  @override
  void dispose() {
    _requirements.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final mine = await ref.read(tripPublishRepositoryProvider).mine();
      final matches = mine.trips.where((trip) => trip.tripId == widget.tripId);
      if (matches.isEmpty) {
        throw StateError('Không tìm thấy chuyến sắp đi.');
      }
      final trip = matches.first;
      _requirements.text = trip.requirements ?? '';
      _amount.text = trip.estimatedBudgetPerPerson ?? '';
      _urgent = trip.urgent;
      if (mounted) {
        setState(() {
          _trip = trip;
          _loading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error;
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: AppLoading());
    }
    final error = _error;
    final trip = _trip;
    if (error != null || trip == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quản lý bài đăng')),
        body: AppErrorView(
          title: 'Không tải được bài đăng',
          message: error?.toString() ?? 'Không tìm thấy chuyến.',
          actionLabel: 'Thử lại',
          onRetry: _load,
        ),
      );
    }
    final expires = trip.expiresAt;
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý bài đăng')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          Text(trip.name, style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.xs),
          Text(
            recruitmentStateLabel(trip.effectiveState),
            style: AppTypography.caption.copyWith(color: AppColors.primary),
          ),
          if (expires != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Hết hạn ${formatRecruitmentInstant(expires)}',
              style: AppTypography.caption,
            ),
          ],
          if (trip.pendingRequestCount > 0) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${trip.pendingRequestCount} yêu cầu đang chờ',
              style: AppTypography.caption,
            ),
          ],
          for (final blocker in trip.blockers) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              recruitmentBlockerLabel(blocker),
              style: AppTypography.caption.copyWith(color: AppColors.warning),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _requirements,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Yêu cầu tham gia'),
          ),
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Đăng tuyển gấp'),
            subtitle: const Text(
              'Hiện badge tuyển gấp trên màn chuyến đi theo điểm đến.',
            ),
            value: _urgent,
            activeThumbColor: AppColors.primary,
            onChanged: _saving
                ? null
                : (value) => setState(() => _urgent = value),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _amount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Ngân sách mỗi người'),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Lưu',
            isLoading: _saving,
            onPressed: _saving ? null : () => _run(_save),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (trip.effectiveState == RecruitmentState.notPublished)
            AppButton(
              label: 'Đăng',
              isLoading: _saving,
              onPressed: _saving || !trip.canPublish
                  ? null
                  : () => _run(_publish),
            ),
          if (trip.effectiveState == RecruitmentState.open ||
              trip.effectiveState == RecruitmentState.full)
            AppButton(
              label: 'Đóng tuyển',
              variant: AppButtonVariant.secondary,
              isLoading: _saving,
              onPressed: _saving ? null : () => _run(_close),
            ),
          if (trip.effectiveState == RecruitmentState.closed)
            AppButton(
              label: 'Mở lại tuyển',
              isLoading: _saving,
              onPressed: _saving ? null : () => _run(_reopen),
            ),
        ],
      ),
    );
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _saving = true);
    try {
      await action();
      ref.invalidate(recruitmentSummaryProvider);
      if (mounted) await _load();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _save() {
    return ref.read(tripPublishRepositoryProvider).patch(widget.tripId, {
      'requirements': _requirements.text.trim(),
      'estimatedBudgetPerPerson': _amount.text.trim(),
      'urgent': _urgent,
      'origin': 'EXISTING_TRIP',
    });
  }

  Future<void> _publish() async {
    await _save();
    final keys = ref.read(publishIdempotencyProvider(widget.tripId).notifier);
    final key = keys.keyForAttempt();
    await ref.read(tripPublishRepositoryProvider).publish(widget.tripId, key);
    keys.clear();
    if (mounted) context.pop();
  }

  Future<void> _close() {
    return ref.read(tripPublishRepositoryProvider).close(widget.tripId);
  }

  Future<void> _reopen() async {
    await _save();
    await ref.read(tripPublishRepositoryProvider).reopen(widget.tripId);
  }
}
