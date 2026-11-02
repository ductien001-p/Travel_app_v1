import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';

import '../../application/trip_expenses_create_form.dart';
import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';

class TripAddExpenseTopBar extends StatelessWidget {
  const TripAddExpenseTopBar({
    super.key,
    required this.onCancel,
    required this.onScanReceipt,
    this.tripName,
  });

  final VoidCallback onCancel;
  final VoidCallback onScanReceipt;
  final String? tripName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppPressable(
            onTap: onCancel,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Hủy',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Thêm Khoản Chi',
                    style: AppTypography.screenTitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  if (tripName != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.luggage_rounded,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            tripName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          AppIconButton(
            icon: Icons.document_scanner_outlined,
            iconColor: AppColors.primary,
            backgroundColor: AppColors.primaryLight,
            onPressed: onScanReceipt,
            semanticLabel: 'Quét hóa đơn',
          ),
        ],
      ),
    );
  }
}

class TripAddExpenseBottomBar extends StatelessWidget {
  const TripAddExpenseBottomBar({
    super.key,
    required this.memberCount,
    required this.isLoading,
    required this.onSubmit,
  });

  final int memberCount;
  final bool isLoading;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.glass85,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                label: 'Xác nhận & Lưu khoản chi',
                trailingIcon: Icons.arrow_forward_rounded,
                isLoading: isLoading,
                onPressed: onSubmit,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sync_rounded,
                    size: 12,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'Tự động cập nhật Quỹ nhóm và thông báo tới '
                      '$memberCount thành viên.',
                      textAlign: TextAlign.center,
                      style: AppTypography.caption.copyWith(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripAddExpenseAmountCard extends StatelessWidget {
  const TripAddExpenseAmountCard({
    super.key,
    required this.amountController,
    required this.descriptionController,
    required this.currency,
    required this.onAmountChanged,
    required this.onClearAmount,
    required this.onDescriptionChanged,
    required this.onCurrencyChanged,
    required this.onCalculate,
    this.amountError,
  });

  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final TripExpensesCurrency currency;
  final ValueChanged<String> onAmountChanged;
  final VoidCallback onClearAmount;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<TripExpensesCurrency> onCurrencyChanged;
  final VoidCallback onCalculate;
  final String? amountError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardProminent),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardLarge),
        border: Border.all(color: AppColors.borderNeutral),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'SỐ TIỀN CHI TIÊU',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),
              const Spacer(),
              _CurrencyToggle(value: currency, onChanged: onCurrencyChanged),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: AppTypography.display.copyWith(fontSize: 32),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: AppTypography.display.copyWith(
                      fontSize: 32,
                      color: AppColors.textTertiary,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    LengthLimitingTextInputFormatter(18),
                  ],
                  onChanged: onAmountChanged,
                ),
              ),
              Text(
                expenseCurrencySymbol(currency),
                style: AppTypography.display.copyWith(
                  fontSize: 32,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              AppIconButton(
                icon: Icons.backspace_outlined,
                iconColor: AppColors.textSecondary,
                backgroundColor: Colors.transparent,
                onPressed: onClearAmount,
                semanticLabel: 'Xóa số tiền',
              ),
              AppIconButton(
                icon: Icons.calculate_outlined,
                iconColor: AppColors.textSecondary,
                backgroundColor: Colors.transparent,
                onPressed: onCalculate,
                semanticLabel: 'Máy tính',
              ),
            ],
          ),
          Container(height: 1, color: AppColors.surfaceSubdued),
          if (amountError != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              amountError!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderBrandSoft),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.receipt_long_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Nội dung khoản chi (VD: Vé cáp treo, Bữa tối...)',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(500)],
                    onChanged: onDescriptionChanged,
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

class _CurrencyToggle extends StatelessWidget {
  const _CurrencyToggle({required this.value, required this.onChanged});

  final TripExpensesCurrency value;
  final ValueChanged<TripExpensesCurrency> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final currency in TripExpensesCurrency.values)
            AppPressable(
              onTap: () => onChanged(currency),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: value == currency
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  expenseCurrencyCode(currency),
                  style: AppTypography.badge.copyWith(
                    color: value == currency
                        ? AppColors.textInverse
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TripAddExpenseCategoryGrid extends StatelessWidget {
  const TripAddExpenseCategoryGrid({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final TripExpensesCategory selected;
  final ValueChanged<TripExpensesCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Danh Mục Chi Tiêu',
                style: AppTypography.sectionTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Bắt buộc',
              style: AppTypography.caption.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 0.78,
          children: [
            for (final category in TripExpensesCategory.values)
              _CategoryTile(
                category: category,
                selected: selected == category,
                onTap: () => onSelected(category),
              ),
          ],
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final TripExpensesCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.97,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderBrandSoft,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected ? AppShadows.level1 : const [],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? AppColors.primary
                          : AppColors.surfaceSubdued,
                    ),
                    child: Icon(
                      expenseCategoryIcon(category),
                      color: selected
                          ? AppColors.textInverse
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    expenseCategoryLabel(category),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle.copyWith(
                      fontSize: 12,
                      height: 1.2,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  Text(
                    expenseCategoryApiLabel(category),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      fontSize: 9,
                      color: selected
                          ? AppColors.primary.withValues(alpha: 0.8)
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 10,
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

class TripAddExpensePayerSection extends StatelessWidget {
  const TripAddExpensePayerSection({
    super.key,
    required this.members,
    required this.viewerUserId,
    required this.selectedMemberId,
    required this.onSelect,
  });

  final List<TripDetailMember> members;
  final String viewerUserId;
  final String? selectedMemberId;
  final ValueChanged<TripDetailMember> onSelect;

  @override
  Widget build(BuildContext context) {
    TripDetailMember? selected;
    for (final member in members) {
      if (member.id == selectedMemberId) {
        selected = member;
        break;
      }
    }
    if (selected == null) {
      for (final member in members) {
        if (member.userId == viewerUserId) {
          selected = member;
          break;
        }
      }
    }
    selected ??= members.isEmpty ? null : members.first;
    final badgeName = selected?.displayName ?? 'Bạn';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ai đã thanh toán?', style: AppTypography.sectionTitle),
                  Text(
                    'Người ứng trước tiền túi cho khoản này',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF99F2EC),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                badgeName,
                style: AppTypography.badge.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 86,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: members.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final member = members[index];
              final isViewer = member.userId == viewerUserId;
              final isSelected = selected?.id == member.id;
              return _PayerAvatar(
                member: member,
                selected: isSelected,
                isViewer: isViewer,
                onTap: () => onSelect(member),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PayerAvatar extends StatelessWidget {
  const _PayerAvatar({
    required this.member,
    required this.selected,
    required this.isViewer,
    this.onTap,
  });

  final TripDetailMember member;
  final bool selected;
  final bool isViewer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final label = isViewer
        ? '${_firstName(member.displayName)} (Bạn)'
        : _firstName(member.displayName);

    return AppPressable(
      onTap: onTap,
      child: Opacity(
        opacity: selected ? 1 : 0.7,
        child: SizedBox(
          width: 72,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.borderBrandSoft,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: AppAvatar(
                      size: 52,
                      imageUrl: member.avatarUrl,
                      initials: _initials(member.displayName),
                    ),
                  ),
                  if (selected)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          border: Border.all(
                            color: AppColors.surface,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: AppColors.textInverse,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _firstName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? name : parts.first;
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.take(2).toString().toUpperCase();
    }
    return '${parts.first.characters.first}${parts.last.characters.first}'
        .toUpperCase();
  }
}

class TripAddExpenseSplitSection extends StatelessWidget {
  const TripAddExpenseSplitSection({
    super.key,
    required this.form,
    required this.members,
    required this.viewerUserId,
    required this.equalShare,
    required this.customAllocated,
    required this.customPercent,
    required this.customControllerFor,
    required this.onSplitTypeChanged,
    required this.onCustomAmountChanged,
    this.splitsError,
  });

  final TripExpensesCreateFormState form;
  final List<TripDetailMember> members;
  final String viewerUserId;
  final num? equalShare;
  final num customAllocated;
  final int customPercent;
  final TextEditingController Function(String memberId) customControllerFor;
  final ValueChanged<TripExpensesSplitType> onSplitTypeChanged;
  final void Function(String memberId, String value) onCustomAmountChanged;
  final String? splitsError;

  @override
  Widget build(BuildContext context) {
    final isEqual = form.splitType == TripExpensesSplitType.equal;
    final amount = form.amount;
    final allocatedOk =
        amount != null && amount > 0 && (isEqual || customAllocated == amount);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardLarge),
        border: Border.all(color: AppColors.borderNeutral),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Phương Thức Chia Tiền',
                  style: AppTypography.sectionTitle,
                ),
              ),
              Text(
                '${members.length} người tham gia',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderBrandSoft),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _SplitTypeTab(
                    label: 'Chia đều',
                    icon: Icons.pie_chart_rounded,
                    selected: isEqual,
                    onTap: () =>
                        onSplitTypeChanged(TripExpensesSplitType.equal),
                  ),
                ),
                Expanded(
                  child: _SplitTypeTab(
                    label: 'Tùy chỉnh',
                    icon: Icons.tune_rounded,
                    selected: !isEqual,
                    onTap: () =>
                        onSplitTypeChanged(TripExpensesSplitType.custom),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (isEqual) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.borderBrandSoft),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    child: const Icon(
                      Icons.group_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mỗi thành viên chi trả',
                          style: AppTypography.caption.copyWith(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          equalShare == null
                              ? '—'
                              : formatExpenseMoney(
                                  equalShare!,
                                  currency: form.currency,
                                ),
                          style: AppTypography.cardTitle.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.borderBrandSoft),
                    ),
                    child: Text(
                      '${members.length} / ${members.length} Người',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final member in members)
              _EqualMemberRow(
                member: member,
                isViewer: member.userId == viewerUserId,
                share: equalShare,
                currency: form.currency,
              ),
          ] else ...[
            for (final member in members) ...[
              _CustomMemberAmountRow(
                member: member,
                isViewer: member.userId == viewerUserId,
                controller: customControllerFor(member.id),
                onChanged: (value) => onCustomAmountChanged(member.id, value),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
          ],
          if (splitsError != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              splitsError!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.surfaceSubdued),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text(
                allocatedOk ? 'Đã phân bổ hoàn tất' : 'Đang phân bổ',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Icon(
                allocatedOk ? Icons.check_circle_rounded : Icons.info_outline,
                size: 12,
                color: allocatedOk ? AppColors.success : AppColors.warning,
              ),
              const SizedBox(width: 4),
              Text(
                '${formatExpenseMoney(isEqual ? (amount ?? 0) : customAllocated, currency: form.currency)}'
                ' / '
                '${formatExpenseMoney(amount ?? 0, currency: form.currency)}'
                ' (${isEqual ? 100 : customPercent}%)',
                style: AppTypography.caption.copyWith(
                  color: allocatedOk ? AppColors.success : AppColors.warning,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: isEqual
                  ? (amount != null && amount > 0 ? 1 : 0)
                  : (amount != null && amount > 0
                        ? (customAllocated / amount).clamp(0.0, 1.0)
                        : 0),
              minHeight: 6,
              backgroundColor: AppColors.surfaceSubdued,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplitTypeTab extends StatelessWidget {
  const _SplitTypeTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: selected ? AppShadows.level1 : const [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.cardTitle.copyWith(
                fontSize: 13,
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EqualMemberRow extends StatelessWidget {
  const _EqualMemberRow({
    required this.member,
    required this.isViewer,
    required this.share,
    required this.currency,
  });

  final TripDetailMember member;
  final bool isViewer;
  final num? share;
  final TripExpensesCurrency currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(Icons.check_box_rounded, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isViewer ? '${member.displayName} (Bạn)' : member.displayName,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _roleLabel(member.role),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            share == null
                ? '—'
                : formatExpenseMoney(share!, currency: currency),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomMemberAmountRow extends StatelessWidget {
  const _CustomMemberAmountRow({
    required this.member,
    required this.isViewer,
    required this.controller,
    required this.onChanged,
  });

  final TripDetailMember member;
  final bool isViewer;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isViewer ? '${member.displayName} (Bạn)' : member.displayName,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _roleLabel(member.role),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 120,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              filled: true,
              fillColor: AppColors.surfaceSubdued,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.input),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              LengthLimitingTextInputFormatter(15),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class TripAddExpenseReceiptSection extends StatelessWidget {
  const TripAddExpenseReceiptSection({
    super.key,
    required this.localPaths,
    required this.onAddPhoto,
    required this.onRemoveAt,
    required this.onOcrAt,
    this.canAddMore = true,
    this.showOcr = true,
  });

  final List<String> localPaths;
  final VoidCallback onAddPhoto;
  final ValueChanged<int> onRemoveAt;
  final ValueChanged<int> onOcrAt;
  final bool canAddMore;
  final bool showOcr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Hóa Đơn & Chứng Từ', style: AppTypography.sectionTitle),
            const Spacer(),
            Text(
              localPaths.isEmpty
                  ? 'Tuỳ chọn'
                  : '${localPaths.length} tệp đã đính kèm',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 112,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < localPaths.length; i++) ...[
                _ReceiptThumb(
                  path: localPaths[i],
                  onRemove: () => onRemoveAt(i),
                  onOcr: showOcr ? () => onOcrAt(i) : null,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              if (canAddMore)
                AppPressable(
                  onTap: onAddPhoto,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  child: Container(
                    width: 140,
                    height: 112,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSubdued.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(
                        color: AppColors.borderBrandSoft,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surface,
                            boxShadow: AppShadows.level1,
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Thêm ảnh hóa đơn',
                          style: AppTypography.cardTitle.copyWith(fontSize: 12),
                        ),
                        Text(
                          'Chụp ảnh hoặc thư viện',
                          style: AppTypography.caption.copyWith(
                            fontSize: 10,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
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

class _ReceiptThumb extends StatelessWidget {
  const _ReceiptThumb({required this.path, required this.onRemove, this.onOcr});

  final String path;
  final VoidCallback onRemove;
  final VoidCallback? onOcr;

  @override
  Widget build(BuildContext context) {
    final image = !kIsWeb
        ? Image.file(
            File(path),
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: AppColors.surfaceSubdued,
              child: Icon(Icons.receipt_long_rounded),
            ),
          )
        : Image.network(
            path,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: AppColors.surfaceSubdued,
              child: Icon(Icons.receipt_long_rounded),
            ),
          );

    return SizedBox(
      width: 140,
      height: 112,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: image,
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: AppPressable(
              onTap: onRemove,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.danger,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ),
          if (onOcr != null)
            Positioned(
              left: 6,
              bottom: 6,
              child: AppPressable(
                onTap: onOcr,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'Đọc OCR',
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textInverse,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String _roleLabel(TripDetailMemberRole role) => switch (role) {
  TripDetailMemberRole.owner => 'Trưởng nhóm',
  TripDetailMemberRole.admin => 'Quản trị',
  TripDetailMemberRole.member => 'Thành viên',
};

String formatExpenseSpentAtLabel(DateTime? spentAt, {DateTime? now}) {
  final value = spentAt ?? now ?? DateTime.now();
  return formatExpenseWhen(value, now: now);
}

Future<void> showTripAddExpenseWhenSheet({
  required BuildContext context,
  required DateTime initialSpentAt,
  required String initialLocation,
  required void Function(DateTime spentAt, String locationNote) onSave,
}) async {
  var spentAt = initialSpentAt;
  final locationController = TextEditingController(text: initialLocation);

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.sheet),
      ),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.screenHorizontal,
          right: AppSpacing.screenHorizontal,
          top: AppSpacing.md,
          bottom: MediaQuery.viewInsetsOf(ctx).bottom + AppSpacing.md,
        ),
        child: StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Ngày chi & vị trí', style: AppTypography.sectionTitle),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Ngày & giờ chi'),
                  subtitle: Text(formatExpenseSpentAtLabel(spentAt)),
                  trailing: const Icon(Icons.edit_calendar_outlined),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: spentAt,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 1)),
                    );
                    if (date == null || !context.mounted) return;
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(spentAt),
                    );
                    if (time == null) return;
                    setModalState(() {
                      spentAt = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  },
                ),
                TextField(
                  controller: locationController,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: 'Vị trí quán (tuỳ chọn)',
                    hintText: 'VD: Hải sản Năm Đảnh',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Lưu',
                  onPressed: () {
                    onSave(spentAt, locationController.text.trim());
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          },
        ),
      );
    },
  );
  locationController.dispose();
}
