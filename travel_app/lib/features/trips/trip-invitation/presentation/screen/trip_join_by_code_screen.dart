import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';

import '../../application/trip_join_by_code_controller.dart';
import '../../utils/trip_join_by_code_formatters.dart';
import '../widgets/trip_join_by_code_hero.dart';
import '../widgets/trip_join_by_code_input.dart';
import '../widgets/trip_join_by_code_message_field.dart';
import '../widgets/trip_join_by_code_preview_card.dart';
import '../widgets/trip_join_by_code_top_bar.dart';

/// Người dùng nhập mã mời và gửi yêu cầu tham gia chuyến đi.
class TripJoinByCodeScreen extends ConsumerStatefulWidget {
  const TripJoinByCodeScreen({super.key});

  @override
  ConsumerState<TripJoinByCodeScreen> createState() =>
      _TripJoinByCodeScreenState();
}

class _TripJoinByCodeScreenState extends ConsumerState<TripJoinByCodeScreen> {
  String _code = '';
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(RouteNames.trips);
    }
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$feature sẽ được bổ sung khi luồng sẵn sàng.')),
      );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final result = await ref
        .read(tripJoinByCodeControllerProvider.notifier)
        .submit(inviteCode: _code, message: _messageController.text);
    if (!mounted || result == null) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(joinByCodeSuccessMessage(result.request))),
      );

    if (result.isApproved) {
      context.goNamed(
        RouteNames.tripDetail,
        pathParameters: {'tripId': result.request.tripId},
      );
    } else {
      _goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(tripJoinByCodeControllerProvider);
    final isLoading = submitState.isSubmitting;
    final previewAsync = ref.watch(tripJoinInvitePreviewProvider(_code));
    final preview = previewAsync.asData?.value;
    // Prefer settled error over a transient loading flag (Riverpod 3 can keep
    // isLoading true while retrying; we disable retry but still guard the UI).
    final previewError = previewAsync.hasError ? previewAsync.error : null;
    final isPreviewLoading =
        previewAsync.isLoading &&
        !previewAsync.hasError &&
        isInviteCodeComplete(_code);
    final canSubmit = isInviteCodeComplete(_code) && !isLoading;
    final error = submitState.error;

    return AppScaffold(
      // Keep body above the sticky CTA so taps hit the button, not the scroll
      // layer underneath (extendBody defaults to true on AppScaffold).
      extendBody: false,
      topBar: TripJoinByCodeTopBar(
        onBack: _goBack,
        onScanQr: () => _showComingSoon('Quét mã QR nhóm du lịch'),
      ),
      bottomNavigationBar: _JoinByCodeActions(
        isLoading: isLoading,
        canSubmit: canSubmit,
        error: error,
        onSubmit: _submit,
        onScanQr: () => _showComingSoon('Quét mã QR nhóm du lịch'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.sm,
          AppSpacing.screenHorizontal,
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TripJoinByCodeHero(),
            const SizedBox(height: AppSpacing.lg),
            TripJoinByCodeInput(
              code: _code,
              isValidPreview: preview != null,
              onCodeChanged: (code) {
                ref
                    .read(tripJoinByCodeControllerProvider.notifier)
                    .clearError();
                setState(() => _code = code);
              },
            ),
            if (isPreviewLoading) ...[
              const SizedBox(height: AppSpacing.md),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ],
            if (preview != null) ...[
              const SizedBox(height: AppSpacing.md),
              TripJoinByCodePreviewCard(preview: preview),
            ],
            if (previewError != null && isInviteCodeComplete(_code)) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                joinByCodePreviewErrorMessage(previewError),
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(color: AppColors.danger),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            TripJoinByCodeMessageField(
              controller: _messageController,
              enabled: !isLoading,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Yêu cầu của bạn sẽ được gửi trực tiếp đến Trưởng nhóm phê duyệt '
              'qua hệ thống Teal Horizon.',
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JoinByCodeActions extends StatelessWidget {
  const _JoinByCodeActions({
    required this.isLoading,
    required this.canSubmit,
    required this.onSubmit,
    required this.onScanQr,
    this.error,
  });

  final bool isLoading;
  final bool canSubmit;
  final Object? error;
  final VoidCallback onSubmit;
  final VoidCallback onScanQr;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AppGlassSurface(
        radius: 0,
        color: AppColors.glass85,
        shadows: const [],
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.sm,
          AppSpacing.screenHorizontal,
          AppSpacing.sm + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (error != null) ...[
              Text(
                joinByCodeErrorMessage(error!),
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(color: AppColors.danger),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            AppButton(
              key: const Key('trip_join_by_code_submit'),
              label: isLoading
                  ? 'Đang gửi yêu cầu...'
                  : 'Gửi Yêu Cầu Tham Gia Chuyến Đi',
              trailingIcon: isLoading ? null : Icons.arrow_forward_rounded,
              isLoading: isLoading,
              onPressed: canSubmit ? onSubmit : null,
            ),
            const SizedBox(height: AppSpacing.xs),
            AppButton(
              label: 'Hoặc Quét Mã QR Nhóm Du Lịch',
              variant: AppButtonVariant.secondary,
              leadingIcon: Icons.qr_code_scanner_rounded,
              onPressed: isLoading ? null : onScanQr,
            ),
          ],
        ),
      ),
    );
  }
}
