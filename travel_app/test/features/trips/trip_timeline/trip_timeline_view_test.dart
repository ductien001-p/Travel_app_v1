import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_events_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_filter.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/models/trip_timeline_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/utils/trip_timeline_formatters.dart';

import 'trip_timeline_fixture.dart';

void main() {
  TripTimelineEventsState datamockState({
    TripTimelineFilter filter = TripTimelineFilter.all,
  }) => TripTimelineEventsState.fromPage(
    TripTimelinePage.fromJson(timelineDatamockPage()),
    filter: filter,
  );

  TripTimelineEventsState stateOf(List<Map<String, dynamic>> events) =>
      TripTimelineEventsState.fromPage(
        TripTimelinePage.fromJson(timelinePageJson(events)),
        filter: TripTimelineFilter.all,
      );

  group('buildTripTimelineView', () {
    test('groups by UTC day into today, yesterday and trip start', () {
      final view = buildTripTimelineView(
        events: datamockState(),
        selected: TripTimelineFilter.all,
        now: timelineNow,
        toWallClock: utcWallClock,
      );

      expect(view.status, TripTimelineBodyStatus.ready);
      expect(view.groups.map((group) => group.kind), [
        TripTimelineDayKind.today,
        TripTimelineDayKind.yesterday,
        TripTimelineDayKind.tripStart,
      ]);
      expect(view.groups.map((group) => group.entries.length), [5, 3, 1]);
      expect(view.groups.first.entries.first.id, 'event-memory-hai-van');
    });

    test('groups by the day of the user, not the UTC day', () {
      // 23:30 on the 21st in Vietnam, while it is already 01:00 on the 22nd.
      final events = stateOf([
        timelineEventJson(id: 'e-1', createdAt: '2025-07-21T16:30:00.000Z'),
      ]);

      TripTimelineDayKind kindIn(TripTimelineWallClock toWallClock) =>
          buildTripTimelineView(
            events: events,
            selected: TripTimelineFilter.all,
            now: timelineNow,
            toWallClock: toWallClock,
          ).groups.single.kind;

      expect(kindIn(utcWallClock), TripTimelineDayKind.today);
      expect(kindIn(vietnamWallClock), TripTimelineDayKind.yesterday);
    });

    test('labels a day without the trip start by its date', () {
      final view = buildTripTimelineView(
        events: stateOf([
          timelineEventJson(id: 'e-1', createdAt: '2025-07-10T08:00:00.000Z'),
        ]),
        selected: TripTimelineFilter.all,
        now: timelineNow,
        toWallClock: utcWallClock,
      );

      final group = view.groups.single;
      expect(group.kind, TripTimelineDayKind.other);
      expect(timelineDayLabel(group, now: timelineNow).title, '10 Tháng 7');
    });

    test('sorts newest first even if pages arrive out of order', () {
      final view = buildTripTimelineView(
        events: stateOf([
          timelineEventJson(id: 'old', createdAt: '2025-07-21T08:00:00.000Z'),
          timelineEventJson(id: 'new', createdAt: '2025-07-21T09:00:00.000Z'),
        ]),
        selected: TripTimelineFilter.all,
        now: timelineNow,
        toWallClock: utcWallClock,
      );

      expect(view.groups.single.entries.map((entry) => entry.id), [
        'new',
        'old',
      ]);
    });

    test('exposes the backend counts for every filter', () {
      final view = buildTripTimelineView(
        events: datamockState(),
        selected: TripTimelineFilter.all,
        now: timelineNow,
        toWallClock: utcWallClock,
      );

      expect(
        {
          for (final filter in TripTimelineFilter.values)
            filter: view.countOf(filter),
        },
        {
          TripTimelineFilter.all: 9,
          TripTimelineFilter.checkin: 2,
          TripTimelineFilter.expense: 2,
          TripTimelineFilter.memory: 1,
          TripTimelineFilter.member: 1,
        },
      );
    });

    test('hides the previous list while another filter loads', () {
      final view = buildTripTimelineView(
        events: datamockState(),
        selected: TripTimelineFilter.expense,
        now: timelineNow,
        toWallClock: utcWallClock,
      );

      expect(view.status, TripTimelineBodyStatus.switchingFilter);
      expect(view.filter, TripTimelineFilter.expense);
      expect(view.groups, isEmpty);
      expect(view.countOf(TripTimelineFilter.expense), 2);
    });

    test('reports a failed filter load', () {
      const error = ApiException(message: 'down', statusCode: 503);
      final view = buildTripTimelineView(
        events: datamockState(),
        selected: TripTimelineFilter.expense,
        now: timelineNow,
        toWallClock: utcWallClock,
        pendingError: error,
      );

      expect(view.status, TripTimelineBodyStatus.filterError);
      expect(view.filterError, error);
    });
  });

  group('TripTimelineFilter', () {
    test('maps every event type to the design categories', () {
      expect(
        TripTimelineFilter.memory.matches(TripTimelineEntryType.photoAdded),
        isTrue,
      );
      expect(
        TripTimelineFilter.member.matches(TripTimelineEntryType.memberKicked),
        isTrue,
      );
      expect(
        TripTimelineFilter.expense.matches(
          TripTimelineEntryType.expenseSettled,
        ),
        isTrue,
      );
      expect(
        TripTimelineFilter.checkin.matches(TripTimelineEntryType.activityAdded),
        isFalse,
      );
    });

    test('sends the backend category name, nothing for all', () {
      expect(TripTimelineFilter.all.apiCategory, isNull);
      expect(TripTimelineFilter.checkin.apiCategory, 'checkin');
      expect(TripTimelineFilter.member.apiCategory, 'member');
    });

    test('adding bumps all and the matching category only', () {
      const counts = TripTimelineCounts(all: 3, memory: 1);

      expect(
        counts.adding(TripTimelineEntryType.memoryAdded),
        const TripTimelineCounts(all: 4, memory: 2),
      );
      expect(
        counts.adding(TripTimelineEntryType.activityAdded),
        const TripTimelineCounts(all: 4, memory: 1),
      );
    });
  });

  group('timelineSentence', () {
    String sentenceOf(Map<String, dynamic> json) => timelineSentence(
      TripTimelineEntry.fromJson(json),
    ).map((part) => part.text).join();

    test('builds a check-in sentence from the metadata', () {
      final text = sentenceOf(
        timelineEventJson(
          id: 'e-1',
          type: 'ACTIVITY_CHECKIN',
          content: 'Đã check-in hoạt động',
          metadata: {'activityTitle': 'Đón bình minh', 'placeName': 'Bàn Cờ'},
        ),
      );

      expect(
        text,
        'Alex Nguyễn đã check-in hoạt động "Đón bình minh" tại Bàn Cờ.',
      );
    });

    test('names the payer when the debtor settles', () {
      final text = sentenceOf(
        timelineEventJson(
          id: 'e-1',
          type: 'EXPENSE_SETTLED',
          memberId: 'debtor',
          content: 'Đã thanh toán cho Trang',
          metadata: {
            'payerMemberId': 'payer',
            'payerName': 'Trang',
            'debtorMemberId': 'debtor',
            'debtorName': 'Alex Nguyễn',
          },
        ),
      );

      expect(text, 'Alex Nguyễn đã thanh toán cho Trang.');
    });

    test('names the debtor when the payer confirms', () {
      final text = sentenceOf(
        timelineEventJson(
          id: 'e-1',
          type: 'EXPENSE_SETTLED',
          memberId: 'payer',
          content: 'Đã xác nhận nhận tiền từ Phương',
          metadata: {
            'payerMemberId': 'payer',
            'payerName': 'Alex Nguyễn',
            'debtorMemberId': 'debtor',
            'debtorName': 'Phương',
          },
        ),
      );

      expect(text, 'Alex Nguyễn đã xác nhận nhận tiền từ Phương.');
    });

    test('uses the display name of a kicked member', () {
      final text = sentenceOf(
        timelineEventJson(
          id: 'e-1',
          type: 'MEMBER_KICKED',
          content: 'Đã xóa bao123 khỏi chuyến đi',
          metadata: {'targetMemberId': 'm-2', 'targetName': 'Quốc Bảo'},
        ),
      );

      expect(text, 'Alex Nguyễn đã xóa Quốc Bảo khỏi chuyến đi.');
    });

    test('falls back to the backend content without metadata', () {
      final text = sentenceOf(
        timelineEventJson(
          id: 'e-1',
          type: 'EXPENSE_SETTLED',
          content: 'Đã thanh toán cho Trang',
        ),
      );

      expect(text, 'Alex Nguyễn đã thanh toán cho Trang.');
    });
  });

  group('formatters', () {
    test('timelineSentenceTail lower-cases sentence case only', () {
      expect(
        timelineSentenceTail('Đã thêm một kỷ niệm'),
        'đã thêm một kỷ niệm',
      );
      expect(
        timelineSentenceTail('TRIP-VN2025 được tạo'),
        'TRIP-VN2025 được tạo',
      );
      expect(timelineSentenceTail('A'), 'A');
      expect(timelineSentenceTail('  '), '');
    });

    test('formatCoordinates uses hemispheres', () {
      expect(formatCoordinates(16.1182, 108.2789), '16.1182° N, 108.2789° E');
      expect(formatCoordinates(-33.86, -70.5), '33.8600° S, 70.5000° W');
    });

    test('formatTimelineClock reads the wall clock as given', () {
      final instant = DateTime.utc(2026, 10, 12, 2, 50);

      expect(formatTimelineClock(utcWallClock(instant)), '02:50');
      expect(formatTimelineClock(vietnamWallClock(instant)), '09:50');
    });

    test('formatTimelineDate adds the year only for another year', () {
      expect(
        formatTimelineDate(DateTime.utc(2025, 7, 15), now: timelineNow),
        '15 Tháng 7',
      );
      expect(
        formatTimelineDate(DateTime.utc(2024, 12, 31), now: timelineNow),
        '31 Tháng 12, 2024',
      );
    });

    test('timelineJoinLabel never shows an invite code', () {
      expect(
        timelineJoinLabel(TripTimelineJoinVia.inviteCode),
        'Tham gia qua mã mời',
      );
      expect(
        timelineJoinLabel(TripTimelineJoinVia.invitation),
        'Tham gia qua lời mời',
      );
      expect(
        timelineJoinLabel(TripTimelineJoinVia.joinRequest),
        'Tham gia qua yêu cầu được duyệt',
      );
      expect(
        TripTimelineEntryMetadata.fromJson(const {'via': 'JOIN_REQUEST'}).via,
        TripTimelineJoinVia.joinRequest,
      );
      expect(timelineJoinLabel(null), isNull);
    });

    test('error messages never expose server details', () {
      const serverError = ApiException(
        message: 'PrismaClientKnownRequestError at line 42',
        statusCode: 500,
      );
      expect(
        tripTimelineErrorMessage(serverError),
        'Không thể tải dòng thời gian. Vui lòng thử lại.',
      );
      expect(
        isTripTimelineForbidden(
          const ApiException(message: 'Forbidden', statusCode: 403),
        ),
        isTrue,
      );
      expect(
        tripTimelineErrorMessage(StateError('boom')),
        'Đã xảy ra lỗi. Vui lòng thử lại.',
      );
    });
  });
}
