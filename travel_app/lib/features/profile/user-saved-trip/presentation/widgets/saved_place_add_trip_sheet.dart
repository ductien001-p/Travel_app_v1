import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../application/saved_place_trip.dart';
import '../../application/saved_places_controller.dart';
import '../../application/saved_places_view.dart';

class SavedPlaceAddTripSheet extends ConsumerStatefulWidget {
  const SavedPlaceAddTripSheet({super.key, required this.place});

  final SavedPlaceRow place;

  @override
  ConsumerState<SavedPlaceAddTripSheet> createState() =>
      _SavedPlaceAddTripSheetState();
}

class _SavedPlaceAddTripSheetState
    extends ConsumerState<SavedPlaceAddTripSheet> {
  List<SavedTripOption>? _trips;
  Object? _tripsError;
  var _loadingTrips = true;
  SavedTripOption? _trip;
  SavedTripDayLookup? _days;
  Object? _daysError;
  var _loadingDays = false;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    setState(() {
      _loadingTrips = true;
      _tripsError = null;
    });
    try {
      final trips = await ref
          .read(savedPlacesControllerProvider.notifier)
          .listMyTrips();
      if (!mounted) return;
      setState(() {
        _trips = trips;
        _loadingTrips = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _tripsError = error;
        _loadingTrips = false;
      });
    }
  }

  Future<void> _openTrip(SavedTripOption trip) async {
    setState(() {
      _trip = trip;
      _loadingDays = true;
      _days = null;
      _daysError = null;
    });
    try {
      final days = await ref
          .read(savedPlacesControllerProvider.notifier)
          .daysForTrip(trip.id);
      if (!mounted) return;
      setState(() {
        _days = days;
        _loadingDays = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _daysError = error;
        _loadingDays = false;
      });
    }
  }

  Future<void> _add(SavedTripDayChoice day) async {
    final trip = _trip;
    if (trip == null || _saving) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(savedPlacesControllerProvider.notifier)
          .addPlaceToTrip(
            tripId: trip.id,
            dayId: day.dayId,
            placeId: widget.place.placeId,
            title: widget.place.name,
          );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_message(error, 'Không thêm được vào lịch trình.')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Thêm vào chuyến đi', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xs),
        Text(
          widget.place.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption,
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(height: 280, child: _body()),
      ],
    );
  }

  Widget _body() {
    if (_trip == null) return _tripList();
    if (_loadingDays) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    final daysError = _daysError;
    if (daysError != null) {
      return _messagePane(
        _message(daysError, 'Không tải được lịch trình.'),
        onRetry: () => _openTrip(_trip!),
      );
    }
    final lookup = _days;
    if (lookup == null) return const SizedBox.shrink();
    if (!lookup.canManage) {
      return _messagePane(
        'Bạn không có quyền sửa lịch trình chuyến này.',
        actionLabel: 'Chọn chuyến khác',
        onRetry: () => setState(() {
          _trip = null;
          _days = null;
        }),
      );
    }
    if (lookup.days.isEmpty) {
      return _messagePane(
        'Chuyến đi chưa có ngày trong lịch trình.',
        actionLabel: 'Chọn chuyến khác',
        onRetry: () => setState(() {
          _trip = null;
          _days = null;
        }),
      );
    }
    return ListView(
      children: [
        for (final day in lookup.days)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(day.label, style: AppTypography.body),
            enabled: !_saving,
            onTap: () => _add(day),
          ),
      ],
    );
  }

  Widget _tripList() {
    if (_loadingTrips) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    final error = _tripsError;
    if (error != null) {
      return _messagePane(
        _message(error, 'Không tải được danh sách chuyến đi.'),
        onRetry: _loadTrips,
      );
    }
    final trips = _trips ?? const <SavedTripOption>[];
    if (trips.isEmpty) {
      return Center(
        child: Text(
          'Bạn chưa có chuyến đi để thêm địa điểm.',
          textAlign: TextAlign.center,
          style: AppTypography.body,
        ),
      );
    }
    return ListView(
      children: [
        for (final trip in trips)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(trip.name, style: AppTypography.cardTitle),
            onTap: () => _openTrip(trip),
          ),
      ],
    );
  }

  Widget _messagePane(
    String message, {
    required VoidCallback onRetry,
    String actionLabel = 'Thử lại',
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, textAlign: TextAlign.center, style: AppTypography.body),
        TextButton(onPressed: onRetry, child: Text(actionLabel)),
      ],
    );
  }
}

String _message(Object error, String fallback) {
  if (error is ApiException && error.message.isNotEmpty) return error.message;
  return fallback;
}
