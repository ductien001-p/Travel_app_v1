import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_typography.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.leadingIcon,
    this.trailing,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? leadingIcon;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final isTextArea = maxLines > 1 || (minLines ?? 1) > 1;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: isTextArea ? 100 : AppSizes.inputMinHeight,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        enabled: enabled,
        maxLines: obscureText ? 1 : maxLines,
        minLines: obscureText ? 1 : minLines,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: leadingIcon == null
              ? null
              : Icon(leadingIcon, size: 20, color: AppColors.primary),
          suffixIcon: trailing,
          filled: true,
          fillColor: AppColors.glass90,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
            borderSide: const BorderSide(color: AppColors.borderNeutral),
          ),
        ),
      ),
    );
  }
}
