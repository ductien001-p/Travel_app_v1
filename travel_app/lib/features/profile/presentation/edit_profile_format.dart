/// Hiển thị số điện thoại theo dạng `(+84) 987 ••• 678`.
String maskEditProfilePhone(String phone) {
  final digits = phone.replaceAll(RegExp(r'\D'), '');
  var local = digits;
  if (local.startsWith('84') && local.length > 9) {
    local = local.substring(2);
  } else if (local.startsWith('0') && local.length > 9) {
    local = local.substring(1);
  }
  if (local.length < 6) return phone.trim();
  final head = local.substring(0, 3);
  final tail = local.substring(local.length - 3);
  return '(+84) $head ••• $tail';
}

/// `yyyy-MM-dd` → `dd/MM/yyyy`. Giữ nguyên chuỗi không parse được.
String formatEditProfileDate(String? iso) {
  final trimmed = iso?.trim() ?? '';
  if (trimmed.isEmpty) return '';
  final parsed = DateTime.tryParse(trimmed);
  if (parsed == null) return trimmed;
  final day = parsed.day.toString().padLeft(2, '0');
  final month = parsed.month.toString().padLeft(2, '0');
  return '$day/$month/${parsed.year}';
}

/// `dd/MM/yyyy` → `yyyy-MM-dd`. Chuỗi trống trả về `''`. Sai định dạng trả về null.
String? parseEditProfileDate(String display) {
  final trimmed = display.trim();
  if (trimmed.isEmpty) return '';
  final match = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(trimmed);
  if (match == null) return null;
  final day = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final year = int.parse(match.group(3)!);
  final parsed = DateTime(year, month, day);
  final isRealDate =
      parsed.year == year && parsed.month == month && parsed.day == day;
  if (!isRealDate) return null;
  final isoMonth = month.toString().padLeft(2, '0');
  final isoDay = day.toString().padLeft(2, '0');
  return '$year-$isoMonth-$isoDay';
}
