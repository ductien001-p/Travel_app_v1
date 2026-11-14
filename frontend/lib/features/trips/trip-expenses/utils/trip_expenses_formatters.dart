import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/utils/trip_detail_formatters.dart';

import '../data/models/trip_expenses_models.dart';

String formatExpenseMoney(num amount, {TripExpensesCurrency? currency}) {
  final code = switch (currency ?? TripExpensesCurrency.vnd) {
    TripExpensesCurrency.vnd => 'VND',
    TripExpensesCurrency.usd => 'USD',
  };
  final raw = formatTripMoney(amount.toDouble(), currency: code);
  // Design uses a space before "đ".
  if (code == 'VND' && raw.endsWith('đ')) {
    return '${raw.substring(0, raw.length - 1)} đ';
  }
  return raw;
}

String formatExpenseMoneyCompact(num amount) {
  if (amount >= 1000) {
    return '${(amount / 1000).round()}k';
  }
  return formatExpenseMoney(amount);
}

String formatSignedExpenseMoney(num amount) {
  final abs = formatExpenseMoney(amount.abs());
  if (amount > 0) return '+$abs';
  if (amount < 0) return '-$abs';
  return abs;
}

String expenseCategoryLabel(TripExpensesCategory category) =>
    switch (category) {
      TripExpensesCategory.food => 'Ẩm thực',
      TripExpensesCategory.accommodation => 'Lưu trú',
      TripExpensesCategory.transport => 'Di chuyển',
      TripExpensesCategory.activity => 'Hoạt động & Vé',
      TripExpensesCategory.shopping => 'Mua sắm',
      TripExpensesCategory.other => 'Khác',
    };

String expenseCategoryChipLabel(TripExpensesCategory category) =>
    switch (category) {
      TripExpensesCategory.food => '🍜 Ăn uống',
      TripExpensesCategory.accommodation => '🏨 Khách sạn',
      TripExpensesCategory.transport => '🛵 Đi lại',
      TripExpensesCategory.activity => '🎟️ Vé tham quan',
      TripExpensesCategory.shopping => '🛍️ Mua sắm',
      TripExpensesCategory.other => 'Khác',
    };

IconData expenseCategoryIcon(TripExpensesCategory category) =>
    switch (category) {
      TripExpensesCategory.food => Icons.restaurant_rounded,
      TripExpensesCategory.accommodation => Icons.villa_rounded,
      TripExpensesCategory.transport => Icons.two_wheeler_rounded,
      TripExpensesCategory.activity => Icons.attractions_rounded,
      TripExpensesCategory.shopping => Icons.shopping_bag_rounded,
      TripExpensesCategory.other => Icons.payments_rounded,
    };

Color expenseCategoryColor(TripExpensesCategory category) => switch (category) {
  TripExpensesCategory.food => const Color(0xFFFF7A59),
  TripExpensesCategory.accommodation => const Color(0xFF508FFF),
  TripExpensesCategory.transport => AppColors.primary,
  TripExpensesCategory.activity => AppColors.warning,
  TripExpensesCategory.shopping => const Color(0xFF8B5CF6),
  TripExpensesCategory.other => AppColors.textTertiary,
};

String expenseSplitTypeLabel(TripExpensesSplitType type) => switch (type) {
  TripExpensesSplitType.equal => 'EQUAL',
  TripExpensesSplitType.custom => 'CUSTOM',
};

String expenseSettleStatusLabel(TripExpensesEntry entry) =>
    switch (entry.status) {
      TripExpensesSettleStatus.settled =>
        'Đã tất toán ${entry.settledCount}/${entry.splitCount}',
      TripExpensesSettleStatus.partial =>
        'Đã tất toán ${entry.settledCount}/${entry.splitCount}',
      TripExpensesSettleStatus.pending => 'Chờ thanh toán',
    };

Color expenseSettleStatusColor(TripExpensesSettleStatus status) =>
    switch (status) {
      TripExpensesSettleStatus.settled => AppColors.success,
      TripExpensesSettleStatus.partial => AppColors.success,
      TripExpensesSettleStatus.pending => AppColors.warning,
    };

IconData expenseSettleStatusIcon(TripExpensesSettleStatus status) =>
    switch (status) {
      TripExpensesSettleStatus.settled => Icons.check_circle_rounded,
      TripExpensesSettleStatus.partial => Icons.check_circle_rounded,
      TripExpensesSettleStatus.pending => Icons.hourglass_top_rounded,
    };

String expensePayerLabel(TripExpensesEntry entry) {
  final name = entry.payer.displayName;
  final title = entry.payer.title;
  if (entry.payerIsViewer) {
    return title == null || title.isEmpty ? '$name (Bạn)' : '$name ($title)';
  }
  return title == null || title.isEmpty ? name : '$name ($title)';
}

String formatExpenseWhen(DateTime createdAt, {DateTime? now}) {
  final local = createdAt.toLocal();
  final today = now ?? DateTime.now();
  final localDay = DateTime(local.year, local.month, local.day);
  final todayDay = DateTime(today.year, today.month, today.day);
  final diff = todayDay.difference(localDay).inDays;
  final clock =
      '${local.hour.toString().padLeft(2, '0')}:'
      '${local.minute.toString().padLeft(2, '0')}';
  if (diff == 0) return 'Hôm nay, $clock';
  if (diff == 1) return 'Hôm qua, $clock';
  return '${local.day} Th${local.month.toString().padLeft(2, '0')}';
}

String tripExpensesErrorMessage(Object error) {
  if (error is! ApiException) return 'Đã xảy ra lỗi. Vui lòng thử lại.';
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    401 => 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    403 => 'Chỉ thành viên chuyến đi mới xem được chi tiêu nhóm.',
    404 => 'Chuyến đi không tồn tại hoặc đã bị xóa.',
    _ => 'Không thể tải chi tiêu. Vui lòng thử lại.',
  };
}

String tripExpensesActionErrorMessage(Object error) {
  if (error is! ApiException) {
    return 'Không thể thực hiện. Vui lòng thử lại.';
  }
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    400 => 'Dữ liệu không hợp lệ.',
    403 => 'Bạn không có quyền thực hiện thao tác này.',
    404 => 'Khoản chi hoặc phần chia không còn tồn tại.',
    409 => 'Khoản chia này đã được tất toán.',
    _ => 'Không thể thực hiện. Vui lòng thử lại.',
  };
}

bool isTripExpensesForbidden(Object error) =>
    error is ApiException && error.statusCode == 403;

/// Settlements where the viewer is debtor or creditor.
List<TripExpensesSettlement> viewerRelatedSettlements(
  Iterable<TripExpensesSettlement> settlements,
) => settlements
    .where((row) => row.fromIsViewer || row.toIsViewer)
    .toList(growable: false);

bool canViewerSettleSettlement(TripExpensesSettlement settlement) =>
    settlement.status == TripExpensesSettlementStatus.actionable &&
    (settlement.fromIsViewer || settlement.toIsViewer);

String settlementActionLabel(TripExpensesSettlement settlement) {
  if (settlement.toIsViewer) return 'Xác nhận đã nhận';
  if (settlement.fromIsViewer) return 'Đã chuyển tiền';
  return 'Chờ xác nhận';
}

String settlementConfirmTitle(TripExpensesSettlement settlement) {
  if (settlement.toIsViewer) return 'Xác nhận đã nhận tiền?';
  return 'Ghi nhận đã chuyển tiền?';
}

String settlementConfirmMessage(
  TripExpensesSettlement settlement, {
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) {
  final amount = formatExpenseMoney(settlement.amount, currency: currency);
  if (settlement.toIsViewer) {
    final from = settlement.fromDisplayName.replaceAll(' (Bạn)', '');
    return 'Bạn có xác nhận đã nhận $amount từ $from không?';
  }
  final to = settlement.toDisplayName.replaceAll(' (Bạn)', '');
  return 'Bạn xác nhận đã chuyển $amount cho $to không?';
}

String settlementConfirmPrimaryLabel(TripExpensesSettlement settlement) =>
    settlement.toIsViewer ? 'Xác nhận' : 'Ghi nhận';
