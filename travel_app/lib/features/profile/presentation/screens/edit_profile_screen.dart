import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';
import 'package:travel_frontend_v1/core/widget/app_top_bar.dart';

import '../../application/profile_controller.dart';
import '../../application/update_avatar_controller.dart';
import '../../application/update_profile_controller.dart';
import '../../data/models/profile_model.dart';
import '../edit_profile_changes.dart';
import '../edit_profile_format.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  static const _bioMaxLength = 150;
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  ProfileModel? _initialProfile;
  String? _gender;
  BudgetLevel? _budgetLevel;
  Set<String> _languages = {};
  Set<String> _interests = {};
  bool _editingPhone = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  void _initialize(ProfileModel profile) {
    if (_initialProfile?.id == profile.id) return;
    _initialProfile = profile;
    _displayNameController.text = profile.displayName ?? '';
    _usernameController.text = profile.username;
    _bioController.text = profile.bio ?? '';
    _phoneController.text = profile.phone ?? '';
    _locationController.text = profile.location ?? '';
    _addressController.text = profile.address ?? '';
    _gender = normalizedEditProfileGender(profile.gender);
    _dateOfBirthController.text = formatEditProfileDate(profile.dateOfBirth);
    _budgetLevel = profile.budgetLevel;
    _languages = profile.languages.toSet();
    _interests = profile.interests.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final updateState = ref.watch(updateProfileControllerProvider);
    final avatarState = ref.watch(updateAvatarControllerProvider);
    final profile = profileState.value;
    final busy = updateState.isLoading || avatarState.isLoading;

    return AppScaffold(
      extendBody: false,
      topBar: AppTopBar(title: 'Chỉnh sửa hồ sơ', onBack: context.pop),
      bottomNavigationBar: profile == null
          ? null
          : _SaveBar(
              isLoading: busy,
              onPressed: busy ? null : () => _submit(profile),
            ),
      body: profileState.when(
        data: (value) {
          _initialize(value);
          return _form(value, updateState, avatarState);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, _) => _ProfileLoadFailure(
          error: error,
          onRetry: ref.read(profileControllerProvider.notifier).refreshProfile,
        ),
      ),
    );
  }

  Widget _form(
    ProfileModel profile,
    AsyncValue<ProfileModel?> updateState,
    AsyncValue<ProfileModel?> avatarState,
  ) {
    final busy = updateState.isLoading || avatarState.isLoading;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.xl,
        ),
        children: [
          _MediaHeader(
            profile: profile,
            busy: busy,
            onSelectAvatar: _pickAvatar,
          ),
          const SizedBox(height: AppSpacing.section),
          _EditSection(
            icon: Icons.badge_outlined,
            title: 'Thông tin cơ bản',
            children: [
              _LabeledField(
                label: 'Họ và tên',
                child: AppTextField(
                  controller: _displayNameController,
                  hint: 'Nhập họ và tên',
                  trailing: const Icon(Icons.edit_outlined, size: 19),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Vui lòng nhập họ và tên.'
                      : null,
                ),
              ),
              _LabeledField(
                label: 'Tên người dùng (Username)',
                trailing: const _StatusBadge(label: 'Duy nhất'),
                helper: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _usernameController,
                  builder: (_, value, _) => Text(
                    'Đường dẫn trang cá nhân: tealhorizon.app/@${value.text}',
                    style: AppTypography.caption,
                  ),
                ),
                child: AppTextField(
                  controller: _usernameController,
                  leadingIcon: Icons.alternate_email_rounded,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Vui lòng nhập tên người dùng.'
                      : null,
                ),
              ),
              _LabeledField(
                label: 'Giới thiệu bản thân (Bio)',
                trailing: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _bioController,
                  builder: (_, value, _) => Text(
                    '${value.text.length}/$_bioMaxLength',
                    style: AppTypography.caption,
                  ),
                ),
                child: AppTextField(
                  controller: _bioController,
                  minLines: 3,
                  maxLines: 4,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(_bioMaxLength),
                  ],
                ),
              ),
              _LabeledField(
                label: 'Vị trí hiện tại',
                child: AppTextField(
                  controller: _locationController,
                  leadingIcon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          _EditSection(
            icon: Icons.contact_mail_outlined,
            title: 'Thông tin liên hệ & Cá nhân',
            children: [
              _ReadOnlyInfo(
                label: 'Địa chỉ Email',
                value: profile.email ?? 'Email chưa được cung cấp',
                icon: Icons.mail_outline_rounded,
                badge: profile.email == null ? null : 'Đã xác thực',
              ),
              _PhoneRow(
                phone: _phoneController.text,
                editing: _editingPhone,
                enabled: !busy,
                controller: _phoneController,
                onChangePressed: () => setState(() => _editingPhone = true),
              ),
              _LabeledField(
                label: 'Địa chỉ',
                child: AppTextField(
                  controller: _addressController,
                  leadingIcon: Icons.home_outlined,
                  hint: 'Số nhà, đường, phường',
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Ngày sinh',
                      child: AppTextField(
                        controller: _dateOfBirthController,
                        leadingIcon: Icons.calendar_today_outlined,
                        hint: 'DD/MM/YYYY',
                        validator: _validateDate,
                        trailing: IconButton(
                          onPressed: busy ? null : _selectDate,
                          icon: const Icon(Icons.expand_more_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _LabeledField(
                      label: 'Giới tính',
                      child: DropdownButtonFormField<String>(
                        initialValue: _gender,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.surfaceSubdued,
                        ),
                        hint: const Text('Chọn'),
                        items: const [
                          DropdownMenuItem(
                            value: '',
                            child: Text('Không chọn'),
                          ),
                          DropdownMenuItem(value: 'male', child: Text('Nam')),
                          DropdownMenuItem(value: 'female', child: Text('Nữ')),
                          DropdownMenuItem(value: 'other', child: Text('Khác')),
                        ],
                        onChanged: busy
                            ? null
                            : (value) => setState(() => _gender = value),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          _TravelPreferences(
            budgetLevel: _budgetLevel,
            languages: _languages,
            interests: _interests,
            enabled: !busy,
            onBudgetChanged: (value) => setState(() => _budgetLevel = value),
            onLanguageToggled: (value) => setState(
              () => _toggleSelection(_languages, value, maxItems: 10),
            ),
            onAddLanguage: busy ? null : _addLanguage,
            onInterestToggled: (value) => setState(
              () => _toggleSelection(_interests, value, maxItems: 20),
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          const _SyncNotice(),
          if (updateState.hasError || avatarState.hasError) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              _errorMessage(updateState.error ?? avatarState.error),
              style: AppTypography.body.copyWith(color: AppColors.danger),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _pickAvatar() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 90,
    );
    if (file == null || !mounted) return;
    await ref.read(updateAvatarControllerProvider.notifier).updateAvatar(file);
  }

  Future<void> _selectDate() async {
    final initial = DateTime.tryParse(
      parseEditProfileDate(_dateOfBirthController.text) ?? '',
    );
    final selected = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected == null) return;
    _dateOfBirthController.text = formatEditProfileDate(
      selected.toIso8601String(),
    );
    setState(() {});
  }

  Future<void> _addLanguage() async {
    final available = _languageOptions.entries
        .where((option) => !_languages.contains(option.key))
        .toList(growable: false);
    if (available.isEmpty || !mounted) return;
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in available)
              ListTile(
                title: Text(option.value),
                onTap: () => Navigator.pop(context, option.key),
              ),
          ],
        ),
      ),
    );
    if (selected == null || !mounted) return;
    setState(() => _toggleSelection(_languages, selected, maxItems: 10));
  }

  Future<void> _submit(ProfileModel profile) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final request = editProfileChanges(
      profile: profile,
      displayName: _displayNameController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      phone: _phoneController.text,
      location: _locationController.text,
      address: _addressController.text,
      gender: _gender,
      dateOfBirthDisplay: _dateOfBirthController.text,
      budgetLevel: _budgetLevel,
      languages: _languages,
      interests: _interests,
    );
    if (request.isEmpty) {
      if (mounted) context.pop();
      return;
    }
    final success = await ref
        .read(updateProfileControllerProvider.notifier)
        .submit(request);
    if (success && mounted) context.pop();
  }

  String? _validateDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return parseEditProfileDate(value) == null
        ? 'Ngày sinh phải đúng định dạng DD/MM/YYYY.'
        : null;
  }

  void _toggleSelection(
    Set<String> values,
    String value, {
    required int maxItems,
  }) {
    if (!values.remove(value) && values.length < maxItems) values.add(value);
  }

  String _errorMessage(Object? error) => error is ApiException
      ? error.message
      : 'Không thể hoàn tất yêu cầu. Vui lòng thử lại.';
}

class _ProfileLoadFailure extends StatelessWidget {
  const _ProfileLoadFailure({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = error;
    final unauthorized = failure is ApiException && failure.statusCode == 401;
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không thể tải hồ sơ',
      message: unauthorized
          ? 'Đăng nhập lại để chỉnh sửa hồ sơ.'
          : failure is ApiException
          ? failure.message
          : 'Không thể hoàn tất yêu cầu. Vui lòng thử lại.',
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : onRetry,
    );
  }
}

class _MediaHeader extends StatelessWidget {
  const _MediaHeader({
    required this.profile,
    required this.busy,
    required this.onSelectAvatar,
  });

  final ProfileModel profile;
  final bool busy;
  final VoidCallback onSelectAvatar;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _AvatarBadge(
        profile: profile,
        busy: busy,
        onSelectAvatar: onSelectAvatar,
      ),
      const SizedBox(height: AppSpacing.xs),
      TextButton(
        onPressed: busy ? null : onSelectAvatar,
        child: Text(
          busy ? 'Đang tải ảnh đại diện…' : 'Đổi ảnh đại diện',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Text(
        'Hỗ trợ JPG, PNG • Tối đa 5MB',
        style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
      ),
    ],
  );
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({
    required this.profile,
    required this.busy,
    required this.onSelectAvatar,
  });

  final ProfileModel profile;
  final bool busy;
  final VoidCallback onSelectAvatar;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 96,
    height: 96,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 4),
          ),
          child: AppAvatar(
            size: 88,
            initials: profile.initials,
            imageUrl: profile.avatarUrl,
          ),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: busy ? null : onSelectAvatar,
              child: const SizedBox.square(
                dimension: 32,
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 18,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _PhoneRow extends StatelessWidget {
  const _PhoneRow({
    required this.phone,
    required this.editing,
    required this.enabled,
    required this.controller,
    required this.onChangePressed,
  });

  final String phone;
  final bool editing;
  final bool enabled;
  final TextEditingController controller;
  final VoidCallback onChangePressed;

  @override
  Widget build(BuildContext context) {
    if (editing) {
      return _LabeledField(
        label: 'Số điện thoại',
        child: AppTextField(
          controller: controller,
          leadingIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      );
    }
    final hasPhone = phone.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Số điện thoại',
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surfaceSubdued,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: Border.all(color: AppColors.borderBrandSoft),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 18,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  hasPhone ? maskEditProfilePhone(phone) : 'Chưa cập nhật',
                  style: AppTypography.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: enabled ? onChangePressed : null,
                child: Text(hasPhone ? 'Thay đổi' : 'Thêm'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditSection extends StatelessWidget {
  const _EditSection({
    required this.icon,
    required this.title,
    required this.children,
  });
  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 21),
            const SizedBox(width: AppSpacing.xs),
            Expanded(child: Text(title, style: AppTypography.sectionTitle)),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Divider(height: 1, color: AppColors.borderBrandSoft),
        ),
        ...children.map(
          (child) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: child,
          ),
        ),
      ],
    ),
  );
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
    this.trailing,
    this.helper,
  });
  final String label;
  final Widget child;
  final Widget? trailing;
  final Widget? helper;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
      const SizedBox(height: 6),
      child,
      if (helper != null) ...[const SizedBox(height: 5), helper!],
    ],
  );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.success.withValues(alpha: 0.10),
      border: Border.all(color: AppColors.success.withValues(alpha: 0.35)),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: AppColors.success),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: AppTypography.badge.copyWith(color: AppColors.success),
        ),
      ],
    ),
  );
}

class _ReadOnlyInfo extends StatelessWidget {
  const _ReadOnlyInfo({
    required this.label,
    required this.value,
    required this.icon,
    this.badge,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? badge;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        constraints: const BoxConstraints(minHeight: 52),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceSubdued,
          borderRadius: BorderRadius.circular(AppRadius.input),
          border: Border.all(color: AppColors.borderNeutral),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: AppColors.textTertiary),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: AppSpacing.xs),
              _StatusBadge(label: badge!, icon: Icons.check_circle_outline),
            ],
          ],
        ),
      ),
    ],
  );
}

const _languageOptions = <String, String>{
  'vi': 'Tiếng Việt',
  'en': 'English',
  'ja': '日本語',
  'ko': '한국어',
  'zh': '中文',
  'fr': 'Tiếng Pháp',
};

class _TravelPreferences extends StatelessWidget {
  const _TravelPreferences({
    required this.budgetLevel,
    required this.languages,
    required this.interests,
    required this.enabled,
    required this.onBudgetChanged,
    required this.onLanguageToggled,
    required this.onAddLanguage,
    required this.onInterestToggled,
  });

  static const _interestOptions = <String, (String, IconData)>{
    'photography': ('Nhiếp ảnh', Icons.photo_camera_outlined),
    'food': ('Ẩm thực', Icons.restaurant_outlined),
    'adventure': ('Phiêu lưu', Icons.hiking_outlined),
    'beach': ('Biển đảo', Icons.waves_outlined),
    'mountains': ('Leo núi', Icons.terrain_outlined),
    'culture': ('Văn hóa', Icons.museum_outlined),
    'nature': ('Thiên nhiên', Icons.park_outlined),
    'nightlife': ('Cuộc sống đêm', Icons.nightlife_outlined),
    'shopping': ('Mua sắm', Icons.shopping_bag_outlined),
    'history': ('Lịch sử', Icons.account_balance_outlined),
  };

  final BudgetLevel? budgetLevel;
  final Set<String> languages;
  final Set<String> interests;
  final bool enabled;
  final ValueChanged<BudgetLevel> onBudgetChanged;
  final ValueChanged<String> onLanguageToggled;
  final VoidCallback? onAddLanguage;
  final ValueChanged<String> onInterestToggled;

  @override
  Widget build(BuildContext context) => _EditSection(
    icon: Icons.tune_rounded,
    title: 'Gu du lịch & Phong cách',
    children: [
      _BudgetSelector(
        value: budgetLevel,
        enabled: enabled,
        onChanged: onBudgetChanged,
      ),
      _LanguageChips(
        languages: languages,
        enabled: enabled,
        onRemove: onLanguageToggled,
        onAdd: onAddLanguage,
      ),
      _InterestChips(
        interests: interests,
        enabled: enabled,
        onToggled: onInterestToggled,
      ),
    ],
  );
}

class _BudgetSelector extends StatelessWidget {
  const _BudgetSelector({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final BudgetLevel? value;
  final bool enabled;
  final ValueChanged<BudgetLevel> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Mức ngân sách ưa thích',
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: AppSpacing.xs),
      DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surfaceSubdued,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.borderBrandSoft),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              for (final level in BudgetLevel.values)
                Expanded(
                  child: _BudgetOption(
                    level: level,
                    selected: value == level,
                    enabled: enabled,
                    onChanged: onChanged,
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _BudgetOption extends StatelessWidget {
  const _BudgetOption({
    required this.level,
    required this.selected,
    required this.enabled,
    required this.onChanged,
  });

  final BudgetLevel level;
  final bool selected;
  final bool enabled;
  final ValueChanged<BudgetLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    final title = switch (level) {
      BudgetLevel.low => 'Tiết kiệm',
      BudgetLevel.medium => 'Vừa phải',
      BudgetLevel.high => 'Cao cấp',
    };
    final subtitle = switch (level) {
      BudgetLevel.low => 'Low',
      BudgetLevel.medium => 'Medium',
      BudgetLevel.high => 'High',
    };
    return Material(
      color: selected ? AppColors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: InkWell(
        onTap: enabled ? () => onChanged(level) : null,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                title,
                style: AppTypography.caption.copyWith(
                  color: selected
                      ? AppColors.textInverse
                      : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.badge.copyWith(
                  color: selected
                      ? AppColors.textInverse.withValues(alpha: 0.9)
                      : AppColors.textTertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageChips extends StatelessWidget {
  const _LanguageChips({
    required this.languages,
    required this.enabled,
    required this.onRemove,
    required this.onAdd,
  });

  final Set<String> languages;
  final bool enabled;
  final ValueChanged<String> onRemove;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              'Ngôn ngữ du lịch',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: enabled ? onAdd : null,
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Thêm'),
          ),
        ],
      ),
      Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        children: [
          for (final code in languages)
            if (_languageOptions[code] case final label?)
              Container(
                padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.primary20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryActive,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Bỏ $label',
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 28,
                        height: 28,
                      ),
                      onPressed: enabled ? () => onRemove(code) : null,
                      icon: const Icon(Icons.close, size: 14),
                      color: AppColors.primaryActive,
                    ),
                  ],
                ),
              ),
        ],
      ),
    ],
  );
}

class _InterestChips extends StatelessWidget {
  const _InterestChips({
    required this.interests,
    required this.enabled,
    required this.onToggled,
  });

  final Set<String> interests;
  final bool enabled;
  final ValueChanged<String> onToggled;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Sở thích trải nghiệm',
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: AppSpacing.xs),
      Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        children: [
          for (final entry in _TravelPreferences._interestOptions.entries)
            _InterestChip(
              label: entry.value.$1,
              icon: entry.value.$2,
              selected: interests.contains(entry.key),
              enabled: enabled,
              onPressed: () => onToggled(entry.key),
            ),
        ],
      ),
    ],
  );
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? AppColors.textInverse
        : AppColors.textSecondary;
    return Material(
      color: selected ? AppColors.primary : AppColors.surfaceSubdued,
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.borderNeutral,
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: enabled ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: foreground,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SyncNotice extends StatelessWidget {
  const _SyncNotice();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.primary08,
      border: Border.all(color: AppColors.primary20),
      borderRadius: BorderRadius.circular(AppRadius.cardLarge),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.cloud_sync_outlined,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              children: const [
                TextSpan(
                  text: 'Mọi thay đổi sẽ được cập nhật đồng bộ qua API ',
                ),
                TextSpan(
                  text: 'PATCH /users/update',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.isLoading, required this.onPressed});
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: AppGlassSurface(
      radius: 0,
      shadows: const [],
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: AppButton(
        label: 'Lưu thay đổi hồ sơ',
        isLoading: isLoading,
        onPressed: onPressed,
        trailingIcon: Icons.arrow_forward_rounded,
      ),
    ),
  );
}
