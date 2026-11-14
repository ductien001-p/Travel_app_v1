import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';

import '../../data/datamock/trip_join_by_code_datamock.dart';
import '../../utils/trip_join_by_code_formatters.dart';

/// Ô nhập mã mời dạng nhiều slot + dán clipboard.
class TripJoinByCodeInput extends StatefulWidget {
  const TripJoinByCodeInput({
    super.key,
    required this.code,
    required this.onCodeChanged,
    this.isValidPreview = false,
  });

  final String code;
  final ValueChanged<String> onCodeChanged;
  final bool isValidPreview;

  @override
  State<TripJoinByCodeInput> createState() => _TripJoinByCodeInputState();
}

class _TripJoinByCodeInputState extends State<TripJoinByCodeInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      tripInviteCodeLength,
      (i) => TextEditingController(
        text: i < widget.code.length ? widget.code[i] : '',
      ),
    );
    _focusNodes = List.generate(tripInviteCodeLength, (_) {
      final node = FocusNode();
      node.addListener(_onFocusChanged);
      return node;
    });
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant TripJoinByCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code == widget.code) return;
    _syncFromCode(widget.code);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f
        ..removeListener(_onFocusChanged)
        ..dispose();
    }
    super.dispose();
  }

  void _syncFromCode(String code) {
    for (var i = 0; i < tripInviteCodeLength; i++) {
      final next = i < code.length ? code[i] : '';
      if (_controllers[i].text != next) {
        _controllers[i].value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
    }
  }

  String get _joined => _controllers.map((c) => c.text).join().toUpperCase();

  void _emit() => widget.onCodeChanged(normalizeInviteCode(_joined));

  void _onChanged(int index, String value) {
    final cleaned = normalizeInviteCode(value);
    if (cleaned.length > 1) {
      _applyPaste(cleaned);
      return;
    }
    _controllers[index].value = TextEditingValue(
      text: cleaned,
      selection: TextSelection.collapsed(offset: cleaned.length),
    );
    if (cleaned.isNotEmpty && index < tripInviteCodeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    _emit();
  }

  void _applyPaste(String raw) {
    final normalized = normalizeInviteCode(raw);
    final code = normalized.length > tripInviteCodeLength
        ? normalized.substring(0, tripInviteCodeLength)
        : normalized;
    for (var i = 0; i < tripInviteCodeLength; i++) {
      final char = i < code.length ? code[i] : '';
      _controllers[i].value = TextEditingValue(
        text: char,
        selection: TextSelection.collapsed(offset: char.length),
      );
    }
    final focusAt = code.length.clamp(0, tripInviteCodeLength - 1);
    _focusNodes[focusAt].requestFocus();
    _emit();
  }

  KeyEventResult _onKey(int index, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey != LogicalKeyboardKey.backspace) {
      return KeyEventResult.ignored;
    }
    if (_controllers[index].text.isNotEmpty) return KeyEventResult.ignored;
    if (index == 0) return KeyEventResult.ignored;
    _focusNodes[index - 1].requestFocus();
    _controllers[index - 1].clear();
    _emit();
    return KeyEventResult.handled;
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.trim().isEmpty) return;
    _applyPaste(text);
  }

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Text(
            'Mã số mời tham gia (Invite Code)',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                for (var i = 0; i < tripInviteCodeLength; i++) ...[
                  if (i > 0) const SizedBox(width: AppSpacing.xxs),
                  Expanded(child: _slot(i)),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (widget.isValidPreview)
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Flexible(
                        child: Text(
                          'Mã chuyến đi hợp lệ',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Spacer(),
              TextButton.icon(
                onPressed: _pasteFromClipboard,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.primaryLight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  shape: const StadiumBorder(),
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Icons.content_paste_rounded, size: 14),
                label: Text(
                  'Dán từ bộ nhớ tạm',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _slot(int index) {
    final focused = _focusNodes[index].hasFocus;
    final filled = _controllers[index].text.isNotEmpty;
    return Focus(
      onKeyEvent: (node, event) => _onKey(index, event),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: AppTypography.screenTitle.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
        keyboardType: TextInputType.visiblePassword,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
          LengthLimitingTextInputFormatter(tripInviteCodeLength),
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surfaceSubdued,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
            borderSide: BorderSide(
              color: focused || (filled && index == widget.code.length - 1)
                  ? AppColors.primary
                  : AppColors.borderBrandSoft,
              width: focused ? 2 : 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
            borderSide: BorderSide(
              color: focused || (filled && index == widget.code.length - 1)
                  ? AppColors.primary
                  : AppColors.borderBrandSoft,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onChanged: (value) => _onChanged(index, value),
        onTap: () => _controllers[index].selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controllers[index].text.length,
        ),
      ),
    );
  }
}
