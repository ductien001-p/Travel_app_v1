import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/router_names.dart';
import '../../../core/testing/e2e_keys.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_glass_surface.dart';
import '../../../core/widget/app_icon_button.dart';
import '../../../core/widget/app_scaffold.dart';
import '../../../core/widget/app_text_field.dart';
import '../application/auth_controller.dart';
import 'widgets/auth_form_error.dart';
import 'widgets/password_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu.';
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await ref
        .read(authControllerProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  void _showUnsupportedFeature(String featureName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$featureName hiện chưa có luồng Flutter tương thích.'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

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
                _Header(
                  onBack: Navigator.of(context).canPop()
                      ? () => Navigator.of(context).pop()
                      : null,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text('Chào mừng trở lại! ✨', style: AppTypography.display),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Đăng nhập để tiếp tục hành trình khám phá và kết nối cùng cộng đồng.',
                  style: AppTypography.body.copyWith(fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.xxl),
                _AuthSwitcher(
                  onRegisterPressed: () => context.goNamed(RouteNames.register),
                ),
                const SizedBox(height: AppSpacing.xl),
                _LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  rememberMe: _rememberMe,
                  isLoading: authState.isLoading,
                  error: authState.error,
                  validateEmail: _validateEmail,
                  validatePassword: _validatePassword,
                  onRememberChanged: (value) {
                    setState(() => _rememberMe = value ?? false);
                  },
                  onForgotPassword: () =>
                      context.goNamed(RouteNames.forgotPassword),
                  onSubmit: _submit,
                ),
                const SizedBox(height: AppSpacing.xxl),
                const _DividerLabel(),
                const SizedBox(height: AppSpacing.xl),
                _SocialButton(
                  icon: Icons.g_mobiledata_rounded,
                  label: 'Đăng nhập với Google',
                  isLoading: authState.isLoading,
                  onPressed: authState.isLoading
                      ? null
                      : () => ref
                            .read(authControllerProvider.notifier)
                            .googleLogin(),
                ),
                const SizedBox(height: AppSpacing.sm),
                _SocialButton(
                  icon: Icons.apple_rounded,
                  label: 'Đăng nhập với Apple',
                  onPressed: () => _showUnsupportedFeature('Đăng nhập Apple'),
                ),
                const SizedBox(height: AppSpacing.huge),
                Text.rich(
                  TextSpan(
                    text: 'Bằng việc tiếp tục, bạn đồng ý với ',
                    children: [
                      TextSpan(
                        text: 'Điều khoản dịch vụ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: 'Chính sách quyền riêng tư',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const TextSpan(text: ' của Teal Horizon.'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback? onBack;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AppColors.glass75,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.explore_outlined,
                    color: AppColors.primary,
                    size: 23,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('Teal Horizon', style: AppTypography.screenTitle),
              ],
            ),
          ),
          const SizedBox(
            width: 40,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(dimension: 9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthSwitcher extends StatelessWidget {
  const _AuthSwitcher({required this.onRegisterPressed});

  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black03,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Đăng nhập',
                style: AppTypography.cardTitle.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: onRegisterPressed,
              child: Text(
                'Đăng ký',
                style: AppTypography.cardTitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.isLoading,
    required this.error,
    required this.validateEmail,
    required this.validatePassword,
    required this.onRememberChanged,
    required this.onForgotPassword,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool isLoading;
  final Object? error;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotPassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AppGlassSurface(
        radius: AppRadius.cardLarge,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              key: E2eKeys.loginEmail,
              controller: emailController,
              label: 'Email',
              hint: 'alex.traveler@example.com',
              leadingIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              enabled: !isLoading,
            ),
            const SizedBox(height: AppSpacing.md),
            PasswordField(
              key: E2eKeys.loginPassword,
              controller: passwordController,
              label: 'Mật khẩu',
              textInputAction: TextInputAction.done,
              validator: validatePassword,
              enabled: !isLoading,
              onSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: isLoading ? null : onRememberChanged,
                  shape: const CircleBorder(),
                ),
                Expanded(
                  child: Text('Ghi nhớ đăng nhập', style: AppTypography.body),
                ),
                TextButton(
                  onPressed: isLoading ? null : onForgotPassword,
                  child: Text(
                    'Quên mật khẩu?',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (error != null) ...[
              AuthFormError(error: error!),
              const SizedBox(height: AppSpacing.md),
            ],
            AppButton(
              key: E2eKeys.loginSubmit,
              label: 'Đăng nhập ngay',
              trailingIcon: Icons.arrow_forward_rounded,
              isLoading: isLoading,
              onPressed: isLoading ? null : onSubmit,
            ),
          ],
        ),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Hoặc tiếp tục với',
            style: AppTypography.body.copyWith(color: AppColors.textTertiary),
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
    this.isLoading,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool? isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      leadingIcon: icon,
      isLoading: isLoading ?? false,
      variant: AppButtonVariant.glass,
      onPressed: onPressed,
    );
  }
}
