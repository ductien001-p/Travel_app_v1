import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';

import '../application/publish_entry.dart';
import '../application/trip_publish_providers.dart';
import 'sheet/publish_trip_sheet.dart';

Future<void> startPublishFlow(BuildContext context, WidgetRef ref) async {
  final profile = ref.read(profileControllerProvider).asData?.value;
  if (!_ready(profile)) {
    await context.pushNamed(RouteNames.editProfile);
    if (!context.mounted) return;
    await ref.read(profileControllerProvider.notifier).refreshProfile();
    if (!context.mounted) return;
    final updated = ref.read(profileControllerProvider).asData?.value;
    if (!_ready(updated)) {
      _message(
        context,
        'Cần tên hiển thị và ảnh đại diện trước khi đăng chuyến.',
      );
      return;
    }
  }

  final busy = ref.read(publishFlowBusyProvider.notifier);
  busy.setBusy(true);
  try {
    final mine = await ref.read(tripPublishRepositoryProvider).mine();
    if (!context.mounted) return;
    await _follow(context, decidePublishEntry(mine));
  } catch (error) {
    if (context.mounted) _message(context, error.toString());
  } finally {
    busy.setBusy(false);
  }
}

bool _ready(ProfileModel? profile) => publishProfileReady(
  displayName: profile?.displayName,
  avatarUrl: profile?.avatarUrl,
  avatarId: profile?.avatarId,
);

Future<void> _follow(
  BuildContext context,
  PublishEntryDecision decision,
) async {
  switch (decision) {
    case PublishEntrySheet(:final mine):
      final choice = await showPublishTripSheet(context, mine);
      if (!context.mounted || choice == null) return;
      switch (choice) {
        case PublishSheetManage(:final tripId):
          context.pushNamed(
            RouteNames.publishTripManage,
            pathParameters: {'tripId': tripId},
          );
        case PublishSheetCreateTrip():
          context.pushNamed(RouteNames.createTrip);
        case PublishSheetContinueDraft(:final tripId):
          _openCreateTripDraft(context, tripId);
      }
    case PublishEntryAskDraft(:final draft):
      final resume = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Tiếp tục bản nháp?'),
          content: Text('Bạn có bản nháp “${draft.name}” chưa đăng.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Tạo mới'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Tiếp tục'),
            ),
          ],
        ),
      );
      if (!context.mounted || resume == null) return;
      if (!resume) {
        context.pushNamed(RouteNames.createTrip);
        return;
      }
      _openCreateTripDraft(context, draft.tripId);
    case PublishEntryCreateTrip():
      context.pushNamed(RouteNames.createTrip);
  }
}

void _openCreateTripDraft(BuildContext context, String tripId) {
  context.pushNamed(
    RouteNames.createTripItinerary,
    pathParameters: {'tripId': tripId},
  );
}

void _message(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
