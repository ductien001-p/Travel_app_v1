import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_edit_activity_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';

import 'trip_itinerary_fixture.dart';

const _tripId = 'trip-1';

void main() {
  final dayDate = DateTime.utc(2026, 7, 16);
  final myKhe = datamockItinerary().destinations.first.days[1].activities
      .firstWhere((activity) => activity.id == 'activity-my-khe');

  TripActivityEditInput input({
    String? title,
    int? startMinutes = 8 * 60 + 30,
    String duration = '120',
    String cost = '0',
    String notes = '',
  }) => TripActivityEditInput(
    title: title ?? myKhe.title,
    startMinutes: startMinutes,
    duration: duration,
    cost: cost,
    notes: notes,
  );

  TripActivityEditValidation validate(TripActivityEditInput value) =>
      validateTripActivityEdit(original: myKhe, dayDate: dayDate, input: value);

  group('validateTripActivityEdit', () {
    test('prefills from the activity and detects no change', () {
      final initial = TripActivityEditInput.of(myKhe);
      expect(initial.startMinutes, 8 * 60 + 30);
      expect(initial.duration, '120');

      final result = validate(initial);
      expect(result.errors, isEmpty);
      expect(result.request, isNull);
    });

    test('sends only the changed fields, with time on the day in UTC', () {
      final result = validate(
        input(
          title: '  Tắm biển sớm ',
          startMinutes: 6 * 60,
          notes: ' Mang kem chống nắng ',
        ),
      );

      expect(result.errors, isEmpty);
      expect(result.request!.toJson(), {
        'title': 'Tắm biển sớm',
        'startTime': '2026-07-16T06:00:00.000Z',
        'notes': 'Mang kem chống nắng',
      });
    });

    test('clearing time and duration together clears both', () {
      final result = validate(input(startMinutes: null, duration: ''));

      expect(result.request!.toJson(), {
        'startTime': null,
        'estimatedDuration': null,
      });
    });

    test('rejects invalid values with field errors', () {
      expect(
        validate(input(title: '   ')).errors.keys,
        contains(TripActivityEditField.title),
      );
      expect(
        validate(input(notes: 'x' * 301)).errors.keys,
        contains(TripActivityEditField.notes),
      );
      expect(
        validate(input(duration: '-5')).errors.keys,
        contains(TripActivityEditField.duration),
      );
      expect(
        validate(input(cost: '1.5')).errors.keys,
        contains(TripActivityEditField.cost),
      );
      expect(validate(input(startMinutes: 23 * 60, duration: '120')).errors, {
        TripActivityEditField.duration: 'Hoạt động phải kết thúc trong ngày.',
      });
      expect(
        validate(input(startMinutes: null)).errors.keys,
        contains(TripActivityEditField.startTime),
      );
    });

    test('maps server errors to safe messages', () {
      expect(
        tripActivityEditErrorMessage(
          const ApiException(
            message: 'Activity overlaps another activity',
            statusCode: 400,
            code: 'ACTIVITY_OVERLAP',
          ),
        ),
        'Khung giờ này trùng với hoạt động khác.',
      );
      expect(
        tripActivityEditErrorMessage(
          const ApiException(message: 'internal stack', statusCode: 500),
        ),
        'Không thể lưu thay đổi. Vui lòng thử lại.',
      );
      expect(
        tripActivityEditErrorMessage(
          const ApiException(message: 'nope', statusCode: 403),
        ),
        'Bạn không có quyền sửa lịch trình này.',
      );
    });
  });

  group('TripItineraryEditActivityController', () {
    late FakeItineraryBackend backend;
    late ProviderContainer container;
    final provider = tripItineraryEditActivityControllerProvider(_tripId);

    setUp(() {
      backend = FakeItineraryBackend();
      container = ProviderContainer(
        overrides: [
          tripItineraryRemoteDataSourceProvider.overrideWithValue(
            FakeTripItineraryRemoteDataSource(backend),
          ),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeItineraryTripDetailDataSource(backend),
          ),
          tripItineraryClockProvider.overrideWithValue(() => itineraryNow),
        ],
      )..listen(provider, (_, _) {});
      addTearDown(container.dispose);
    });

    Future<ItineraryActivity> reloadedMyKhe() async {
      final data = await container.read(
        tripItineraryControllerProvider(_tripId).future,
      );
      return data.destinations.first.days[1].activities.firstWhere(
        (activity) => activity.id == myKhe.id,
      );
    }

    test('saves the change and reloads the itinerary', () async {
      await container.read(tripItineraryControllerProvider(_tripId).future);

      final outcome = await container
          .read(provider.notifier)
          .submit(
            original: myKhe,
            dayDate: dayDate,
            input: input(notes: 'Đi sớm tránh nắng'),
          );

      expect(outcome, TripActivityEditOutcome.saved);
      final (activityId, body) = backend.updateRequests.single;
      expect(activityId, 'activity-my-khe');
      expect(body, {'notes': 'Đi sớm tránh nắng'});
      expect((await reloadedMyKhe()).notes, 'Đi sớm tránh nắng');
      expect(container.read(provider).isSubmitting, isFalse);
    });

    test('does not call the server when invalid or unchanged', () async {
      final notifier = container.read(provider.notifier);

      expect(
        await notifier.submit(
          original: myKhe,
          dayDate: dayDate,
          input: input(title: ''),
        ),
        TripActivityEditOutcome.rejected,
      );
      expect(
        container.read(provider).fieldErrors,
        contains(TripActivityEditField.title),
      );
      expect(
        await notifier.submit(
          original: myKhe,
          dayDate: dayDate,
          input: TripActivityEditInput.of(myKhe),
        ),
        TripActivityEditOutcome.unchanged,
      );
      expect(backend.updateRequests, isEmpty);
    });

    test('blocks a second submit while saving', () async {
      await container.read(tripItineraryControllerProvider(_tripId).future);
      final notifier = container.read(provider.notifier);

      final first = notifier.submit(
        original: myKhe,
        dayDate: dayDate,
        input: input(cost: '50000'),
      );
      final second = await notifier.submit(
        original: myKhe,
        dayDate: dayDate,
        input: input(cost: '60000'),
      );

      expect(second, TripActivityEditOutcome.rejected);
      expect(await first, TripActivityEditOutcome.saved);
      expect(backend.updateRequests, hasLength(1));
    });

    test('a server rejection shows a safe message', () async {
      await container.read(tripItineraryControllerProvider(_tripId).future);
      backend.updateError = const ApiException(
        message: 'Activity outside destination date range',
        statusCode: 400,
        code: 'OUTSIDE_DESTINATION',
      );

      final outcome = await container
          .read(provider.notifier)
          .submit(
            original: myKhe,
            dayDate: dayDate,
            input: input(startMinutes: 7 * 60),
          );

      expect(outcome, TripActivityEditOutcome.rejected);
      expect(
        container.read(provider).errorMessage,
        'Giờ hoạt động nằm ngoài thời gian ở điểm đến này.',
      );
    });
  });
}
