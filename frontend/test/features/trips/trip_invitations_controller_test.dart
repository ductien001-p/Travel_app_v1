import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/application/trip_invitations_controller.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_enums.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_related_models.dart';
import 'package:travel_frontend_v1/features/trips/data/repositories/trip_repository.dart';
import 'package:travel_frontend_v1/features/trips/provider/trips_provider.dart';

void main() {
  test('loadMore stores the error and clears the loading flag', () async {
    final repository = _Invitations();
    final container = ProviderContainer(
      overrides: [tripRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    container.listen(tripInvitationsControllerProvider, (_, _) {});

    final first = await container.read(tripInvitationsControllerProvider.future);
    expect(first.items, hasLength(1));
    expect(first.meta.hasNextPage, isTrue);

    repository.failNext = true;
    await container.read(tripInvitationsControllerProvider.notifier).loadMore();

    final failed = container.read(tripInvitationsControllerProvider).requireValue;
    expect(failed.isLoadingMore, isFalse);
    expect(failed.loadMoreError, isA<StateError>());
    expect(failed.items, hasLength(1));
    expect(failed.meta.hasNextPage, isTrue);
  });
}

class _Invitations implements TripRepository {
  var failNext = false;

  @override
  Future<PageResult<TripInvitation>> getReceivedInvitations({
    int page = 1,
    int limit = 20,
  }) async {
    if (page > 1 && failNext) throw StateError('down');
    return PageResult(
      items: [
        TripInvitation(
          id: 'invite-$page',
          tripId: 'trip-1',
          inviterId: 'owner-1',
          inviteeId: 'me',
          status: TripInvitationStatus.pending,
          createdAt: DateTime.utc(2026, 10, 1),
          updatedAt: DateTime.utc(2026, 10, 1),
        ),
      ],
      meta: PageMeta(
        page: page,
        limit: limit,
        total: 2,
        totalPages: 2,
        hasNextPage: page < 2,
        hasPreviousPage: page > 1,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
