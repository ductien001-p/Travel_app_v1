import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/application/trip_expense_receipt_ocr.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/models/trip_expenses_models.dart';

void main() {
  test('parses VND total and food category from sample receipt text', () {
    const sample = '''
Hải sản Năm Đảnh
Bàn 7
Tổng cộng: 1.250.000
Cảm ơn quý khách
''';

    final result = parseExpenseReceiptText(sample);

    expect(result.amountText, '1250000');
    expect(result.description, contains('Hải sản'));
    expect(result.category, TripExpensesCategory.food);
  });

  test('parses USD decimal amount', () {
    const sample = 'Total amount: 42.50 USD';
    final result = parseExpenseReceiptText(
      sample,
      currency: TripExpensesCurrency.usd,
    );

    expect(result.amountText, '42.50');
  });
}
