import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../application/travel_dna_radar_controller.dart';
import '../../application/travel_dna_radar_view.dart';
import '../../data/models/travel_dna_models.dart';
import '../widgets/travel_dna_suggestions.dart';

class TravelDnaCompanionsScreen extends ConsumerWidget {
  const TravelDnaCompanionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dna = ref.watch(travelDnaRadarControllerProvider);
    return AppScaffold(
      topBar: _TopBar(onBack: () => _back(context)),
      body: _body(context, ref, dna),
    );
  }

  Widget _body(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<TravelDnaRadar> dna,
  ) {
    if (!dna.hasValue && dna.isLoading) return const _Skeleton();
    if (dna.hasError && !dna.hasValue) {
      return _Failure(
        error: dna.error!,
        onRetry: () =>
            ref.read(travelDnaRadarControllerProvider.notifier).refresh(),
      );
    }

    final companions = travelDnaCompanionViews(dna.requireValue.companions);
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () =>
          ref.read(travelDnaRadarControllerProvider.notifier).refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.safeBottom,
        ),
        children: [
          if (companions.isEmpty)
            const AppEmptyView(
              title: 'Chưa có bạn hợp gu',
              description:
                  'Bạn bè có Travel DNA giống bạn từ 70% sẽ hiện ở đây.',
              icon: Icons.groups_rounded,
            )
          else
            for (final companion in companions) ...[
              TravelDnaCompanionTile(companion: companion),
              const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

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
                    'Bạn Đồng Hành',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.screenTitle,
                  ),
                  Text(
                    'Bạn bè có độ hợp DNA từ 70%',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 48),
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
        AppSkeleton(width: double.infinity, height: 72),
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 72),
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 72),
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
        ? 'Đăng nhập lại để xem bạn đồng hành.'
        : failure is ApiException
        ? failure.message
        : 'Đã xảy ra lỗi. Vui lòng thử lại.';
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không thể tải bạn đồng hành',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : () => onRetry(),
    );
  }
}

void _back(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }
  context.goNamed(RouteNames.travelDnaRadar);
}
