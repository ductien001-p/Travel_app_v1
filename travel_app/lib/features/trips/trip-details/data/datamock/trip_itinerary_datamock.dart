/// Full data needed by the "Lịch trình chi tiết" screen, in the exact shape
/// returned by each endpoint. Used as fixture data for tests and previews.
///
/// - `trip`: header and check-in permission, from `GET /trips/{id}`.
/// - `itinerary`: envelope of `GET /trips/{id}/itineraries`.
/// - `viewerCheckins`: envelope of `GET /trips/{id}/itineraries/checkins/me`.
/// - `dayRoute`: envelope of `GET /trips/{id}/itineraries/days/day-2/route`.
final Map<String, dynamic> tripItineraryDatamock = {
  'trip': {
    'id': _tripId,
    'name': 'Mùa hè rực rỡ xuyên miền Trung',
    'status': 'ONGOING',
    'startDate': '2026-07-15T00:00:00.000Z',
    'endDate': '2026-07-20T00:00:00.000Z',
    'viewer': {'userId': 'user-alex', 'role': 'OWNER'},
  },
  'itinerary': {
    'success': true,
    'data': [
      {
        'id': 'destination-danang',
        'tripId': _tripId,
        'city': 'Đà Nẵng',
        'country': 'Việt Nam',
        'lat': 16.0544,
        'lng': 108.2022,
        'order': 1,
        'startDate': '2026-07-15T00:00:00.000Z',
        'endDate': '2026-07-18T00:00:00.000Z',
        'destinationId': 'catalog-danang',
        'destinationType': 'CITY',
        'highlights': <String>[],
        'coverImageUrl': null,
        'itineraryDays': [
          _day('day-1', 'destination-danang', 1, '2026-07-15', [
            _activity(
              id: 'activity-son-tra-sunrise',
              dayId: 'day-1',
              title: 'Ngắm bình minh trên đỉnh Bàn Cờ',
              startTime: '2026-07-15T05:00:00.000Z',
              duration: 90,
              cost: 0,
              orderIndex: 1000,
              isCheckin: true,
              place: _place(
                'place-ban-co',
                'Đỉnh Bàn Cờ',
                'ATTRACTION',
                'Bán đảo Sơn Trà, Đà Nẵng',
                16.1206,
                108.2766,
              ),
            ),
            _activity(
              id: 'activity-han-market',
              dayId: 'day-1',
              title: 'Dạo chợ Hàn',
              startTime: '2026-07-15T09:00:00.000Z',
              duration: 120,
              cost: 200000,
              orderIndex: 2000,
              isCheckin: true,
              place: _place(
                'place-han-market',
                'Chợ Hàn',
                'SHOPPING',
                '119 Trần Phú, Hải Châu, Đà Nẵng',
                16.0679,
                108.2242,
              ),
            ),
          ]),
          _day('day-2', 'destination-danang', 2, '2026-07-16', [
            _activity(
              id: 'activity-my-khe',
              dayId: 'day-2',
              title: 'Đón bình minh & Tắm biển Mỹ Khê',
              startTime: '2026-07-16T08:30:00.000Z',
              duration: 120,
              cost: 0,
              orderIndex: 1000,
              isCheckin: false,
              place: _place(
                'place-my-khe',
                'Biển Mỹ Khê',
                'BEACH',
                'Võ Nguyên Giáp, Phước Mỹ, Sơn Trà',
                16.0610,
                108.2470,
                imageUrl: 'https://cdn.travel.test/places/my-khe.jpg',
              ),
            ),
            _activity(
              id: 'activity-mi-quang',
              dayId: 'day-2',
              title: 'Thưởng thức Mì Quảng Bà Mua & Cà phê trứng',
              startTime: '2026-07-16T11:30:00.000Z',
              duration: 90,
              cost: 180000,
              orderIndex: 2000,
              isCheckin: false,
              place: _place(
                'place-mi-quang-ba-mua',
                'Mì Quảng Bà Mua',
                'RESTAURANT',
                '19 Trần Bình Trọng, Hải Châu, Đà Nẵng',
                16.0712,
                108.2190,
              ),
            ),
            _activity(
              id: 'activity-linh-ung',
              dayId: 'day-2',
              title: 'Bán đảo Sơn Trà & Viếng Chùa Linh Ứng',
              startTime: '2026-07-16T15:00:00.000Z',
              duration: 150,
              cost: 0,
              orderIndex: 3000,
              isCheckin: false,
              place: _place(
                'place-linh-ung',
                'Chùa Linh Ứng',
                'ATTRACTION',
                'Bãi Bụt, Bán đảo Sơn Trà, TP. Đà Nẵng',
                16.1003,
                108.2779,
                imageUrl: 'https://cdn.travel.test/places/linh-ung.jpg',
              ),
            ),
            _activity(
              id: 'activity-dragon-bridge',
              dayId: 'day-2',
              title: 'Ngắm Cầu Rồng phun lửa & Du thuyền sông Hàn',
              startTime: '2026-07-16T18:30:00.000Z',
              duration: 90,
              cost: 250000,
              orderIndex: 4000,
              isCheckin: false,
              place: _place(
                'place-dragon-bridge',
                'Cầu Rồng',
                'CRUISE',
                'Nguyễn Văn Linh, An Hải Trung, Sơn Trà',
                16.0610,
                108.2272,
              ),
            ),
          ]),
          _day('day-3', 'destination-danang', 3, '2026-07-17', [
            _activity(
              id: 'activity-ba-na',
              dayId: 'day-3',
              title: 'Khám phá Bà Nà Hills & Cầu Vàng',
              startTime: '2026-07-17T07:30:00.000Z',
              duration: 360,
              cost: 900000,
              orderIndex: 1000,
              isCheckin: false,
              place: _place(
                'place-ba-na',
                'Bà Nà Hills',
                'ATTRACTION',
                'Hòa Ninh, Hòa Vang, Đà Nẵng',
                15.9977,
                107.9881,
              ),
            ),
          ]),
          _day('day-4', 'destination-danang', 4, '2026-07-18', const []),
        ],
      },
      {
        'id': 'destination-hoian',
        'tripId': _tripId,
        'city': 'Hội An',
        'country': 'Việt Nam',
        'lat': 15.8801,
        'lng': 108.3380,
        'order': 2,
        'startDate': '2026-07-18T00:00:00.000Z',
        'endDate': '2026-07-20T00:00:00.000Z',
        'destinationId': 'catalog-hoian',
        'destinationType': 'CITY',
        'highlights': <String>[],
        'coverImageUrl': null,
        'itineraryDays': [
          _day('day-5', 'destination-hoian', 5, '2026-07-19', [
            _activity(
              id: 'activity-old-town',
              dayId: 'day-5',
              title: 'Dạo phố cổ & Thả đèn hoa đăng',
              startTime: '2026-07-19T17:00:00.000Z',
              duration: 180,
              cost: 120000,
              orderIndex: 1000,
              isCheckin: false,
              place: _place(
                'place-hoian-old-town',
                'Phố cổ Hội An',
                'ATTRACTION',
                'Minh An, Hội An, Quảng Nam',
                15.8772,
                108.3280,
              ),
            ),
          ]),
        ],
      },
    ],
    'permissions': {'canManageItinerary': true},
  },
  'viewerCheckins': {
    'success': true,
    'data': [
      _checkin('activity-son-tra-sunrise', 'place-ban-co', '05:20', '15'),
      _checkin('activity-han-market', 'place-han-market', '09:40', '15'),
      _checkin('activity-my-khe', 'place-my-khe', '08:45', '16'),
      _checkin('activity-mi-quang', 'place-mi-quang-ba-mua', '11:50', '16'),
    ],
  },
  'dayRoute': {
    'data': {
      'dayId': 'day-2',
      'available': true,
      'totalDistanceMeters': 21400,
      'totalDurationSeconds': 3240,
      'legs': [
        _leg(
          'activity-my-khe',
          'activity-mi-quang',
          4200,
          720,
          'g|_aBw~tsSg^nvAo_@nvA',
        ),
        _leg(
          'activity-mi-quang',
          'activity-linh-ung',
          9800,
          1440,
          '_|aaBwoosSguAoaDs~AslE',
        ),
        _leg(
          'activity-linh-ung',
          'activity-dragon-bridge',
          7400,
          1080,
          '{qgaB{_{sSz}Bz`DvuB~yC',
        ),
      ],
    },
    'message': 'Day route retrieved successfully',
  },
};

Map<String, dynamic> _leg(
  String fromActivityId,
  String toActivityId,
  int distanceMeters,
  int durationSeconds,
  String polyline,
) => {
  'fromActivityId': fromActivityId,
  'toActivityId': toActivityId,
  'available': true,
  'distanceMeters': distanceMeters,
  'durationSeconds': durationSeconds,
  'polyline': polyline,
  'unavailableReason': null,
};

const _tripId = 'trip-1';
const _timestamp = '2026-07-01T00:00:00.000Z';

Map<String, dynamic> _day(
  String id,
  String destinationId,
  int dayNumber,
  String date,
  List<Map<String, dynamic>> activities,
) => {
  'id': id,
  'tripId': _tripId,
  'destinationId': destinationId,
  'dayNumber': dayNumber,
  'date': '${date}T00:00:00.000Z',
  'activities': activities,
};

Map<String, dynamic> _activity({
  required String id,
  required String dayId,
  required String title,
  required String startTime,
  required int duration,
  required int cost,
  required int orderIndex,
  required bool isCheckin,
  required Map<String, dynamic> place,
}) => {
  'id': id,
  'tripId': _tripId,
  'dayId': dayId,
  'placeId': place['id'],
  'title': title,
  'startTime': startTime,
  'estimatedCost': cost,
  'estimatedDuration': duration,
  'isCheckin': isCheckin,
  'orderIndex': orderIndex,
  'place': place,
  'createdAt': _timestamp,
  'updatedAt': _timestamp,
};

Map<String, dynamic> _place(
  String id,
  String name,
  String category,
  String address,
  double latitude,
  double longitude, {
  String? imageUrl,
}) => {
  'id': id,
  'name': name,
  'category': category,
  'city': null,
  'country': 'Việt Nam',
  'address': address,
  'latitude': latitude,
  'longitude': longitude,
  'imageUrl': imageUrl,
};

Map<String, dynamic> _checkin(
  String activityId,
  String placeId,
  String clock,
  String julyDay,
) => {
  'activityId': activityId,
  'placeId': placeId,
  'visitedAt': '2026-07-${julyDay}T$clock:00.000Z',
};
