import { TRIP_MESSAGE_TYPE, TRIP_ROLE } from '../../../../generated/prisma/enums';
import {
  aggregateReactions,
  buildMemberSummaryLabel,
  formatDateLabel,
  formatTimeLabel,
  mapMessageTypeToUiKind,
  mapPinnedActivity,
  mapTripRoleToSenderBadge,
  resolveReadStatus,
} from './trip-chat-thread.mapper';

describe('trip-chat-thread.mapper', () => {
  it('maps trip roles to UI sender badges', () => {
    expect(mapTripRoleToSenderBadge(TRIP_ROLE.OWNER)).toEqual({
      roleBadge: 'Trưởng nhóm',
      roleTone: 'LEADER',
      isLeader: true,
    });
    expect(mapTripRoleToSenderBadge(TRIP_ROLE.ADMIN).roleBadge).toBe('Admin');
    expect(mapTripRoleToSenderBadge(TRIP_ROLE.MEMBER).isLeader).toBe(false);
  });

  it('maps DB message types to UI kinds', () => {
    expect(mapMessageTypeToUiKind(TRIP_MESSAGE_TYPE.IMAGE)).toBe('PHOTO');
    expect(mapMessageTypeToUiKind(TRIP_MESSAGE_TYPE.EXPENSE)).toBe('EXPENSE');
    expect(mapMessageTypeToUiKind(TRIP_MESSAGE_TYPE.SYSTEM)).toBe('SYSTEM');
    expect(mapMessageTypeToUiKind(TRIP_MESSAGE_TYPE.TEXT)).toBe('TEXT');
  });

  it('formats time and date labels', () => {
    const date = new Date(2025, 6, 19, 14, 5);
    expect(formatTimeLabel(date)).toBe('14:05');
    expect(formatDateLabel(date, new Date(2025, 6, 19, 18, 0))).toContain(
      'Hôm nay',
    );
  });

  it('builds member summary and pinned activity', () => {
    expect(
      buildMemberSummaryLabel({
        memberCount: 4,
        onlineNames: ['Alex', 'Trang', 'Bảo'],
      }),
    ).toContain('3 đang online');

    const pinned = mapPinnedActivity({
      id: 'act-1',
      title: 'Cầu Rồng',
      startTime: new Date(),
    });
    expect(pinned?.badgeLabel).toBe('Hoạt động tiếp theo');
    expect(pinned?.checkInLabel).toBe('Check-in');
  });

  it('resolves read status for own messages', () => {
    const createdAt = new Date('2025-07-19T10:00:00.000Z');
    expect(
      resolveReadStatus({
        isMine: true,
        createdAt,
        otherMembersLastReadAt: [new Date('2025-07-19T11:00:00.000Z')],
      }),
    ).toBe('READ');
    expect(
      resolveReadStatus({
        isMine: true,
        createdAt,
        otherMembersLastReadAt: [null],
      }),
    ).toBe('DELIVERED');
    expect(
      resolveReadStatus({
        isMine: false,
        createdAt,
        otherMembersLastReadAt: [],
      }),
    ).toBeNull();
  });

  it('aggregates reactions', () => {
    expect(
      aggregateReactions([{ emoji: '❤️' }, { emoji: '❤️' }, { emoji: '🔥' }]),
    ).toEqual([
      { emoji: '❤️', count: 2 },
      { emoji: '🔥', count: 1 },
    ]);
  });
});
