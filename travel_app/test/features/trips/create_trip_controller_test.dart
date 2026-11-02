import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/application/create_trip_controller.dart';
import 'package:travel_frontend_v1/features/trips/application/trip_list_controller.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_query.dart';
import 'package:travel_frontend_v1/features/trips/data/repositories/trip_repository.dart';
import 'package:travel_frontend_v1/features/trips/provider/trips_provider.dart';

void main() {
  late _FakeTripRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeTripRepository();
    container = ProviderContainer(
      overrides: [tripRepositoryProvider.overrideWithValue(repository)],
    );
  });

  tearDown(() => container.dispose());

  test('finalize reloads the trips dashboard with the new trip', () async {
    container.listen(tripDashboardControllerProvider, (_, _) {});
    await container.read(tripDashboardControllerProvider.future);
    expect(
      container.read(tripDashboardControllerProvider).value?.summary.upcoming,
      0,
    );

    repository.upcomingCount = 1;
    await container.read(createTripControllerProvider.notifier).finalize('t-1');

    final dashboard = await container.read(
      tripDashboardControllerProvider.future,
    );
    expect(dashboard.summary.upcoming, 1);
    expect(repository.finalizedTripIds, ['t-1']);
  });

  test('a failed finalize keeps the dashboard and rethrows', () async {
    container.listen(tripDashboardControllerProvider, (_, _) {});
    await container.read(tripDashboardControllerProvider.future);
    final callsBefore = repository.getTripsCalls;
    repository.finalizeError = StateError('network down');

    await expectLater(
      container.read(createTripControllerProvider.notifier).finalize('t-1'),
      throwsStateError,
    );
    expect(repository.getTripsCalls, callsBefore);
    expect(container.read(createTripControllerProvider).hasError, isTrue);
  });
}

class _FakeTripRepository implements TripRepository {
  int upcomingCount = 0;
  int getTripsCalls = 0;
  Object? finalizeError;
  final finalizedTripIds = <String>[];

  @override
  Future<TripListPage> getTrips(TripQuery query) async {
    getTripsCalls++;
    return TripListPage(
      items: const [],
      meta: const PageMeta(
        page: 1,
        limit: 5,
        total: 0,
        totalPages: 0,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
      summary: TripSummary(
        total: upcomingCount,
        upcoming: upcomingCount,
        ongoing: 0,
        completed: 0,
        cancelled: 0,
        notCompleted: 0,
        totalCheckins: 0,
      ),
    );
  }

  @override
  Future<Trip> finalizeTrip(String tripId) async {
    if (finalizeError != null) throw finalizeError!;
    finalizedTripIds.add(tripId);
    return Trip.fromJson({
      'id': tripId,
      'name': 'Trip',
      'startDate': '2026-10-12T00:00:00.000Z',
      'endDate': '2026-10-16T00:00:00.000Z',
      'maxMembers': 6,
      'tripType': 'COUPLE',
      'visibility': 'PUBLIC',
      'status': 'UPCOMING',
      'createdAt': '2026-10-12T00:00:00.000Z',
      'updatedAt': '2026-10-12T00:00:00.000Z',
      'inviteCode': 'ABCDEFGH',
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
