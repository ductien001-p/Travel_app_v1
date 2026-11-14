import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/presentation/edit_profile_format.dart';

void main() {
  test('masks a local Vietnamese phone number', () {
    expect(maskEditProfilePhone('0987654678'), '(+84) 987 ••• 678');
    expect(maskEditProfilePhone('+84 987 654 678'), '(+84) 987 ••• 678');
  });

  test('keeps a short phone number readable', () {
    expect(maskEditProfilePhone('12345'), '12345');
  });

  test('formats and parses a birth date', () {
    expect(formatEditProfileDate('1996-08-15'), '15/08/1996');
    expect(parseEditProfileDate('15/08/1996'), '1996-08-15');
    expect(parseEditProfileDate(''), '');
    expect(parseEditProfileDate('31/02/1996'), isNull);
    expect(parseEditProfileDate('1996-08-15'), isNull);
  });
}
