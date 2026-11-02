import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/presentation/screen/destination_trips_screen.dart';
import 'package:travel_frontend_v1/features/home/places/presentation/screen/featured_destinations_screen.dart';
import 'package:travel_frontend_v1/features/home/places/place-details/presentation/screen/place_detail_screen.dart';
import 'package:travel_frontend_v1/features/home/presentation/screen/home_screen.dart';
import 'package:travel_frontend_v1/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:travel_frontend_v1/features/profile/presentation/screens/profile_screen.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/presentation/screen/user_memories_screen.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/presentation/screen/saved_places_screen.dart';
import 'package:travel_frontend_v1/features/travel-dna/presentation/screen/travel_dna_companions_screen.dart';
import 'package:travel_frontend_v1/features/travel-dna/presentation/screen/travel_dna_radar_screen.dart';
import 'package:travel_frontend_v1/features/social/presentation/screen/social_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/screen/trip_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/create_trip_details_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/add_destination_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/create_trip_itinerary_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/create_trip_confirmation_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/add_itinerary_activity_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/add_itinerary_activity_state.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_detail_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/shared_itinerary_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_itinerary_map_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_itinerary_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_invite_friends_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_join_by_code_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_join_requests_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/presentation/screen/trip_add_expense_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/presentation/screen/trip_expenses_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/presentation/screen/trip_memories_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/presentation/screen/trip_timeline_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/presentation/manage/publish_trip_manage_screen.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/application/auth_status.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
import '../../features/auth/presentation/verify_email_screen.dart';
import 'main_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _homeNavigatorKey = GlobalKey<NavigatorState>();

final _tripsNavigatorKey = GlobalKey<NavigatorState>();

final _socialNavigatorKey = GlobalKey<NavigatorState>();

final _profileNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  late final GoRouter router;

  router = GoRouter(
    navigatorKey: _rootNavigatorKey,

    initialLocation: '/home',

    redirect: (context, state) => appAuthRedirect(
      auth: ref.read(authControllerProvider),
      location: state.matchedLocation,
      uri: state.uri,
    ),

    routes: [
      /*
       * /shared/:token — itinerary opened from a share link (read-only).
       */
      GoRoute(
        path: '/shared/:token',
        name: RouteNames.sharedItinerary,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            SharedItineraryScreen(token: state.pathParameters['token']!),
      ),

      GoRoute(
        path: '/trips/join',
        name: RouteNames.tripJoinByCode,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const TripJoinByCodeScreen(),
      ),

      GoRoute(
        path: '/trips/create',
        name: RouteNames.createTrip,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreateTripDetailsScreen(),
        routes: [
          GoRoute(
            path: 'add-destination',
            name: RouteNames.addTripDestination,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final data = state.extra;
              return AddDestinationScreen(
                data: data is AddDestinationRouteData
                    ? data
                    : const AddDestinationRouteData(
                        existingDestinationNames: [],
                        existingDestinationIds: [],
                        existingDestinations: [],
                      ),
              );
            },
          ),
          GoRoute(
            path: ':tripId/itinerary',
            name: RouteNames.createTripItinerary,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => CreateTripItineraryScreen(
              tripId: state.pathParameters['tripId']!,
            ),
            routes: [
              GoRoute(
                path: 'activity/new',
                name: RouteNames.addItineraryActivity,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final args = state.extra;
                  final pathTripId = state.pathParameters['tripId'];
                  if (args is AddItineraryActivityArgs &&
                      args.hasValidContext &&
                      args.tripId == pathTripId) {
                    return AddItineraryActivityScreen(args: args);
                  }
                  return Scaffold(
                    appBar: AppBar(title: const Text('Không thể mở biểu mẫu')),
                    body: Center(
                      child: FilledButton(
                        onPressed: context.pop,
                        child: const Text('Quay lại lịch trình'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: ':tripId/confirm',
            name: RouteNames.createTripConfirmation,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => CreateTripConfirmationScreen(
              tripId: state.pathParameters['tripId']!,
            ),
          ),
        ],
      ),

      GoRoute(
        path: '/trips/publish/manage/:tripId',
        name: RouteNames.publishTripManage,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            PublishTripManageScreen(tripId: state.pathParameters['tripId']!),
      ),

      /*
       * Splash
       */
      GoRoute(
        path: '/splash',

        name: RouteNames.splash,

        parentNavigatorKey: _rootNavigatorKey,

        builder: (context, state) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),

      /*
       * Login
       */
      GoRoute(
        path: '/login',

        name: RouteNames.login,

        parentNavigatorKey: _rootNavigatorKey,

        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      GoRoute(
        path: '/register',
        name: RouteNames.register,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),

      GoRoute(
        path: '/forgot-password',
        name: RouteNames.forgotPassword,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return const ForgotPasswordScreen();
        },
      ),

      GoRoute(
        path: '/verify-email',
        name: RouteNames.verifyEmail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return VerifyEmailScreen(
            initialEmail: state.uri.queryParameters['email'],
          );
        },
      ),

      GoRoute(
        path: '/reset-password',
        name: RouteNames.resetPassword,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return ResetPasswordScreen(
            initialEmail: state.uri.queryParameters['email'],
          );
        },
      ),

      GoRoute(
        path: '/home/destination',
        name: RouteNames.destinationTrips,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => DestinationTripsScreen(
          cityName: state.uri.queryParameters['city'] ?? '',
          catalogId: state.uri.queryParameters['catalogId'],
        ),
      ),

      GoRoute(
        path: '/home/featured',
        name: RouteNames.featuredDestinations,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FeaturedDestinationsScreen(),
      ),

      GoRoute(
        path: '/home/places/:placeId',
        name: RouteNames.placeDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            PlaceDetailScreen(placeId: state.pathParameters['placeId'] ?? ''),
      ),

      /*
       * Main authenticated area.
       */
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },

        branches: [
          /*
           * HOME
           */
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,

            routes: [
              GoRoute(
                path: '/home',

                name: RouteNames.home,

                builder: (context, state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),

          /*
           * TRIPS
           */
          StatefulShellBranch(
            navigatorKey: _tripsNavigatorKey,

            routes: [
              GoRoute(
                path: '/trips',

                name: RouteNames.trips,

                builder: (context, state) {
                  return const TripScreen();
                },

                routes: [
                  /*
                   * /trips/:tripId
                   */
                  GoRoute(
                    path: ':tripId',

                    name: RouteNames.tripDetail,

                    parentNavigatorKey: _rootNavigatorKey,

                    builder: (context, state) => TripDetailScreen(
                      tripId: state.pathParameters['tripId']!,
                    ),

                    routes: [
                      /*
                       * /trips/:tripId/itinerary
                       */
                      GoRoute(
                        path: 'itinerary',

                        name: RouteNames.tripItinerary,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripItineraryScreen(
                          tripId: state.pathParameters['tripId']!,
                        ),

                        routes: [
                          /*
                           * /trips/:tripId/itinerary/map?dayId=
                           */
                          GoRoute(
                            path: 'map',

                            name: RouteNames.tripItineraryMap,

                            parentNavigatorKey: _rootNavigatorKey,

                            builder: (context, state) => TripItineraryMapScreen(
                              tripId: state.pathParameters['tripId']!,
                              initialDayId: state.uri.queryParameters['dayId'],
                            ),
                          ),
                        ],
                      ),

                      /*
                       * /trips/:tripId/timeline
                       */
                      GoRoute(
                        path: 'timeline',

                        name: RouteNames.tripTimeline,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripTimelineScreen(
                          tripId: state.pathParameters['tripId']!,
                        ),
                      ),

                      /*
                       * /trips/:tripId/memories?post=1&userId=
                       */
                      GoRoute(
                        path: 'memories',

                        name: RouteNames.tripMemories,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripMemoriesScreen(
                          tripId: state.pathParameters['tripId']!,
                          startPosting: TripMemoriesScreen.startsPosting(
                            state.uri.queryParameters,
                          ),
                          initialUploaderId:
                              TripMemoriesScreen.initialUploaderOf(
                                state.uri.queryParameters,
                              ),
                        ),
                      ),

                      /*
                       * /trips/:tripId/join-requests
                       */
                      GoRoute(
                        path: 'join-requests',

                        name: RouteNames.tripJoinRequests,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripJoinRequestsScreen(
                          tripId: state.pathParameters['tripId']!,
                        ),
                      ),

                      /*
                       * /trips/:tripId/invite
                       */
                      GoRoute(
                        path: 'invite',

                        name: RouteNames.tripInviteFriends,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripInviteFriendsScreen(
                          tripId: state.pathParameters['tripId']!,
                        ),
                      ),

                      /*
                       * /trips/:tripId/expenses
                       */
                      GoRoute(
                        path: 'expenses',

                        name: RouteNames.tripExpenses,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripExpensesScreen(
                          tripId: state.pathParameters['tripId']!,
                        ),
                      ),

                      /*
                       * /trips/:tripId/expenses/add
                       */
                      GoRoute(
                        path: 'expenses/add',

                        name: RouteNames.tripAddExpense,

                        parentNavigatorKey: _rootNavigatorKey,

                        builder: (context, state) => TripAddExpenseScreen(
                          tripId: state.pathParameters['tripId']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          /*
           * SOCIAL
           */
          StatefulShellBranch(
            navigatorKey: _socialNavigatorKey,

            routes: [
              GoRoute(
                path: '/social',

                name: RouteNames.social,

                builder: (context, state) {
                  return const SocialScreen();
                },
              ),
            ],
          ),

          /*
           * PROFILE
           */
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,

            routes: [
              GoRoute(
                path: '/profile',

                name: RouteNames.profile,

                builder: (context, state) {
                  return const ProfileScreen();
                },

                routes: [
                  GoRoute(
                    path: 'edit',
                    name: RouteNames.editProfile,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                  GoRoute(
                    path: 'memories',
                    name: RouteNames.userMemories,
                    builder: (context, state) => const UserMemoriesScreen(),
                  ),
                  GoRoute(
                    path: 'saved-places',
                    name: RouteNames.savedPlaces,
                    builder: (context, state) => const SavedPlacesScreen(),
                  ),
                  GoRoute(
                    path: 'travel-dna',
                    name: RouteNames.travelDnaRadar,
                    builder: (context, state) => const TravelDnaRadarScreen(),
                    routes: [
                      GoRoute(
                        path: 'companions',
                        name: RouteNames.travelDnaCompanions,
                        builder: (context, state) =>
                            const TravelDnaCompanionsScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  /*
   * Khi AuthController thay đổi:
   *
   * AsyncLoading
   * AsyncData
   * AsyncError
   *
   * yêu cầu GoRouter kiểm tra redirect lại.
   */
  ref.listen(authControllerProvider, (previous, next) {
    router.refresh();
  });

  ref.onDispose(router.dispose);

  return router;
});

const _publicAuthPaths = {
  '/login',
  '/register',
  '/forgot-password',
  '/verify-email',
  '/reset-password',
};

/// Auth gate for every navigation.
///
/// The page the user was heading to (e.g. a share link) survives the splash
/// and login screens as `?from=`, and is reopened once signed in.
@visibleForTesting
String? appAuthRedirect({
  required AsyncValue<AuthStatus> auth,
  required String location,
  required Uri uri,
}) {
  final isSplash = location == '/splash';
  final isPublicAuth = _publicAuthPaths.contains(location);
  final from = safeReturnPath(uri.queryParameters['from']);
  final target = isSplash || isPublicAuth ? from : safeReturnPath('$uri');

  /*
   * App đang kiểm tra refresh token.
   */
  if (auth.isLoading) {
    /*
     * Nếu login request đang chạy,
     * không redirect khỏi login.
     */
    if (isPublicAuth) return null;

    /*
     * Bootstrap app:
     * đưa về splash.
     */
    return isSplash ? null : _withReturnPath('/splash', target);
  }

  /*
   * Có lỗi auth hoặc chưa login.
   */
  if (auth.hasError || auth.value == AuthStatus.unauthenticated) {
    return isPublicAuth ? null : _withReturnPath('/login', target);
  }

  /*
   * Đã login.
   */
  if (auth.value == AuthStatus.authenticated && (isPublicAuth || isSplash)) {
    return from ?? '/home';
  }

  return null;
}

/// [raw] if it is an in-app path worth returning to, otherwise null.
///
/// Rejects anything with a scheme or host (open redirect), protocol-relative
/// `//` paths, backslashes and the auth pages themselves (redirect loops).
@visibleForTesting
String? safeReturnPath(String? raw) {
  if (raw == null || raw.isEmpty || raw.length > 512) return null;
  if (!raw.startsWith('/') || raw.startsWith('//') || raw.contains(r'\')) {
    return null;
  }
  final uri = Uri.tryParse(raw);
  if (uri == null || uri.hasScheme || uri.hasAuthority) return null;
  if (uri.path == '/home' ||
      uri.path == '/splash' ||
      _publicAuthPaths.contains(uri.path)) {
    return null;
  }
  return uri.toString();
}

String _withReturnPath(String path, String? target) => target == null
    ? path
    : Uri(path: path, queryParameters: {'from': target}).toString();
