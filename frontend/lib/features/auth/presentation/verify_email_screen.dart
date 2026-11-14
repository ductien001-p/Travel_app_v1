import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../application/verify_email_controller.dart';
import 'widgets/auth_form_error.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key, this.initialEmail});

  final String? initialEmail;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  final _tokenController = TextEditingController();
  final _tokenFocus = FocusNode();
  Timer? _timer;
  int _resendSeconds = 60;
  bool _editingEmail = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _tokenController.addListener(_refresh);
    _startCountdown();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _tokenFocus.requestFocus(),
    );
  }

  void _refresh() => setState(() {});

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _resendSeconds = 60);
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
    _tokenController
      ..removeListener(_refresh)
      ..dispose();
    _tokenFocus.dispose();
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

  String? _validateToken(String? value) {
    final token = value?.trim() ?? '';
    if (token.isEmpty) return 'Vui lòng nhập mã xác thực.';
    if (!RegExp(r'^\d{6}$').hasMatch(token)) {
      return 'Mã xác thực phải gồm 6 chữ số.';
    }
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ref
        .read(verifyEmailControllerProvider.notifier)
        .verify(
          email: _emailController.text.trim(),
          token: _tokenController.text.trim(),
        );
  }

  Future<void> _resend() async {
    FocusScope.of(context).unfocus();
    if (_validateEmail(_emailController.text) != null) {
      setState(() => _editingEmail = true);
      _formKey.currentState?.validate();
      return;
    }
    final succeeded = await ref
        .read(verifyEmailControllerProvider.notifier)
        .resend(email: _emailController.text.trim());
    if (!mounted || !succeeded) return;
    _startCountdown();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Mã xác thực mới đã được gửi.')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyEmailControllerProvider);
    final minutes = (_resendSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_resendSeconds % 60).toString().padLeft(2, '0');

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
                  _Header(onBack: () => context.goNamed(RouteNames.register)),
                  const SizedBox(height: 28),
                  const _HeroIcon(),
                  const SizedBox(height: 24),
                  Text(
                    'Xác thực tài khoản',
                    textAlign: TextAlign.center,
                    style: AppTypography.display.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mã xác thực gồm 6 chữ số đã được gửi đến hộp thư:',
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  if (_editingEmail || _emailController.text.trim().isEmpty)
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      leadingIcon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      enabled: !state.isLoading,
                      onFieldSubmitted: (_) {
                        if (_validateEmail(_emailController.text) == null) {
                          setState(() => _editingEmail = false);
                          _tokenFocus.requestFocus();
                        }
                      },
                    )
                  else
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.glass75,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(color: AppColors.borderBrandSoft),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.alternate_email_rounded,
                              color: AppColors.primaryActive,
                              size: 19,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _emailController.text.trim(),
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  Center(
                    child: TextButton.icon(
                      onPressed: state.isLoading
                          ? null
                          : () => setState(() => _editingEmail = true),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text('Thay đổi email'),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _OtpInput(
                    controller: _tokenController,
                    focusNode: _tokenFocus,
                    enabled: !state.isLoading,
                    validator: _validateToken,
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 18,
                        color: _resendSeconds == 0
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _resendSeconds == 0
                            ? 'Bạn có thể gửi lại mã'
                            : 'Gửi lại mã sau $minutes:$seconds',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: _resendSeconds == 0 && !state.isLoading
                            ? _resend
                            : null,
                        child: const Text('Gửi lại ngay'),
                      ),
                    ],
                  ),
                  if (state.hasError) ...[
                    const SizedBox(height: 12),
                    AuthFormError(error: state.error!),
                  ],
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Xác thực & Tiếp tục',
                    trailingIcon: Icons.arrow_forward_rounded,
                    isLoading: state.isLoading,
                    onPressed: state.isLoading ? null : _submit,
                  ),
                  const SizedBox(height: 20),
                  const _InfoCard(),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_outlined, color: AppColors.primary),
              const SizedBox(width: 7),
              Text(
                'Teal Horizon',
                style: AppTypography.screenTitle.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ],
          ),
        ),
        const _RoundIcon(icon: Icons.help_outline_rounded),
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
      icon: Icon(icon, color: AppColors.textSecondary, size: 23),
    ),
  );
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon();

  @override
  Widget build(BuildContext context) => Center(
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
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 3),
              ),
              child: const Icon(
                Icons.shield_outlined,
                color: AppColors.textInverse,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _OtpInput extends StatelessWidget {
  const _OtpInput({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.validator,
    required this.onSubmitted,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final String? Function(String?) validator;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    final value = controller.text;
    return Column(
      children: [
        GestureDetector(
          onTap: enabled ? focusNode.requestFocus : null,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  final filled = index < value.length;
                  final active = index == value.length && value.length < 6;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 48,
                    height: 58,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.glass90,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                      border: Border.all(
                        color: active
                            ? AppColors.primary
                            : AppColors.borderNeutral,
                        width: active ? 2.5 : 1,
                      ),
                      boxShadow: active
                          ? const [
                              BoxShadow(
                                color: AppColors.primary20,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]
                          : AppShadows.level1,
                    ),
                    child: filled
                        ? Text(
                            value[index],
                            style: AppTypography.screenTitle.copyWith(
                              fontSize: 24,
                            ),
                          )
                        : active
                        ? Container(
                            width: 2,
                            height: 25,
                            color: AppColors.primary,
                          )
                        : Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.borderNeutral,
                              shape: BoxShape.circle,
                            ),
                          ),
                  );
                }),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.01,
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: validator,
                    onFieldSubmitted: onSubmitted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.glass75,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(color: AppColors.glassBorder),
      boxShadow: AppShadows.level1,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primaryLight,
          child: Icon(
            Icons.info_outline_rounded,
            color: AppColors.primaryActive,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Kiểm tra cả thư mục '),
                TextSpan(
                  text: 'Spam',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: ' hoặc '),
                TextSpan(
                  text: 'Thư rác',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: ' nếu bạn chưa thấy mã xuất hiện trong hộp thư đến.',
                ),
              ],
            ),
            style: AppTypography.body,
          ),
        ),
      ],
    ),
  );
}
