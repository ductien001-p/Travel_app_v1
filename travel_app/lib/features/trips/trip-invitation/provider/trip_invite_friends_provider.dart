import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/trip_invite_friends_datasource.dart';
import '../data/datasources/trip_invite_friends_remote_datasource.dart';
import '../data/repositories/trip_invite_friends_repository.dart';

final tripInviteFriendsDataSourceProvider =
    Provider<TripInviteFriendsDataSource>(
      (ref) => TripInviteFriendsRemoteDataSource(
        apiClient: ref.watch(apiClientProvider),
      ),
    );

final tripInviteFriendsRepositoryProvider =
    Provider<TripInviteFriendsRepository>(
      (ref) => TripInviteFriendsRepository(
        dataSource: ref.watch(tripInviteFriendsDataSourceProvider),
      ),
    );
