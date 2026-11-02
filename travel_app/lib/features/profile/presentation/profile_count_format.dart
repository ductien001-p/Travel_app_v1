String formatProfileCount(num value) {
  final negative = value < 0;
  final digits = value.round().abs().toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    final remaining = digits.length - index;
    if (index > 0 && remaining % 3 == 0) buffer.write('.');
    buffer.write(digits[index]);
  }
  return negative ? '-${buffer.toString()}' : buffer.toString();
}

double profileRatio(int part, int total) {
  if (total <= 0) return 0;
  final ratio = part / total;
  if (ratio < 0) return 0;
  if (ratio > 1) return 1;
  return ratio;
}
