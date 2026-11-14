// Dữ liệu mẫu cho màn Mời Bạn Đồng Hành.
//
// API thật:
// - `GET /trips/recommend-friends/{tripId}` → `{ data, tripTravelPersona, message }`
//   (`TripsController.recommendFriendsToTrip`). Bạn bè chưa là thành viên ACTIVE,
//   kèm `tripsTogetherCount`, `invitationStatus`, `travelPersona`, `matchScore`,
//   `lastInteractionAt`. `tripTravelPersona` là DNA chuyến nghiêng về.
// - `GET /users/search?q&page&limit` → `{ data: UserSearchResult[], meta }`.
// - `POST /trip-invitations/invite` body `{ tripId, inviteeId }`
//   → `{ data: TripInvitation, message }`.
//
// App gọi API thật. Datamock chỉ dùng cho test.

const tripInviteFriendsDatamockNow = '2026-10-25T08:00:00.000Z';

const Map<String, dynamic> tripInviteFriendsDatamock = {
  'recommendations': {
    'data': [
      {
        'user': {
          'id': 'user-minh-anh',
          'username': 'minhanh.wander',
          'displayname': 'Minh Anh',
          'avatarId': null,
        },
        'tripsTogetherCount': 2,
        'invitationStatus': null,
        'travelPersona': 'Beach Lover 🏖️',
        'matchScore': 94,
        'lastInteractionAt': '2026-10-20T08:00:00.000Z',
      },
      {
        'user': {
          'id': 'user-hoang-long',
          'username': 'long_traveler',
          'displayname': 'Hoàng Long',
          'avatarId': null,
        },
        'tripsTogetherCount': 3,
        'invitationStatus': null,
        'travelPersona': 'Foodie Traveler 🍜',
        'matchScore': 40,
        'lastInteractionAt': '2026-01-02T08:00:00.000Z',
      },
      {
        'user': {
          'id': 'user-thanh-hang',
          'username': 'hang.journey',
          'displayname': 'Thanh Hằng',
          'avatarId': null,
        },
        'tripsTogetherCount': 1,
        'invitationStatus': 'PENDING',
        'travelPersona': 'Beach Lover 🏖️',
        'matchScore': 80,
        'lastInteractionAt': '2026-10-22T08:00:00.000Z',
      },
      {
        'user': {
          'id': 'user-duc-huy',
          'username': 'duchuy_trek',
          'displayname': 'Đức Huy',
          'avatarId': null,
        },
        'tripsTogetherCount': 0,
        'invitationStatus': null,
        'travelPersona': null,
        'matchScore': null,
        'lastInteractionAt': '2026-10-10T08:00:00.000Z',
      },
      {
        'user': {
          'id': 'user-khanh-vy',
          'username': 'khanhvy.travel',
          'displayname': 'Khánh Vy',
          'avatarId': null,
        },
        'tripsTogetherCount': 0,
        'invitationStatus': null,
        'travelPersona': null,
        'matchScore': null,
        'lastInteractionAt': '2025-06-01T08:00:00.000Z',
      },
    ],
    'tripTravelPersona': 'Beach Lover 🏖️',
    'message': 'Recommended friends retrieved successfully',
  },
  'search': {
    'data': [
      {
        'id': 'user-duc-huy',
        'username': 'duchuy_trek',
        'displayname': 'Đức Huy',
        'avatarId': null,
      },
      {
        'id': 'user-bao-nam',
        'username': 'baonam_photo',
        'displayname': 'Bảo Nam',
        'avatarId': null,
      },
    ],
    'meta': {
      'page': 1,
      'limit': 20,
      'total': 2,
      'totalPages': 1,
      'hasNextPage': false,
      'hasPreviousPage': false,
    },
  },
  'invitation': {
    'data': {
      'id': 'invitation-1',
      'tripId': 'trip-1',
      'inviterId': 'user-alex',
      'inviteeId': 'user-duc-huy',
      'status': 'PENDING',
      'createdAt': '2025-07-10T08:00:00.000Z',
      'updatedAt': '2025-07-10T08:00:00.000Z',
    },
    'message': 'Trip invitation sent successfully',
  },
};
