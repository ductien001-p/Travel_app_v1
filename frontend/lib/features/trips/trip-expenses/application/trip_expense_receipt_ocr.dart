import 'package:flutter/foundation.dart';

import '../data/models/trip_expenses_models.dart';

/// Result of parsing OCR text from a receipt image.
class TripExpenseOcrResult {
  const TripExpenseOcrResult({
    this.amountText,
    this.description,
    this.category,
  });

  final String? amountText;
  final String? description;
  final TripExpensesCategory? category;
}

/// Parses Vietnamese/English receipt text into form fields (pure Dart).
TripExpenseOcrResult parseExpenseReceiptText(
  String raw, {
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) {
  final text = raw.replaceAll('\r\n', '\n').trim();
  if (text.isEmpty) return const TripExpenseOcrResult();

  final amountText = _extractAmount(text, currency);
  final description = _extractDescription(text);
  final category = _guessCategory(text);

  return TripExpenseOcrResult(
    amountText: amountText,
    description: description,
    category: category,
  );
}

String? _extractAmount(String text, TripExpensesCurrency currency) {
  final patterns = <RegExp>[
    RegExp(
      r'(?:tổng|tong|total|thanh\s*toán|amount|sum)[^\d]{0,20}([\d.,]+)',
      caseSensitive: false,
    ),
    RegExp(r'([\d]{1,3}(?:[.,]\d{3})+)'),
    RegExp(r'([\d]+[.,]\d{2})\b'),
  ];

  for (final pattern in patterns) {
    final match = pattern.firstMatch(text);
    final raw = match?.group(1);
    if (raw == null) continue;
    final cleaned = raw.trim();
    if (cleaned.isEmpty) continue;
    if (currency == TripExpensesCurrency.vnd) {
      final digits = cleaned.replaceAll(RegExp(r'[^\d]'), '');
      if (digits.isEmpty) continue;
      final value = num.tryParse(digits);
      if (value == null || value <= 0) continue;
      return digits;
    }
    final normalized = cleaned.replaceAll(',', '');
    final value = num.tryParse(normalized);
    if (value == null || value <= 0) continue;
    return normalized;
  }
  return null;
}

String? _extractDescription(String text) {
  final lines = text
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.length >= 4)
      .where((line) => !RegExp(r'^[\d\s.,đ₫$]+$').hasMatch(line))
      .where(
        (line) => !RegExp(
          r'^(tổng|tong|total|cảm ơn|cam on|thank|bàn\s*\d+|table\s*\d+)',
          caseSensitive: false,
        ).hasMatch(line),
      )
      .toList(growable: false);
  if (lines.isEmpty) return null;
  // Prefer the first merchant / title line on the receipt.
  final pick = lines.first;
  return pick.length <= 80 ? pick : pick.substring(0, 80);
}

TripExpensesCategory? _guessCategory(String text) {
  final lower = text.toLowerCase();
  if (RegExp(
    r'ăn|food|nhà hàng|hải sản|cafe|cà phê|bia|restaurant',
  ).hasMatch(lower)) {
    return TripExpensesCategory.food;
  }
  if (RegExp(r'khách sạn|hotel|homestay|lưu trú').hasMatch(lower)) {
    return TripExpensesCategory.accommodation;
  }
  if (RegExp(
    r'grab|taxi|xăng|vé xe|bus|train|di chuyển|transport',
  ).hasMatch(lower)) {
    return TripExpensesCategory.transport;
  }
  if (RegExp(r'vé|ticket|tour|bảo tàng|activity').hasMatch(lower)) {
    return TripExpensesCategory.activity;
  }
  if (RegExp(r'shop|mua sắm|souvenir').hasMatch(lower)) {
    return TripExpensesCategory.shopping;
  }
  return null;
}

/// Whether on-device OCR is expected to work on this platform.
bool isExpenseReceiptOcrSupported() {
  if (kIsWeb) return false;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      return true;
    default:
      return false;
  }
}
