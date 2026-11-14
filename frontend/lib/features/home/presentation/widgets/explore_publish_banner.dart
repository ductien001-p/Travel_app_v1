import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../trips/trip-publish/application/publish_entry.dart';
import '../../../trips/trip-publish/application/trip_publish_providers.dart';
import '../../../trips/trip-publish/presentation/publish_entry_flow.dart';
import 'explore_create_trip_banner.dart';

class ExplorePublishBanner extends ConsumerStatefulWidget {
  const ExplorePublishBanner({super.key});

  @override
  ConsumerState<ExplorePublishBanner> createState() =>
      _ExplorePublishBannerState();
}

class _ExplorePublishBannerState extends ConsumerState<ExplorePublishBanner>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(recruitmentSummaryProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(recruitmentSummaryProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(recruitmentSummaryProvider);
    final busy = ref.watch(publishFlowBusyProvider);
    return ExploreCreateTripBanner(
      label: publishBannerLabel(
        activeCount: summary.asData?.value.activeRecruitmentCount,
        summaryFailed: summary.hasError,
      ),
      isLoading: busy,
      onCreateTrip: busy ? null : () => startPublishFlow(context, ref),
    );
  }
}
