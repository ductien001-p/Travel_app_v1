import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

import '../../application/publish_entry.dart';
import '../../data/models/trip_publish_models.dart';

sealed class PublishSheetChoice {
  const PublishSheetChoice();
}

class PublishSheetManage extends PublishSheetChoice {
  const PublishSheetManage(this.tripId);
  final String tripId;
}

/// Continues an existing draft inside the create-trip itinerary.
class PublishSheetContinueDraft extends PublishSheetChoice {
  const PublishSheetContinueDraft(this.tripId);
  final String tripId;
}

/// Opens the create-trip details screen.
class PublishSheetCreateTrip extends PublishSheetChoice {
  const PublishSheetCreateTrip();
}

Future<PublishSheetChoice?> showPublishTripSheet(
  BuildContext context,
  RecruitmentMine mine,
) {
  return showAppBottomSheet<PublishSheetChoice>(
    context: context,
    child: PublishTripSheet(mine: mine),
  );
}

class PublishTripSheet extends StatelessWidget {
  const PublishTripSheet({super.key, required this.mine, this.onChoice});

  final RecruitmentMine mine;
  final ValueChanged<PublishSheetChoice>? onChoice;

  void _choose(BuildContext context, PublishSheetChoice choice) {
    final listener = onChoice;
    if (listener != null) {
      listener(choice);
      return;
    }
    Navigator.of(context).pop(choice);
  }

  @override
  Widget build(BuildContext context) {
    final draft = mine.latestPublishDraft;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Đăng Chuyến Đi Lên Cộng Đồng', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Chọn chuyến đi của bạn để tuyển bạn đồng hành.',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.55,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              if (draft != null)
                _DraftRow(
                  draft: draft,
                  onContinue: () =>
                      _choose(context, PublishSheetContinueDraft(draft.tripId)),
                ),
              for (final trip in mine.trips)
                _TripRow(
                  trip: trip,
                  onAction: () =>
                      _choose(context, PublishSheetManage(trip.tripId)),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Tạo chuyến đi mới',
          leadingIcon: Icons.add_rounded,
          onPressed: () => _choose(context, const PublishSheetCreateTrip()),
        ),
      ],
    );
  }
}

class _DraftRow extends StatelessWidget {
  const _DraftRow({required this.draft, required this.onContinue});

  final PublishDraft draft;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nháp', style: AppTypography.badge),
                const SizedBox(height: 4),
                Text(draft.name, style: AppTypography.cardTitle),
              ],
            ),
          ),
          TextButton(onPressed: onContinue, child: const Text('Tiếp tục nháp')),
        ],
      ),
    );
  }
}

class _TripRow extends StatelessWidget {
  const _TripRow({required this.trip, required this.onAction});

  final RecruitmentMineTrip trip;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final places = trip.destinationLabels.join(' → ');
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recruitmentStateLabel(trip.effectiveState),
            style: AppTypography.badge.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 4),
          Text(trip.name, style: AppTypography.cardTitle),
          if (places.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              places,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (trip.blockers.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              recruitmentBlockerLabel(trip.blockers.first),
              style: AppTypography.caption.copyWith(color: AppColors.warning),
            ),
          ],
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onAction,
              child: Text(publishMineActionLabel(trip.effectiveState)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      child: child,
    );
  }
}
