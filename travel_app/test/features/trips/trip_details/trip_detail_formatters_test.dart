import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/utils/trip_detail_formatters.dart';

void main() {
  group('formatTripMoney', () {
    test('groups VND with dots and appends the đồng symbol', () {
      expect(formatTripMoney(4850000), '4.850.000đ');
      expect(formatTripMoney(500), '500đ');
      expect(formatTripMoney(0), '0đ');
    });

    test('rounds and keeps the sign for negative amounts', () {
      expect(formatTripMoney(-1200000.4), '-1.200.000đ');
    });

    test('suffixes other currencies with their code', () {
      expect(formatTripMoney(1500, currency: 'USD'), '1.500 USD');
    });
  });

  group('date ranges', () {
    test('formatTripDuration counts both ends inclusively', () {
      expect(
        formatTripDuration(
          DateTime.utc(2025, 7, 15),
          DateTime.utc(2025, 7, 20),
        ),
        '6 ngày 5 đêm',
      );
      expect(
        formatTripDuration(
          DateTime.utc(2025, 7, 15),
          DateTime.utc(2025, 7, 15, 23),
        ),
        '1 ngày',
      );
    });

    test('formatShortDateRange collapses ranges within one month', () {
      expect(
        formatShortDateRange(
          DateTime.utc(2025, 7, 15),
          DateTime.utc(2025, 7, 18),
        ),
        '15 - 18/07',
      );
      expect(
        formatShortDateRange(
          DateTime.utc(2025, 7, 30),
          DateTime.utc(2025, 8, 2),
        ),
        '30/07 - 02/08',
      );
    });
  });

  group('relative times', () {
    final now = DateTime.utc(2025, 7, 16, 9);

    test('formatActivityTime labels today, tomorrow and other days', () {
      expect(
        formatActivityTime(DateTime.utc(2025, 7, 16, 11, 30), now: now),
        '11:30 Hôm nay',
      );
      expect(
        formatActivityTime(DateTime.utc(2025, 7, 17, 8, 5), now: now),
        '08:05 Ngày mai',
      );
      expect(
        formatActivityTime(DateTime.utc(2025, 7, 20, 18), now: now),
        '18:00 • 20/07',
      );
    });

    test('formatTimelineTime labels today, yesterday and older days', () {
      expect(
        formatTimelineTime(DateTime.utc(2025, 7, 16, 7, 45), now: now),
        '07:45',
      );
      expect(
        formatTimelineTime(DateTime.utc(2025, 7, 15, 22), now: now),
        'Hôm qua',
      );
      expect(formatTimelineTime(DateTime.utc(2025, 7, 12), now: now), '12/07');
    });

    test('renders offset timestamps on the UTC wall clock', () {
      final instant = DateTime.parse('2025-07-17T05:30:00+07:00');

      expect(formatClock(instant), '22:30');
      expect(formatDayMonth(instant), '16/07');
      expect(formatActivityTime(instant, now: now), '22:30 Hôm nay');
    });
  });

  group('initialsOf', () {
    test('uses the first and last word', () {
      expect(initialsOf('Minh Trang'), 'MT');
      expect(initialsOf('  nguyễn   quốc bảo '), 'NB');
    });

    test('handles single words and blank names', () {
      expect(initialsOf('Alex'), 'A');
      expect(initialsOf('   '), '?');
    });
  });

  group('tripDetailErrorMessage', () {
    test('maps forbidden and not found to friendly messages', () {
      expect(
        tripDetailErrorMessage(
          const ApiException(message: 'Forbidden', statusCode: 403),
        ),
        'Bạn không có quyền xem chuyến đi này.',
      );
      expect(
        tripDetailErrorMessage(
          const ApiException(message: 'Not found', statusCode: 404),
        ),
        'Chuyến đi không tồn tại hoặc đã bị xóa.',
      );
    });

    test('uses the API message for other API errors', () {
      expect(
        tripDetailErrorMessage(
          const ApiException(message: 'Máy chủ bận', statusCode: 503),
        ),
        'Máy chủ bận',
      );
    });

    test('hides details of unexpected errors', () {
      expect(
        tripDetailErrorMessage(StateError('internal detail')),
        'Đã xảy ra lỗi. Vui lòng thử lại.',
      );
    });
  });
}
