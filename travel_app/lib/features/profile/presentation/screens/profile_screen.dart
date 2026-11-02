import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../application/profile_controller.dart';
import '../../application/profile_showcase_controller.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/profile_showcase_models.dart';
import '../widgets/profile_content_tabs.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stats_section.dart';
import '../widgets/profile_tab_panels.dart';
import '../widgets/profile_travel_identity_card.dart';
import '../profile_showcase_labels.dart';
import '../widgets/profile_trip_showcase.dart';
import 'setting_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  ProfileContentTab _selectedTab = ProfileContentTab.trips;

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final showcaseState = ref.watch(profileShowcaseControllerProvider);
    return AppScaffold(
      topBar: const _ProfileTopBar(),
      body: _ProfileBody(
        profileState: profileState,
        showcaseState: showcaseState,
        selectedTab: _selectedTab,
        onTabChanged: (value) => setState(() => _selectedTab = value),
        onRetry: _refresh,
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.wait([
      ref.read(profileControllerProvider.notifier).refreshProfile(),
      ref.read(profileShowcaseControllerProvider.notifier).refresh(),
    ]);
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({
    required this.profileState,
    required this.showcaseState,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onRetry,
  });

  final AsyncValue<ProfileModel> profileState;
  final AsyncValue<ProfileShowcase> showcaseState;
  final ProfileContentTab selectedTab;
  final ValueChanged<ProfileContentTab> onTabChanged;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = profileState.hasError
        ? profileState.error
        : showcaseState.hasError
        ? showcaseState.error
        : null;
    if (failure != null &&
        (!profileState.hasValue || !showcaseState.hasValue)) {
      return _ProfileFailure(error: failure, onRetry: onRetry);
    }
    final profile = profileState.asData?.value;
    final showcase = showcaseState.asData?.value;
    if (profile == null || showcase == null) return const _ProfileSkeleton();
    return RefreshIndicator(
      onRefresh: onRetry,
      color: AppColors.primary,
      child: _ProfileContent(
        profile: profile,
        showcase: showcase,
        selectedTab: selectedTab,
        onTabChanged: onTabChanged,
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.profile,
    required this.showcase,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final ProfileModel profile;
  final ProfileShowcase showcase;
  final ProfileContentTab selectedTab;
  final ValueChanged<ProfileContentTab> onTabChanged;

  @override
  Widget build(BuildContext context) => ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.screenHorizontal,
      AppSpacing.lg,
      AppSpacing.screenHorizontal,
      AppSpacing.safeBottom,
    ),
    children: [
      ProfileHeader(
        profile: profile,
        verified: profileShowsVerifiedBadge(showcase.hostStatus),
        rankLabel: profileRankLabel(showcase.ranking),
        pointsLabel: profilePointsLabel(showcase.ranking.totalPoints),
      ),
      const SizedBox(height: AppSpacing.lg),
      ProfileStatsSection(
        destinationCount: profile.visitedCount,
        tripCount: showcase.social.tripCount,
        followerCount: showcase.social.followerCount,
        followingCount: showcase.social.followingCount,
      ),
      const SizedBox(height: AppSpacing.md),
      Row(
        children: [
          Expanded(
            child: AppButton(
              label: 'Chỉnh sửa hồ sơ',
              leadingIcon: Icons.edit_note_rounded,
              variant: AppButtonVariant.secondary,
              onPressed: () => context.pushNamed(RouteNames.editProfile),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AppButton(
            label: 'Mã QR',
            leadingIcon: Icons.qr_code_2_rounded,
            variant: AppButtonVariant.glass,
            expand: false,
            onPressed: () => _soon(context, 'Mã QR'),
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.lg),
      ProfileTravelIdentityCard(
        dna: showcase.travelDna,
        onExplore: () => context.pushNamed(RouteNames.travelDnaRadar),
      ),
      const SizedBox(height: AppSpacing.xl),
      ProfileContentTabs(
        value: selectedTab,
        onChanged: onTabChanged,
        tripCount: showcase.social.tripCount,
        savedCount: showcase.savedPlaces.count,
        postCount: showcase.posts.count,
      ),
      const SizedBox(height: AppSpacing.xl),
      switch (selectedTab) {
        ProfileContentTab.trips => ProfileTripShowcase(
          showcase: showcase,
          onSeeAllTrips: () => context.goNamed(RouteNames.trips),
          onOpenOngoing: () => _soon(context, 'Chi tiết chuyến đi'),
          onOpenUpcoming: () => _soon(context, 'Chi tiết chuyến đi'),
          onOpenMemories: () => context.pushNamed(RouteNames.userMemories),
        ),
        ProfileContentTab.dna => ProfileDnaIndex(
          traits: showcase.travelDna.all,
        ),
        ProfileContentTab.saved => ProfileSavedList(
          items: showcase.savedPlaces.items,
          onOpen: (_) => context.pushNamed(RouteNames.savedPlaces),
          onSeeAll: () => context.pushNamed(RouteNames.savedPlaces),
        ),
        ProfileContentTab.posts => ProfilePostsGrid(
          posts: showcase.posts.items,
          onOpen: (_) => _soon(context, 'Bài viết'),
        ),
      },
    ],
  );
}

class _ProfileTopBar extends ConsumerWidget {
  const _ProfileTopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) => AppGlassSurface(
    radius: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.screenHorizontal,
    ),
    shadows: const [],
    child: SizedBox(
      height: 64,
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            backgroundColor: AppColors.surfaceSubdued,
            onPressed: Navigator.of(context).canPop()
                ? () => context.pop()
                : () => context.goNamed(RouteNames.home),
            semanticLabel: 'Quay lại',
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Hồ Sơ Cá Nhân',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.screenTitle,
            ),
          ),
          AppIconButton(
            icon: Icons.biotech_rounded,
            backgroundColor: AppColors.surfaceSubdued,
            onPressed: () => context.pushNamed(RouteNames.travelDnaRadar),
            semanticLabel: 'Xem Travel DNA',
          ),
          const SizedBox(width: AppSpacing.xs),
          AppIconButton(
            icon: Icons.settings_outlined,
            backgroundColor: AppColors.surfaceSubdued,
            onPressed: () {
              final profile = ref.read(profileControllerProvider).value;
              if (profile == null) return;
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => SettingScreen(profile: profile),
                ),
              );
            },
            semanticLabel: 'Cài đặt',
          ),
        ],
      ),
    ),
  );
}

class _ProfileFailure extends StatelessWidget {
  const _ProfileFailure({required this.error, required this.onRetry});

  final Object error;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = error;
    final unauthorized = failure is ApiException && failure.statusCode == 401;
    final message = unauthorized
        ? 'Đăng nhập lại để xem hồ sơ và Travel DNA.'
        : failure is ApiException
        ? failure.message
        : 'Đã xảy ra lỗi. Vui lòng thử lại.';
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không thể tải hồ sơ',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : () => onRetry(),
    );
  }
}

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
    children: const [
      Center(child: AppSkeleton(width: 96, height: 96, radius: 999)),
      SizedBox(height: AppSpacing.sm),
      Center(child: AppSkeleton(width: 150, height: 22)),
      SizedBox(height: AppSpacing.xs),
      Center(child: AppSkeleton(width: 180, height: 16)),
      SizedBox(height: AppSpacing.xl),
      AppSkeleton(width: double.infinity, height: 72),
      SizedBox(height: AppSpacing.md),
      AppSkeleton(width: double.infinity, height: 168),
      SizedBox(height: AppSpacing.md),
      AppSkeleton(width: double.infinity, height: 46, radius: 999),
    ],
  );
}

void _soon(BuildContext context, String feature) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('$feature — sắp có')));
}
