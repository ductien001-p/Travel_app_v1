import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/application/saved_place_trip.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_query.dart';
import 'package:travel_frontend_v1/features/trips/provider/trips_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';

Future<bool> showPlaceItinerarySheet({
  required BuildContext context,
  required String placeId,
  required String placeName,
}) async {
  final added = await showAppBottomSheet<bool>(
    context: context,
    child: _PlaceItinerarySheet(placeId: placeId, placeName: placeName),
  );
  return added ?? false;
}

class _PlaceItinerarySheet extends ConsumerStatefulWidget {
  const _PlaceItinerarySheet({required this.placeId, required this.placeName});

  final String placeId;
  final String placeName;

  @override
  ConsumerState<_PlaceItinerarySheet> createState() =>
      _PlaceItinerarySheetState();
}

class _PlaceItinerarySheetState extends ConsumerState<_PlaceItinerarySheet> {
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
      final options = <SavedTripOption>[];
      var page = 1;
      while (page <= 5) {
        final result = await ref
            .read(tripRepositoryProvider)
            .getTrips(TripQuery(mine: true, page: page, limit: 20));
        options.addAll(
          result.items.map(
            (item) => SavedTripOption(id: item.id, name: item.name),
          ),
        );
        if (!result.meta.hasNextPage) break;
        page++;
      }
      if (!mounted) return;
      setState(() {
        _trips = options;
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
      final data = await ref
          .read(tripItineraryRepositoryProvider)
          .getItinerary(trip.id);
      if (!mounted) return;
      setState(() {
        _days = savedTripDays(data);
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
          .read(tripItineraryRepositoryProvider)
          .createItemsBatch(
            trip.id,
            savedPlaceItineraryBatch(
              dayId: day.dayId,
              placeId: widget.placeId,
              title: widget.placeName,
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(homeFailureMessage(error))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Chọn chuyến đi', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xs),
        Text(
          widget.placeName,
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
    if (_loadingDays) return const _Spinner();
    final daysError = _daysError;
    if (daysError != null) {
      return _MessagePane(
        homeFailureMessage(daysError),
        onRetry: () => _openTrip(_trip!),
      );
    }
    final lookup = _days;
    if (lookup == null) return const SizedBox.shrink();
    if (!lookup.canManage) {
      return _MessagePane(
        'Bạn không có quyền sửa lịch trình chuyến này.',
        actionLabel: 'Chọn chuyến khác',
        onRetry: _clearTrip,
      );
    }
    if (lookup.days.isEmpty) {
      return _MessagePane(
        'Chuyến đi chưa có ngày trong lịch trình.',
        actionLabel: 'Chọn chuyến khác',
        onRetry: _clearTrip,
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
    if (_loadingTrips) return const _Spinner();
    final error = _tripsError;
    if (error != null) {
      return _MessagePane(homeFailureMessage(error), onRetry: _loadTrips);
    }
    final trips = _trips ?? const <SavedTripOption>[];
    if (trips.isEmpty) {
      return Text(
        'Bạn chưa có chuyến đi để thêm địa điểm.',
        textAlign: TextAlign.center,
        style: AppTypography.body,
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

  void _clearTrip() {
    setState(() {
      _trip = null;
      _days = null;
      _daysError = null;
    });
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _MessagePane extends StatelessWidget {
  const _MessagePane(
    this.message, {
    required this.onRetry,
    this.actionLabel = 'Thử lại',
  });

  final String message;
  final VoidCallback onRetry;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, textAlign: TextAlign.center, style: AppTypography.body),
        TextButton(onPressed: onRetry, child: Text(actionLabel)),
      ],
    );
  }
}
