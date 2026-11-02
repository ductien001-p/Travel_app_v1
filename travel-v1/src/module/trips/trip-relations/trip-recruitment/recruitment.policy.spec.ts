import {
  RECRUITMENT_STATE,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../../../generated/prisma/enums';
import {
  activeRecruitmentWhere,
  effectiveRecruitmentState,
  hasPublishLeadTime,
  isActiveRecruitment,
  isEffectiveOpen,
  recruitmentBlockers,
  recruitmentExpiresAt,
  snapshotPreviousVisibility,
} from './recruitment.policy';

const NOW = new Date('2026-10-23T00:00:00.000Z');
const START_IN_30H = new Date('2026-10-24T06:00:00.000Z');
const START_IN_72H = new Date('2026-10-26T00:00:00.000Z');

describe('recruitment visibility helpers', () => {
  it('keeps a missing row and NOT_PUBLISHED unchanged', () => {
    expect(effectiveRecruitmentState(null, NOW)).toBe(
      RECRUITMENT_STATE.NOT_PUBLISHED,
    );
    expect(
      effectiveRecruitmentState(
        { state: RECRUITMENT_STATE.NOT_PUBLISHED, expiresAt: null },
        NOW,
      ),
    ).toBe(RECRUITMENT_STATE.NOT_PUBLISHED);
  });

  it('reports an expired OPEN post as CLOSED without writing', () => {
    expect(
      effectiveRecruitmentState(
        {
          state: RECRUITMENT_STATE.OPEN,
          expiresAt: new Date('2026-10-22T00:00:00.000Z'),
        },
        NOW,
      ),
    ).toBe(RECRUITMENT_STATE.CLOSED);
  });

  it('keeps a 24–48 hour post on the feed while blocking a new publish', () => {
    const expiresAt = recruitmentExpiresAt(START_IN_30H);
    expect(expiresAt.getTime()).toBeGreaterThan(NOW.getTime());
    expect(
      isEffectiveOpen(
        { state: RECRUITMENT_STATE.OPEN, expiresAt },
        TRIP_STATUS.UPCOMING,
        NOW,
      ),
    ).toBe(true);
    expect(hasPublishLeadTime(START_IN_30H, NOW)).toBe(false);
    expect(hasPublishLeadTime(START_IN_72H, NOW)).toBe(true);
  });

  it('drops CANCELLED trips from both helpers', () => {
    const row = {
      state: RECRUITMENT_STATE.OPEN,
      expiresAt: recruitmentExpiresAt(START_IN_72H),
    };
    expect(isEffectiveOpen(row, TRIP_STATUS.CANCELLED, NOW)).toBe(false);
    expect(isActiveRecruitment(row, TRIP_STATUS.CANCELLED, NOW)).toBe(false);
    expect(isActiveRecruitment(
      { state: RECRUITMENT_STATE.FULL, expiresAt: row.expiresAt },
      TRIP_STATUS.UPCOMING,
      NOW,
    )).toBe(true);
  });

  it('counts only upcoming unexpired OPEN or FULL posts for one owner', () => {
    expect(activeRecruitmentWhere('owner-1', NOW, 'trip-self')).toEqual({
      state: { in: [RECRUITMENT_STATE.OPEN, RECRUITMENT_STATE.FULL] },
      expiresAt: { gt: NOW },
      trip: { ownerId: 'owner-1', status: TRIP_STATUS.UPCOMING },
      tripId: { not: 'trip-self' },
    });
  });

  it('snapshots visibility once per active cycle and leaves a stored value', () => {
    expect(
      snapshotPreviousVisibility(null, TRIP_VISIBILITY.PRIVATE),
    ).toEqual({ previousVisibility: TRIP_VISIBILITY.PRIVATE });
    expect(
      snapshotPreviousVisibility(
        TRIP_VISIBILITY.PUBLIC,
        TRIP_VISIBILITY.PRIVATE,
      ),
    ).toEqual({});
  });

  it('lists every publish blocker, including a full group', () => {
    expect(
      recruitmentBlockers({
        startDate: START_IN_30H,
        activeRecruitmentCount: 3,
        activeMemberCount: 4,
        maxMembers: 4,
        description: 'short',
        hasCover: false,
        now: NOW,
      }),
    ).toEqual([
      'START_TOO_SOON',
      'ACTIVE_LIMIT_REACHED',
      'NO_OPEN_SLOT',
      'DESCRIPTION_TOO_SHORT',
      'COVER_REQUIRED',
    ]);
  });
});
