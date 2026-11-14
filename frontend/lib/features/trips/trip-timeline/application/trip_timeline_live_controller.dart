import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/core/realtime/trip_socket_client.dart';

import '../data/models/trip_timeline_models.dart';
import 'trip_timeline_events_controller.dart';

enum TripTimelineLiveStatus { connecting, live, offline }

/// Keeps the timeline in sync with `trip:timeline` while it is watched.
final tripTimelineLiveProvider = NotifierProvider.autoDispose
    .family<TripTimelineLiveController, TripTimelineLiveStatus, String>(
      TripTimelineLiveController.new,
    );

class TripTimelineLiveController extends Notifier<TripTimelineLiveStatus> {
  TripTimelineLiveController(this.tripId);

  final String tripId;
  bool _joinedBefore = false;

  @override
  TripTimelineLiveStatus build() {
    _joinedBefore = false;
    final subscription = ref
        .watch(tripSocketClientProvider)
        .watchTrip(tripId)
        .listen(_onRoomEvent);
    ref.onDispose(subscription.cancel);
    return TripTimelineLiveStatus.connecting;
  }

  void _onRoomEvent(TripRoomEvent event) {
    switch (event) {
      case TripRoomJoined():
        if (_joinedBefore) _catchUp();
        _joinedBefore = true;
        state = TripTimelineLiveStatus.live;
      case TripRoomLeft():
        state = TripTimelineLiveStatus.connecting;
      case TripRoomRejected():
        state = TripTimelineLiveStatus.offline;
      case TripTimelinePushed(:final event):
        _apply(event);
      case TripChatMessagePushed():
      case TripChatTypingPushed():
      case TripChatReactionPushed():
        break;
    }
  }

  void _apply(Map<String, dynamic> json) {
    final TripTimelineEntry entry;
    try {
      entry = TripTimelineEntry.fromJson(json);
    } catch (_) {
      return;
    }
    _events.receive(entry);
  }

  /// Events recorded while disconnected are only in the REST timeline.
  void _catchUp() {
    unawaited(_events.refresh().catchError((Object _) {}));
  }

  TripTimelineEventsController get _events =>
      ref.read(tripTimelineEventsControllerProvider(tripId).notifier);
}
