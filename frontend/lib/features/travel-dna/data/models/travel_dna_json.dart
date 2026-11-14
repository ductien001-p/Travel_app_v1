int travelDnaJsonInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  throw FormatException('Travel DNA field is not a number: $value');
}
