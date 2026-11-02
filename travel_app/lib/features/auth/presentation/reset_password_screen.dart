import 'dart:async';

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
import '../application/reset_password_controller.dart';
import 'widgets/auth_form_error.dart';
import 'widgets/password_field.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, this.initialEmail});

  final String? initialEmail;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  Timer? _timer;
  int _resendSeconds = 45;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController.addListener(_refresh);
    _confirmController.addListener(_refresh);
    _startCountdown();
  }

  void _refresh() => setState(() {});

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _resendSeconds = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _tokenController.dispose();
    _passwordController
      ..removeListener(_refresh)
      ..dispose();
    _confirmController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Vui lòng quay lại và nhập email.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Email chưa đúng định dạng.';
    }
    return null;
  }

  String? _validateToken(String? value) {
    final token = value?.trim() ?? '';
    if (token.isEmpty) return 'Vui lòng nhập mã xác thực.';
    if (!RegExp(r'^\d{6}$').hasMatch(token)) {
      return 'Mã xác thực phải gồm 6 chữ số.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu mới.';
    if (value.length < 8) return 'Mật khẩu phải có ít nhất 8 ký tự.';
    return null;
  }

  String? _validateConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu.';
    }
    if (value != _passwordController.text) return 'Mật khẩu không khớp.';
    return null;
  }

  Future<void> _resend() async {
    if (_validateEmail(_emailController.text) != null) {
      if (mounted) context.goNamed(RouteNames.forgotPassword);
      return;
    }
    final succeeded = await ref
        .read(forgotPasswordControllerProvider.notifier)
        .requestReset(email: _emailController.text.trim());
    if (!mounted || !succeeded) return;
    _startCountdown();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Mã xác thực mới đã được gửi.')),
      );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final succeeded = await ref
        .read(resetPasswordControllerProvider.notifier)
        .resetPassword(
          email: _emailController.text.trim(),
          token: _tokenController.text.trim(),
          newPassword: _passwordController.text,
        );
    if (!mounted || !succeeded) return;
    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(resetPasswordControllerProvider);
    final resendState = ref.watch(forgotPasswordControllerProvider);
    final loading = resetState.isLoading || resendState.isLoading;
    final password = _passwordController.text;
    final hasLength = password.length >= 8;
    final hasUpperAndNumber =
        RegExp('[A-Z]').hasMatch(password) && RegExp(r'\d').hasMatch(password);
    final passwordsMatch =
        _confirmController.text.isNotEmpty &&
        _confirmController.text == _passwordController.text;

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
                  _Header(
                    onBack: () => context.goNamed(RouteNames.forgotPassword),
                  ),
                  const SizedBox(height: 24),
                  const _RecoveryProgress(),
                  const SizedBox(height: 24),
                  const _HeroIcon(),
                  const SizedBox(height: 20),
                  Text(
                    'Đặt lại mật khẩu mới',
                    textAlign: TextAlign.center,
                    style: AppTypography.display.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tạo mật khẩu mạnh có ít nhất 8 ký tự để bảo vệ tài khoản Teal Horizon của bạn.',
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 28),
                  Text('Tài khoản khôi phục', style: AppTypography.bodyMedium),
                  const SizedBox(height: 8),
                  _AccountCard(email: _emailController.text),
                  if (_emailController.text.trim().isEmpty) ...[
                    const SizedBox(height: 12),
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      leadingIcon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      enabled: !loading,
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Mã xác thực (Token OTP)',
                          style: AppTypography.bodyMedium,
                        ),
                      ),
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _resendSeconds == 0
                            ? 'Có thể gửi lại'
                            : 'Gửi lại sau ${_resendSeconds}s',
                        style: AppTypography.caption.copyWith(
                          color: _resendSeconds == 0
                              ? AppColors.primaryActive
                              : AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _tokenController,
                    hint: 'Nhập mã 6 chữ số',
                    leadingIcon: Icons.pin_outlined,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: _validateToken,
                    enabled: !loading,
                    trailing: TextButton.icon(
                      onPressed: _resendSeconds == 0 && !loading
                          ? _resend
                          : null,
                      icon: const Icon(Icons.send_outlined, size: 16),
                      label: const Text('Gửi lại'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Mật khẩu mới', style: AppTypography.bodyMedium),
                  const SizedBox(height: 8),
                  PasswordField(
                    controller: _passwordController,
                    label: 'Mật khẩu mới',
                    textInputAction: TextInputAction.next,
                    validator: _validatePassword,
                    enabled: !loading,
                  ),
                  const SizedBox(height: 12),
                  _PasswordStrength(
                    hasLength: hasLength,
                    hasUpperAndNumber: hasUpperAndNumber,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Xác nhận mật khẩu mới',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  PasswordField(
                    controller: _confirmController,
                    label: 'Xác nhận mật khẩu mới',
                    textInputAction: TextInputAction.done,
                    validator: _validateConfirmation,
                    enabled: !loading,
                    onSubmitted: (_) => _submit(),
                  ),
                  if (passwordsMatch) ...[
                    const SizedBox(height: 8),
                    Text(
                      '✓ Mật khẩu khớp hoàn toàn',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  if (resetState.hasError || resendState.hasError) ...[
                    const SizedBox(height: 16),
                    AuthFormError(
                      error: resetState.hasError
                          ? resetState.error!
                          : resendState.error!,
                    ),
                  ],
                  const SizedBox(height: 28),
                  AppButton(
                    label: 'Cập nhật mật khẩu mới',
                    trailingIcon: Icons.arrow_forward_rounded,
                    isLoading: resetState.isLoading,
                    onPressed: loading ? null : _submit,
                  ),
                  const SizedBox(height: 16),
                  const _SecurityBadge(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nhớ mật khẩu cũ? ', style: AppTypography.body),
                      TextButton(
                        onPressed: loading
                            ? null
                            : () => context.goNamed(RouteNames.login),
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
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: Row(
      children: [
        _RoundIcon(icon: Icons.arrow_back_rounded, onPressed: onBack),
        Expanded(
          child: Text(
            'Khôi phục mật khẩu',
            textAlign: TextAlign.center,
            style: AppTypography.screenTitle,
          ),
        ),
        const _RoundIcon(icon: Icons.shield_outlined),
      ],
    ),
  );
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Container(
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
      icon: Icon(icon, color: AppColors.primaryActive, size: 21),
    ),
  );
}

class _RecoveryProgress extends StatelessWidget {
  const _RecoveryProgress();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Row(
          children: [
            const _ProgressDot(icon: Icons.check_rounded),
            Expanded(child: Container(height: 3, color: AppColors.success)),
            const _ProgressDot(label: '2'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gửi mã', style: AppTypography.caption),
            Text(
              'Mật khẩu mới',
              style: AppTypography.caption.copyWith(
                color: AppColors.primaryActive,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _ProgressDot extends StatelessWidget {
  const _ProgressDot({this.label, this.icon});
  final String? label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 38,
    height: 38,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: icon == null ? AppColors.primary : AppColors.success,
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.primaryLight, width: 5),
    ),
    child: icon == null
        ? Text(
            label!,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textInverse,
            ),
          )
        : Icon(icon, color: AppColors.textInverse, size: 18),
  );
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.glass85,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: const Icon(
        Icons.lock_open_rounded,
        size: 38,
        color: AppColors.primary,
      ),
    ),
  );
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.email});
  final String email;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.glass90,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(color: AppColors.borderBrandSoft),
      boxShadow: AppShadows.level1,
    ),
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.surfaceSubdued,
          child: Icon(Icons.alternate_email_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            email.isEmpty ? 'Chưa có email' : email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.cardTitle,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.primary20),
          ),
          child: Text(
            '✓ Đã xác thực',
            style: AppTypography.caption.copyWith(
              color: AppColors.primaryActive,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

class _PasswordStrength extends StatelessWidget {
  const _PasswordStrength({
    required this.hasLength,
    required this.hasUpperAndNumber,
  });
  final bool hasLength;
  final bool hasUpperAndNumber;

  @override
  Widget build(BuildContext context) {
    final strength = (hasLength ? 2 : 0) + (hasUpperAndNumber ? 2 : 0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Độ mạnh mật khẩu', style: AppTypography.caption),
            Text(
              strength == 4 ? 'Mạnh' : 'Chưa đủ mạnh',
              style: AppTypography.caption.copyWith(
                color: strength == 4
                    ? AppColors.primaryActive
                    : AppColors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            4,
            (index) => Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
                decoration: BoxDecoration(
                  color: index < strength
                      ? AppColors.primary
                      : AppColors.borderNeutral,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _Rule(ok: hasLength, label: 'Tối thiểu 8 ký tự'),
            ),
            Expanded(
              child: _Rule(ok: hasUpperAndNumber, label: 'Có chữ hoa và số'),
            ),
          ],
        ),
      ],
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.ok, required this.label});
  final bool ok;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(
        ok ? Icons.check_rounded : Icons.circle_outlined,
        size: 17,
        color: ok ? AppColors.success : AppColors.textTertiary,
      ),
      const SizedBox(width: 6),
      Flexible(child: Text(label, style: AppTypography.caption)),
    ],
  );
}

class _SecurityBadge extends StatelessWidget {
  const _SecurityBadge();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.glass75,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        '♢  Mã hóa chuẩn SSL 256-bit an toàn',
        style: AppTypography.caption,
      ),
    ),
  );
}
