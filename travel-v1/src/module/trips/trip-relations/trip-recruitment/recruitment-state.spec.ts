import { RECRUITMENT_STATE, TRIP_STATUS } from '../../../../generated/prisma/enums';
import { reconcileRecruitmentState } from './recruitment-state';

function harness(options: {
  state: RECRUITMENT_STATE;
  status?: TRIP_STATUS;
  expiresAt?: Date;
  activeMembers: number;
  maxMembers: number;
}) {
  const updated: Array<Record<string, unknown>> = [];
  const tx = {
    tripRecruitment: {
      findUnique: jest.fn().mockResolvedValue({
        state: options.state,
        expiresAt: options.expiresAt ?? new Date('2099-01-01T00:00:00.000Z'),
        trip: {
          status: options.status ?? TRIP_STATUS.UPCOMING,
          maxMembers: options.maxMembers,
        },
      }),
      update: jest.fn((args: { data: Record<string, unknown> }) => {
        updated.push(args.data);
        return Promise.resolve(args.data);
      }),
    },
    tripMember: {
      count: jest.fn().mockResolvedValue(options.activeMembers),
    },
  };
  return { tx, updated };
}

describe('reconcileRecruitmentState', () => {
  const now = new Date('2026-10-23T00:00:00.000Z');

  it('turns OPEN into FULL when maxMembers drops to the active count', async () => {
    const { tx, updated } = harness({
      state: RECRUITMENT_STATE.OPEN,
      activeMembers: 4,
      maxMembers: 4,
    });

    await expect(
      reconcileRecruitmentState(tx as never, 'trip-1', now),
    ).resolves.toBe(RECRUITMENT_STATE.FULL);
    expect(updated).toEqual([{ state: RECRUITMENT_STATE.FULL }]);
  });

  it('does not reopen a closed or cancelled post', async () => {
    const closed = harness({
      state: RECRUITMENT_STATE.CLOSED,
      activeMembers: 1,
      maxMembers: 4,
    });
    await expect(
      reconcileRecruitmentState(closed.tx as never, 'trip-1', now),
    ).resolves.toBe(RECRUITMENT_STATE.CLOSED);
    expect(closed.updated).toEqual([]);

    const cancelled = harness({
      state: RECRUITMENT_STATE.OPEN,
      status: TRIP_STATUS.CANCELLED,
      activeMembers: 1,
      maxMembers: 4,
    });
    await expect(
      reconcileRecruitmentState(cancelled.tx as never, 'trip-1', now),
    ).resolves.toBe(RECRUITMENT_STATE.OPEN);
    expect(cancelled.updated).toEqual([]);
  });
});
