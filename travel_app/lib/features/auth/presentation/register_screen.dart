import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/router_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_glass_surface.dart';
import '../../../core/widget/app_icon_button.dart';
import '../../../core/widget/app_scaffold.dart';
import '../../../core/widget/app_segmented_control.dart';
import '../../../core/widget/app_text_field.dart';
import '../application/auth_controller.dart';
import '../application/register_controller.dart';
import 'widgets/auth_form_error.dart';
import 'widgets/password_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_refreshPasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_refreshPasswordStrength);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _refreshPasswordStrength() => setState(() {});

  int get _passwordStrength {
    final password = _passwordController.text;
    if (password.isEmpty) return 0;
    var strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Za-z]').hasMatch(password)) strength++;
    if (RegExp(r'\d').hasMatch(password)) strength++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) strength++;
    return strength;
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên hiển thị.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Vui lòng nhập email.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Email chưa đúng định dạng.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu.';
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

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    final succeeded = await ref
        .read(registerControllerProvider.notifier)
        .register(
          email: email,
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        );
    if (!mounted || !succeeded) return;
    context.goNamed(RouteNames.verifyEmail, queryParameters: {'email': email});
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final isLoading = registerState.isLoading || authState.isLoading;

    return AppScaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(onBack: () => context.goNamed(RouteNames.login)),
                const SizedBox(height: AppSpacing.xl),
                const _DiscoveryBadge(),
                const SizedBox(height: AppSpacing.sm),
                Text('Bắt đầu hành trình! 🚀', style: AppTypography.display),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Khám phá điểm đến tuyệt mỹ, kết nối bạn đồng hành cùng gu và chia sẻ từng khoảnh khắc.',
                  style: AppTypography.body.copyWith(fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AppSegmentedControl<_AuthMode>(
                  items: const [
                    AppSegmentedItem(
                      value: _AuthMode.login,
                      label: 'Đăng nhập',
                    ),
                    AppSegmentedItem(
                      value: _AuthMode.register,
                      label: 'Đăng ký',
                    ),
                  ],
                  value: _AuthMode.register,
                  onChanged: (value) {
                    if (value == _AuthMode.login) {
                      context.goNamed(RouteNames.login);
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.xxl),
                Form(
                  key: _formKey,
                  child: AppGlassSurface(
                    radius: AppRadius.sheet,
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _FieldHeader(
                          label: 'Tên hiển thị (Username)',
                          helper: 'Duy nhất',
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        AppTextField(
                          controller: _usernameController,
                          hint: 'VD: alex_traveler',
                          leadingIcon: Icons.person_outline_rounded,
                          textInputAction: TextInputAction.next,
                          validator: _validateRequired,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const _FieldHeader(label: 'Email'),
                        const SizedBox(height: AppSpacing.xs),
                        AppTextField(
                          controller: _emailController,
                          hint: 'alex.traveler@example.com',
                          leadingIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: _validateEmail,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const _FieldHeader(
                          label: 'Mật khẩu',
                          helper: 'Tối thiểu 8 ký tự',
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        PasswordField(
                          controller: _passwordController,
                          label: '',
                          textInputAction: TextInputAction.next,
                          validator: _validatePassword,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _PasswordStrength(strength: _passwordStrength),
                        const SizedBox(height: AppSpacing.lg),
                        const _FieldHeader(label: 'Xác nhận mật khẩu'),
                        const SizedBox(height: AppSpacing.xs),
                        PasswordField(
                          controller: _confirmController,
                          label: '',
                          textInputAction: TextInputAction.done,
                          validator: _validateConfirmation,
                          enabled: !isLoading,
                          onSubmitted: (_) => _submit(),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const _TermsAgreement(),
                        if (registerState.hasError) ...[
                          const SizedBox(height: AppSpacing.md),
                          AuthFormError(error: registerState.error!),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        AppButton(
                          label: 'Đăng ký tài khoản',
                          trailingIcon: Icons.arrow_forward_rounded,
                          isLoading: registerState.isLoading,
                          onPressed: isLoading ? null : _submit,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        const _DividerLabel(),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: _SocialButton(
                                icon: Icons.g_mobiledata_rounded,
                                label: 'Google',
                                isLoading: authState.isLoading,
                                onPressed: isLoading
                                    ? null
                                    : () => ref
                                          .read(authControllerProvider.notifier)
                                          .googleLogin(),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            const Expanded(
                              child: _SocialButton(
                                icon: Icons.apple_rounded,
                                label: 'Apple',
                                onPressed: _doNothing,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const _RewardCard(),
                const SizedBox(height: AppSpacing.xxl),
                _LoginFooter(
                  onPressed: isLoading
                      ? null
                      : () => context.goNamed(RouteNames.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _doNothing() {}

enum _AuthMode { login, register }

class _Header extends StatelessWidget {
  const _Header({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
          ),
          Expanded(
            child: Center(
              child: AppGlassSurface(
                radius: AppRadius.pill,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                shadows: AppShadows.level1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.explore_outlined,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Teal Horizon',
                      style: AppTypography.cardTitle.copyWith(
                        color: AppColors.primaryActive,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _DiscoveryBadge extends StatelessWidget {
  const _DiscoveryBadge();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.borderBrandSoft),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_awesome_rounded,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Khám phá không giới hạn',
              style: AppTypography.caption.copyWith(
                color: AppColors.primaryActive,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldHeader extends StatelessWidget {
  const _FieldHeader({required this.label, this.helper});
  final String label;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (helper != null)
          Text(
            helper!,
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
      ],
    );
  }
}

class _PasswordStrength extends StatelessWidget {
  const _PasswordStrength({required this.strength});
  final int strength;

  @override
  Widget build(BuildContext context) {
    final label = switch (strength) {
      0 => 'Nhập mật khẩu để kiểm tra',
      1 => 'Mật khẩu yếu',
      2 => 'Mật khẩu trung bình',
      3 => 'Mật khẩu khá',
      _ => 'Mật khẩu mạnh (8+ ký tự, chữ & số)',
    };
    final color = switch (strength) {
      0 => AppColors.textTertiary,
      1 => AppColors.danger,
      2 => AppColors.warning,
      _ => AppColors.primary,
    };

    return Column(
      children: [
        Row(
          children: List.generate(
            4,
            (index) => Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(right: index == 3 ? 0 : 6),
                decoration: BoxDecoration(
                  color: index < strength ? color : AppColors.borderNeutral,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Icon(Icons.shield_outlined, size: 16, color: color),
            const SizedBox(width: AppSpacing.xxs),
            Expanded(
              child: Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '${strength * 25}%',
              style: AppTypography.bodyMedium.copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}

class _TermsAgreement extends StatelessWidget {
  const _TermsAgreement();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(
            Icons.check_circle_rounded,
            size: 22,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'Tôi đồng ý với ',
              children: [
                TextSpan(
                  text: 'Điều khoản dịch vụ',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: ' & '),
                TextSpan(
                  text: 'Chính sách quyền riêng tư',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: ' của Teal Horizon.'),
              ],
            ),
            style: AppTypography.body,
          ),
        ),
      ],
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderNeutral)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            'HOẶC ĐĂNG KÝ NHANH VỚI',
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.borderNeutral)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      leadingIcon: icon,
      isLoading: isLoading,
      variant: AppButtonVariant.glass,
      onPressed: onPressed,
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard();

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: AppRadius.pill,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.card_giftcard_rounded,
              size: 18,
              color: AppColors.primaryActive,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Tặng ngay ',
                children: [
                  TextSpan(
                    text: '100 Horizon Points',
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: ' khi hoàn tất tạo hồ sơ!'),
                ],
              ),
              style: AppTypography.body,
            ),
          ),
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter({required this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Đã có tài khoản?', style: AppTypography.bodyMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'Đăng nhập ngay',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
