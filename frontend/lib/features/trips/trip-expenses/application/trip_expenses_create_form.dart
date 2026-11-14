import '../data/models/trip_expenses_models.dart';

const maxExpenseReceipts = 5;

class TripExpensesCreateFormState {
  const TripExpensesCreateFormState({
    this.amountText = '',
    this.description = '',
    this.currency = TripExpensesCurrency.vnd,
    this.category = TripExpensesCategory.food,
    this.splitType = TripExpensesSplitType.equal,
    this.customAmounts = const {},
    this.payerTripMemberId,
    this.spentAt,
    this.locationNote = '',
    this.receiptMediaIds = const [],
  });

  final String amountText;
  final String description;
  final TripExpensesCurrency currency;
  final TripExpensesCategory category;
  final TripExpensesSplitType splitType;

  /// Member id → amount text for CUSTOM splits.
  final Map<String, String> customAmounts;

  /// Active trip member id of who paid; null = viewer (resolved at submit).
  final String? payerTripMemberId;

  /// When the money was spent; null = now at submit.
  final DateTime? spentAt;

  final String locationNote;
  final List<String> receiptMediaIds;

  num? get amount => parseExpenseAmountText(amountText, currency);

  TripExpensesCreateFormState copyWith({
    String? amountText,
    String? description,
    TripExpensesCurrency? currency,
    TripExpensesCategory? category,
    TripExpensesSplitType? splitType,
    Map<String, String>? customAmounts,
    String? payerTripMemberId,
    DateTime? spentAt,
    String? locationNote,
    List<String>? receiptMediaIds,
    bool clearPayer = false,
    bool clearSpentAt = false,
  }) => TripExpensesCreateFormState(
    amountText: amountText ?? this.amountText,
    description: description ?? this.description,
    currency: currency ?? this.currency,
    category: category ?? this.category,
    splitType: splitType ?? this.splitType,
    customAmounts: customAmounts ?? this.customAmounts,
    payerTripMemberId: clearPayer
        ? null
        : (payerTripMemberId ?? this.payerTripMemberId),
    spentAt: clearSpentAt ? null : (spentAt ?? this.spentAt),
    locationNote: locationNote ?? this.locationNote,
    receiptMediaIds: receiptMediaIds ?? this.receiptMediaIds,
  );
}

class TripExpensesCreateValidation {
  const TripExpensesCreateValidation({
    this.amountError,
    this.splitsError,
    this.payerError,
    this.receiptsError,
    this.locationError,
  });

  final String? amountError;
  final String? splitsError;
  final String? payerError;
  final String? receiptsError;
  final String? locationError;

  bool get isValid =>
      amountError == null &&
      splitsError == null &&
      payerError == null &&
      receiptsError == null &&
      locationError == null;
}

TripExpensesCreateValidation validateTripExpensesCreateForm(
  TripExpensesCreateFormState form, {
  required List<String> memberIds,
}) {
  final amount = form.amount;
  String? amountError;
  String? splitsError;
  String? payerError;
  String? receiptsError;
  String? locationError;

  if (amount == null || amount <= 0) {
    amountError = 'Nhập số tiền lớn hơn 0';
  } else if (form.currency == TripExpensesCurrency.vnd && amount % 1 != 0) {
    amountError = 'Số tiền VND phải là số nguyên';
  }

  if (form.payerTripMemberId != null &&
      !memberIds.contains(form.payerTripMemberId)) {
    payerError = 'Người thanh toán không hợp lệ';
  }

  if (form.receiptMediaIds.length > maxExpenseReceipts) {
    receiptsError = 'Tối đa $maxExpenseReceipts ảnh hóa đơn';
  }

  if (form.locationNote.trim().length > 200) {
    locationError = 'Vị trí tối đa 200 ký tự';
  }

  if (amountError == null && amount != null) {
    if (form.splitType == TripExpensesSplitType.custom) {
      if (memberIds.isEmpty) {
        splitsError = 'Không có thành viên để chia';
      } else {
        num sum = 0;
        var hasAny = false;
        for (final id in memberIds) {
          final raw = form.customAmounts[id]?.trim() ?? '';
          if (raw.isEmpty) continue;
          final value = parseExpenseAmountText(raw, form.currency);
          if (value == null || value < 0) {
            splitsError = 'Số tiền chia không hợp lệ';
            break;
          }
          if (value > 0) hasAny = true;
          sum += value;
        }
        if (splitsError == null) {
          if (!hasAny) {
            splitsError = 'Nhập phần chia cho ít nhất một thành viên';
          } else if (sum != amount) {
            splitsError = 'Tổng phần chia phải bằng số tiền khoản chi';
          }
        }
      }
    }
  }

  return TripExpensesCreateValidation(
    amountError: amountError,
    splitsError: splitsError,
    payerError: payerError,
    receiptsError: receiptsError,
    locationError: locationError,
  );
}

CreateTripExpenseRequest? buildCreateTripExpenseRequest(
  TripExpensesCreateFormState form, {
  required List<String> memberIds,
  String? defaultPayerTripMemberId,
}) {
  final validation = validateTripExpensesCreateForm(form, memberIds: memberIds);
  if (!validation.isValid) return null;
  final amount = form.amount!;
  final description = form.description.trim();
  final locationNote = form.locationNote.trim();
  final payerId = form.payerTripMemberId ?? defaultPayerTripMemberId;

  if (form.splitType == TripExpensesSplitType.equal) {
    return CreateTripExpenseRequest(
      amount: amount,
      currency: form.currency,
      category: form.category,
      splitType: TripExpensesSplitType.equal,
      description: description.isEmpty ? null : description,
      payerTripMemberId: payerId,
      spentAt: form.spentAt,
      locationNote: locationNote.isEmpty ? null : locationNote,
      receiptMediaIds: form.receiptMediaIds,
    );
  }

  final splits = <CreateTripExpenseSplit>[];
  for (final id in memberIds) {
    final raw = form.customAmounts[id]?.trim() ?? '';
    if (raw.isEmpty) continue;
    final value = parseExpenseAmountText(raw, form.currency);
    if (value == null || value <= 0) continue;
    splits.add(CreateTripExpenseSplit(tripMemberId: id, amount: value));
  }

  return CreateTripExpenseRequest(
    amount: amount,
    currency: form.currency,
    category: form.category,
    splitType: TripExpensesSplitType.custom,
    description: description.isEmpty ? null : description,
    payerTripMemberId: payerId,
    spentAt: form.spentAt,
    locationNote: locationNote.isEmpty ? null : locationNote,
    receiptMediaIds: form.receiptMediaIds,
    splits: splits,
  );
}

num? parseExpenseAmountText(String text, TripExpensesCurrency currency) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;
  if (currency == TripExpensesCurrency.usd) {
    // USD: `.` is decimal; ignore thousand commas.
    return num.tryParse(trimmed.replaceAll(',', ''));
  }
  // VND: `.`/`,` are thousand separators; integer only.
  final normalized = trimmed.replaceAll('.', '').replaceAll(',', '');
  if (normalized.isEmpty) return null;
  return num.tryParse(normalized);
}

/// Formats amount input for display. VND uses thousand dots; USD keeps decimals.
String formatExpenseAmountInput(
  String raw, {
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) {
  if (currency == TripExpensesCurrency.usd) {
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    final parts = cleaned.split('.');
    if (parts.length == 1) return parts.first;
    final decimals = parts.skip(1).join().replaceAll('.', '');
    final limited = decimals.length > 2 ? decimals.substring(0, 2) : decimals;
    return '${parts.first}.$limited';
  }
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return '';
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final fromEnd = digits.length - i;
    buffer.write(digits[i]);
    if (fromEnd > 1 && fromEnd % 3 == 1) buffer.write('.');
  }
  return buffer.toString();
}

String expenseCurrencyCode(TripExpensesCurrency currency) => switch (currency) {
  TripExpensesCurrency.vnd => 'VND',
  TripExpensesCurrency.usd => 'USD',
};

String expenseCurrencySymbol(TripExpensesCurrency currency) =>
    switch (currency) {
      TripExpensesCurrency.vnd => '₫',
      TripExpensesCurrency.usd => '\$',
    };

String expenseCategoryApiLabel(TripExpensesCategory category) =>
    switch (category) {
      TripExpensesCategory.food => 'FOOD',
      TripExpensesCategory.accommodation => 'ACCOMMODATION',
      TripExpensesCategory.transport => 'TRANSPORT',
      TripExpensesCategory.activity => 'ACTIVITY',
      TripExpensesCategory.shopping => 'SHOPPING',
      TripExpensesCategory.other => 'OTHER',
    };
