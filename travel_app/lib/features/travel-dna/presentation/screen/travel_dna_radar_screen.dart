import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_showcase_controller.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_showcase_models.dart';

import '../../application/travel_dna_radar_controller.dart';
import '../../application/travel_dna_radar_view.dart';
import '../../data/models/travel_dna_models.dart';
import '../widgets/travel_dna_radar_body.dart';

class TravelDnaRadarScreen extends ConsumerWidget {
  const TravelDnaRadarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dna = ref.watch(travelDnaRadarControllerProvider);
    final profile = ref.watch(profileControllerProvider);
    final showcase = ref.watch(profileShowcaseControllerProvider);
    ref.listen(travelDnaRadarControllerProvider, (previous, next) {
      final failedRefresh =
          next.hasError && next.hasValue && previous?.isLoading == true;
      if (!failedRefresh) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tải lại được bản đồ Travel DNA.')),
      );
    });

    return AppScaffold(
      topBar: _TopBar(
        onBack: () => _back(context),
        onShare: dna.hasValue && profile.hasValue
            ? () => _share(
                context,
                dna.requireValue,
                profile.requireValue,
                showcase.value,
              )
            : null,
        onHelp: () => _help(context),
      ),
      body: _body(context, ref, dna, profile, showcase),
    );
  }

  Widget _body(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<TravelDnaRadar> dna,
    AsyncValue<ProfileModel> profile,
    AsyncValue<ProfileShowcase> showcase,
  ) {
    if (!dna.hasValue && dna.isLoading) return const _Skeleton();
    if (!profile.hasValue && profile.isLoading) return const _Skeleton();
    if (dna.hasError && !dna.hasValue) {
      return _Failure(
        error: dna.error!,
        onRetry: () =>
            ref.read(travelDnaRadarControllerProvider.notifier).refresh(),
      );
    }
    if (profile.hasError && !profile.hasValue) {
      return _Failure(
        error: profile.error!,
        onRetry: () =>
            ref.read(profileControllerProvider.notifier).refreshProfile(),
      );
    }

    final radar = dna.requireValue;
    final person = profile.requireValue;
    final view = buildTravelDnaRadarView(
      radar: radar,
      identity: _identity(person, showcase.value),
    );
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () =>
          ref.read(travelDnaRadarControllerProvider.notifier).refresh(),
      child: TravelDnaRadarBody(
        view: view,
        onOpenJourney: () => _openJourney(context, view.journey?.tripId),
        onFindCompanions: () =>
            context.pushNamed(RouteNames.travelDnaCompanions),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.onHelp, this.onShare});

  final VoidCallback onBack;
  final VoidCallback onHelp;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back_rounded,
              iconColor: AppColors.primary,
              semanticLabel: 'Quay lại',
              onPressed: onBack,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bản Đồ Travel DNA',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.screenTitle,
                  ),
                  Text(
                    'Phân tích bản sắc & độ tương thích',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            AppIconButton(
              icon: Icons.share_rounded,
              iconColor: AppColors.primary,
              semanticLabel: 'Chia sẻ hồ sơ DNA',
              onPressed: onShare,
            ),
            const SizedBox(width: AppSpacing.xxs),
            AppIconButton(
              icon: Icons.help_outline_rounded,
              iconColor: AppColors.primary,
              semanticLabel: 'Trợ giúp về DNA',
              onPressed: onHelp,
            ),
          ],
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: const [
        AppSkeleton(width: double.infinity, height: 180),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 320),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 120),
      ],
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({required this.error, required this.onRetry});

  final Object error;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = error;
    final unauthorized = failure is ApiException && failure.statusCode == 401;
    final message = unauthorized
        ? 'Đăng nhập lại để xem bản đồ Travel DNA.'
        : failure is ApiException
        ? failure.message
        : 'Đã xảy ra lỗi. Vui lòng thử lại.';
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không thể tải Travel DNA',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : () => onRetry(),
    );
  }
}

TravelDnaIdentityInput _identity(
  ProfileModel profile,
  ProfileShowcase? showcase,
) {
  final displayName = profile.displayName?.trim();
  final name = displayName == null || displayName.isEmpty
      ? profile.username
      : displayName;
  final ranking = showcase?.ranking;
  return TravelDnaIdentityInput(
    displayName: name,
    initials: profile.initials,
    avatarUrl: profile.avatarUrl,
    verified: showcase?.hostStatus == 'APPROVED',
    rankChip: ranking == null
        ? null
        : travelDnaRankChip(
            rank: ranking.rank,
            totalPoints: ranking.totalPoints,
          ),
  );
}

void _back(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }
  context.goNamed(RouteNames.profile);
}

Future<void> _share(
  BuildContext context,
  TravelDnaRadar radar,
  ProfileModel profile,
  ProfileShowcase? showcase,
) {
  final view = buildTravelDnaRadarView(
    radar: radar,
    identity: _identity(profile, showcase),
  );
  final box = context.findRenderObject();
  final origin = box is RenderBox
      ? box.localToGlobal(Offset.zero) & box.size
      : null;
  return SharePlus.instance.share(
    ShareParams(
      text: travelDnaShareMessage(view),
      subject: 'Travel DNA',
      sharePositionOrigin: origin,
    ),
  );
}

void _help(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Travel DNA là gì?', style: AppTypography.sectionTitle),
      content: Text(
        'Mỗi lần check-in, điểm của các trục bản sắc được tính lại. '
        'Trục cao nhất là chân dung nổi bật. Hành trình gợi ý là chuyến '
        'công khai đang mở khớp DNA của bạn. Bạn đồng hành là bạn bè có '
        'độ hợp từ 70%.',
        style: AppTypography.body,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Đã hiểu'),
        ),
      ],
    ),
  );
}

void _openJourney(BuildContext context, String? tripId) {
  if (tripId == null || tripId.isEmpty) return;
  context.pushNamed(RouteNames.tripDetail, pathParameters: {'tripId': tripId});
}
