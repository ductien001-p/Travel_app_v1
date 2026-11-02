import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/router_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_scaffold.dart';
import '../../../core/widget/app_text_field.dart';
import '../application/forgot_password_controller.dart';
import 'widgets/auth_form_error.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Vui lòng nhập email.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Email chưa đúng định dạng.';
    }
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    final succeeded = await ref
        .read(forgotPasswordControllerProvider.notifier)
        .requestReset(email: email);
    if (!mounted || !succeeded) return;
    context.goNamed(
      RouteNames.resetPassword,
      queryParameters: {'email': email},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordControllerProvider);

    return AppScaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(onBack: () => context.goNamed(RouteNames.login)),
                  const SizedBox(height: 28),
                  const _RecoveryProgress(),
                  const SizedBox(height: 28),
                  const _HeroIcon(),
                  const SizedBox(height: 20),
                  Text(
                    'Quên mật khẩu? 🔑',
                    textAlign: TextAlign.center,
                    style: AppTypography.display.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              'Đừng lo lắng! Vui lòng nhập địa chỉ email đã đăng ký với ',
                        ),
                        TextSpan(
                          text: 'Teal Horizon',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primaryActive,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const TextSpan(
                          text:
                              '. Chúng tôi sẽ gửi mã xác thực OTP gồm 6 chữ số để bạn đặt lại mật khẩu an toàn.',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      fontSize: 15,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _EmailCard(
                    controller: _emailController,
                    enabled: !state.isLoading,
                    validator: _validateEmail,
                    onChanged: (_) => setState(() {}),
                    onClear: () {
                      _emailController.clear();
                      setState(() {});
                    },
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 16),
                  const _DeliveryMethodCard(),
                  if (state.hasError) ...[
                    const SizedBox(height: 16),
                    AuthFormError(error: state.error!),
                  ],
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Gửi mã xác nhận',
                    trailingIcon: Icons.arrow_forward_rounded,
                    isLoading: state.isLoading,
                    onPressed: state.isLoading ? null : _submit,
                  ),
                  const SizedBox(height: 16),
                  const _SecurityBadge(),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nhớ lại mật khẩu? ', style: AppTypography.body),
                      TextButton(
                        onPressed: state.isLoading
                            ? null
                            : () => context.goNamed(RouteNames.login),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          foregroundColor: AppColors.primaryActive,
                          textStyle: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        child: const Text('Đăng nhập ngay'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          _CircleIcon(icon: Icons.arrow_back_rounded, onPressed: onBack),
          Expanded(
            child: Text(
              'Khôi phục mật khẩu',
              textAlign: TextAlign.center,
              style: AppTypography.screenTitle,
            ),
          ),
          const _CircleIcon(icon: Icons.shield_outlined),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.glass85,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.primaryActive, size: 22),
      ),
    );
  }
}

class _RecoveryProgress extends StatelessWidget {
  const _RecoveryProgress();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          Row(
            children: [
              const _StepCircle(label: '1', active: true),
              Expanded(child: Container(height: 3, color: AppColors.primary)),
              Expanded(
                child: Container(height: 3, color: AppColors.borderNeutral),
              ),
              const _StepCircle(label: '2'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gửi mã',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primaryActive,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('Mật khẩu mới', style: AppTypography.body),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.label, this.active = false});
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.glass90,
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? AppColors.surface : AppColors.borderNeutral,
          width: active ? 3 : 2,
        ),
        boxShadow: AppShadows.level1,
      ),
      child: Text(
        label,
        style: AppTypography.bodyMedium.copyWith(
          color: active ? AppColors.textInverse : AppColors.textTertiary,
        ),
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 112,
        height: 112,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.glass75,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.glassBorder),
                boxShadow: AppShadows.level1,
              ),
              alignment: Alignment.center,
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 38,
                  color: AppColors.primary,
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryActive,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 3),
                  boxShadow: AppShadows.level1,
                ),
                child: const Icon(
                  Icons.key_rounded,
                  size: 20,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailCard extends StatelessWidget {
  const _EmailCard({
    required this.controller,
    required this.enabled,
    required this.validator,
    required this.onChanged,
    required this.onClear,
    required this.onSubmitted,
  });
  final TextEditingController controller;
  final bool enabled;
  final String? Function(String?) validator;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Email tài khoản', style: AppTypography.cardTitle),
              const SizedBox(width: 8),
              Text('(Đã đăng ký)', style: AppTypography.caption),
              const Spacer(),
              Text(
                'BẮT BUỘC',
                style: AppTypography.badge.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller,
            hint: 'email@example.com',
            leadingIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: validator,
            enabled: enabled,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            trailing: controller.text.isEmpty
                ? null
                : IconButton(
                    onPressed: enabled ? onClear : null,
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: AppColors.textTertiary,
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.verified_outlined,
                size: 18,
                color: AppColors.primaryActive,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Chúng tôi sẽ gửi mã bảo mật OTP 6 chữ số qua hộp thư này.',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeliveryMethodCard extends StatelessWidget {
  const _DeliveryMethodCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PHƯƠNG THỨC NHẬN MÃ',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary08,
              borderRadius: BorderRadius.circular(AppRadius.input),
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: AppColors.glass90,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.primaryActive,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gửi qua Email', style: AppTypography.cardTitle),
                      Text(
                        'Mã OTP sẽ được gửi đến email đã nhập',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.circle,
                    color: AppColors.textInverse,
                    size: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: child,
    );
  }
}

class _SecurityBadge extends StatelessWidget {
  const _SecurityBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.glass75,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.shield_outlined,
                  size: 17,
                  color: AppColors.success,
                ),
              ),
              const TextSpan(text: '  Bảo mật thông tin chuẩn '),
              TextSpan(
                text: 'SSL 256-bit',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
