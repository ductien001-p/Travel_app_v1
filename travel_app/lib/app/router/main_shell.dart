import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_navigation.dart';
import 'package:travel_frontend_v1/features/home/application/explore_home_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/application/trip_publish_providers.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(WidgetRef ref, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    if (index == 0) {
      ref.read(recruitmentSummaryProvider.notifier).refresh();
      ref.read(exploreHomeControllerProvider.notifier).revisit();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => _onDestinationSelected(ref, index),
        onCenterAction: () => context.pushNamed(RouteNames.createTrip),
      ),
    );
  }
}
