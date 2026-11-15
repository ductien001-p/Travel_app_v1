import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/features/auth/application/auth_controller.dart';
import 'package:travel_frontend_v1/features/auth/provider/auth_provider.dart';

import '../../application/change_password.dart';
import '../../application/update_profile_controller.dart';
import '../../provider/profile_provider.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/update_profile_request.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key, required this.profile});

  final ProfileModel profile;

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  bool _biometricEnabled = true;
  late bool _pushNotificationsEnabled;
  bool _tripRemindersEnabled = true;
  bool _communityInteractionsEnabled = false;

  @override
  void initState() {
    super.initState();
    _pushNotificationsEnabled = widget.profile.notificationEnabled;
  }

  Future<void> _setPushNotifications(bool enabled) async {
    final previous = _pushNotificationsEnabled;
    setState(() => _pushNotificationsEnabled = enabled);
    final success = await ref
        .read(updateProfileControllerProvider.notifier)
        .submit(UpdateProfileRequest(notificationEnabled: enabled));
    if (!mounted) return;
    if (success) return;
    setState(() => _pushNotificationsEnabled = previous);
    final error = ref.read(updateProfileControllerProvider).error;
    final message = error is ApiException
        ? error.message
        : 'Không thể cập nhật thông báo.';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _changePassword() async {
    final currentController = TextEditingController();
    final nextController = TextEditingController();
    final confirmController = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        var saving = false;
        String? errorText;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> submit() async {
              final message = validateChangePassword(
                currentPassword: currentController.text,
                newPassword: nextController.text,
                confirmPassword: confirmController.text,
              );
              if (message != null) {
                setDialogState(() => errorText = message);
                return;
              }
              setDialogState(() {
                saving = true;
                errorText = null;
              });
              try {
                await ref.read(authRepositoryProvider).changePassword(
                  oldPassword: currentController.text,
                  newPassword: nextController.text,
                );
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(true);
                }
              } catch (error) {
                setDialogState(() {
                  saving = false;
                  errorText = changePasswordFailureMessage(error);
                });
              }
            }

            return AlertDialog(
              title: const Text('Đổi mật khẩu'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: currentController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu hiện tại',
                    ),
                  ),
                  TextField(
                    controller: nextController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
                  ),
                  TextField(
                    controller: confirmController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Xác nhận mật khẩu mới',
                    ),
                  ),
                  if (errorText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorText!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: saving
                      ? null
                      : () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: saving ? null : submit,
                  child: Text(saving ? 'Đang lưu...' : 'Lưu'),
                ),
              ],
            );
          },
        );
      },
    );
    currentController.dispose();
    nextController.dispose();
    confirmController.dispose();
    if (submitted == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã đổi mật khẩu.')),
      );
    }
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa tài khoản'),
        content: const Text(
          'Tài khoản và phiên đăng nhập trên mọi thiết bị sẽ bị đóng. Thao tác này không hoàn tác được.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Xóa tài khoản'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(profileRepositoryProvider).deleteAccount();
      if (!mounted) return;
      await ref.read(authControllerProvider.notifier).endDeletedSession();
    } catch (error) {
      if (!mounted) return;
      final message = error is ApiException
          ? error.message
          : 'Không xóa được tài khoản.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final notificationUpdate = ref.watch(updateProfileControllerProvider);
    return AppScaffold(
      topBar: const _SettingTopBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xxl,
        ),
        children: [
          _ProfileQuickCard(profile: widget.profile),
          const SizedBox(height: AppSpacing.xl),
          _SettingsSection(
            icon: Icons.security_rounded,
            title: 'Tài khoản & Bảo mật',
            children: [
              _SettingsTile(
                icon: Icons.lock_reset_rounded,
                title: 'Đổi mật khẩu',
                subtitle: 'Cập nhật mật khẩu định kỳ để an toàn',
                showChevron: true,
                onTap: _changePassword,
              ),
              _SettingsTile(
                icon: Icons.fingerprint_rounded,
                title: 'Xác thực sinh trắc học',
                subtitle: 'Sử dụng Face ID hoặc Vân tay',
                trailing: _SettingSwitch(
                  value: _biometricEnabled,
                  onChanged: (value) =>
                      setState(() => _biometricEnabled = value),
                ),
              ),
              const _SettingsTile(
                icon: Icons.devices_rounded,
                title: 'Quản lý thiết bị',
                subtitle: 'Thiết bị hiện tại • Đang hoạt động',
                showChevron: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _SettingsSection(
            icon: Icons.notifications_active_outlined,
            title: 'Thông báo & Tương tác',
            children: [
              _SettingsTile(
                icon: Icons.notifications_none_rounded,
                title: 'Thông báo đẩy',
                subtitle: 'Nhận tin tức cập nhật trên thiết bị',
                trailing: _SettingSwitch(
                  value: _pushNotificationsEnabled,
                  onChanged: notificationUpdate.isLoading
                      ? null
                      : _setPushNotifications,
                ),
              ),
              _SettingsTile(
                icon: Icons.flight_takeoff_rounded,
                title: 'Nhắc nhở hành trình',
                subtitle: 'Lịch bay, lưu trú & hoạt động nhóm',
                trailing: _SettingSwitch(
                  value: _tripRemindersEnabled,
                  onChanged: (value) =>
                      setState(() => _tripRemindersEnabled = value),
                ),
              ),
              _SettingsTile(
                icon: Icons.favorite_border_rounded,
                title: 'Tương tác cộng đồng',
                subtitle: 'Lượt thích, bình luận, kết bạn',
                trailing: _SettingSwitch(
                  value: _communityInteractionsEnabled,
                  onChanged: (value) =>
                      setState(() => _communityInteractionsEnabled = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const _SettingsSection(
            icon: Icons.tune_rounded,
            title: 'Tùy chọn ứng dụng & Trải nghiệm',
            children: [
              _SettingsTile(
                icon: Icons.language_rounded,
                title: 'Ngôn ngữ hiển thị',
                value: 'Tiếng Việt (VN)',
                showChevron: true,
              ),
              _SettingsTile(
                icon: Icons.payments_outlined,
                title: 'Đơn vị tiền tệ',
                value: 'VNĐ (₫)',
                showChevron: true,
              ),
              _SettingsTile(
                icon: Icons.visibility_outlined,
                title: 'Chế độ hồ sơ',
                value: 'Công khai',
                valueIsPrimary: true,
                showChevron: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const _SettingsSection(
            icon: Icons.help_outline_rounded,
            title: 'Hỗ trợ & Pháp lý',
            children: [
              _SettingsTile(
                icon: Icons.contact_support_outlined,
                title: 'Trung tâm trợ giúp & FAQ',
                showChevron: true,
              ),
              _SettingsTile(
                icon: Icons.policy_outlined,
                title: 'Điều khoản & Chính sách',
                showChevron: true,
              ),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'Phiên bản ứng dụng',
                value: 'Teal Horizon v1.4.2',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          OutlinedButton.icon(
            onPressed: authState.isLoading
                ? null
                : () => ref.read(authControllerProvider.notifier).logout(),
            icon: authState.isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout_rounded, size: 20),
            label: Text(
              authState.isLoading ? 'Đang đăng xuất…' : 'Đăng xuất tài khoản',
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              foregroundColor: AppColors.dangerStrong,
              side: const BorderSide(color: Color(0xFFFFD2CA)),
              shape: const StadiumBorder(),
              textStyle: AppTypography.bodyMedium,
              backgroundColor: AppColors.glass75,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: _deleteAccount,
            child: Text(
              'Yêu cầu xóa toàn bộ dữ liệu & tài khoản',
              style: AppTypography.caption.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingTopBar extends StatelessWidget {
  const _SettingTopBar();

  @override
  Widget build(BuildContext context) => AppGlassSurface(
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
            icon: Icons.chevron_left_rounded,
            onPressed: () => context.pop(),
            semanticLabel: 'Quay lại',
          ),
          Expanded(
            child: Text(
              'Cài đặt',
              textAlign: TextAlign.center,
              style: AppTypography.screenTitle,
            ),
          ),
          const AppIconButton(
            icon: Icons.search_rounded,
            iconColor: AppColors.primaryActive,
            onPressed: null,
            semanticLabel: 'Tìm kiếm trợ giúp chưa khả dụng',
          ),
        ],
      ),
    ),
  );
}

class _ProfileQuickCard extends StatelessWidget {
  const _ProfileQuickCard({required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Row(
      children: [
        AppAvatar(
          size: 56,
          imageUrl: profile.avatarUrl,
          initials: profile.initials,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.displayName ?? profile.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.cardTitle,
              ),
              Text(
                profile.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.borderBrandSoft),
                ),
                child: Text(
                  '✿ Hạng Vàng • Verified',
                  style: AppTypography.badge.copyWith(
                    color: AppColors.primaryActive,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceSubdued,
          ),
          child: const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.children,
  });
  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Row(
          children: [
            Icon(icon, size: 19, color: AppColors.primaryActive),
            const SizedBox(width: AppSpacing.xs),
            Expanded(child: Text(title, style: AppTypography.sectionTitle)),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppGlassSurface(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            for (var index = 0; index < children.length; index++) ...[
              children[index],
              if (index != children.length - 1)
                const Divider(height: 1, color: AppColors.borderBrandSoft),
            ],
          ],
        ),
      ),
    ],
  );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.valueIsPrimary = false,
    this.showChevron = false,
    this.trailing,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final bool valueIsPrimary;
  final bool showChevron;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 73),
    child: InkWell(
      onTap: onTap,
      child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryLight,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 20, color: AppColors.primaryActive),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyMedium),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (value != null) ...[
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                value!,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  color: valueIsPrimary
                      ? AppColors.primaryActive
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.xs),
            trailing!,
          ],
          if (showChevron) ...[
            const SizedBox(width: AppSpacing.xxs),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.textTertiary,
            ),
          ],
        ],
      ),
    ),
    ),
  );
}

class _SettingSwitch extends StatelessWidget {
  const _SettingSwitch({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) => Switch(
    value: value,
    onChanged: onChanged,
    activeTrackColor: AppColors.primary,
    activeThumbColor: AppColors.surface,
    inactiveTrackColor: const Color(0xFFD5E5ED),
    inactiveThumbColor: AppColors.surface,
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
  );
}
