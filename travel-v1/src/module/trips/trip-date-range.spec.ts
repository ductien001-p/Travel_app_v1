import * as fs from 'fs';
import * as path from 'path';
import { BadRequestException } from '@nestjs/common';
import { TRIP_STATUS } from '../../generated/prisma/enums';
import { applyTripDateRange } from './trip-date-range';

const NOW = new Date('2026-10-23T00:00:00.000Z');
const FAR = new Date('2026-12-01T00:00:00.000Z');
const FAR_END = new Date('2026-12-03T00:00:00.000Z');
const SOON = new Date('2026-10-24T00:00:00.000Z');

function txFor(state: 'OPEN' | 'CLOSED' | null) {
  const updates: Array<Record<string, unknown>> = [];
  const tx = {
    tripRecruitment: {
      findUnique: jest.fn().mockResolvedValue(
        state
          ? {
              state,
              expiresAt: new Date('2026-11-30T00:00:00.000Z'),
            }
          : null,
      ),
      update: jest.fn().mockResolvedValue({}),
    },
    trip: {
      update: jest.fn((args: { data: Record<string, unknown> }) => {
        updates.push(args.data);
        return Promise.resolve(args.data);
      }),
    },
    tripMember: { findMany: jest.fn().mockResolvedValue([]) },
    tripJoinRequest: { findMany: jest.fn().mockResolvedValue([]) },
    notification: { createMany: jest.fn().mockResolvedValue({ count: 0 }) },
  };
  return { tx, updates };
}

const trip = {
  id: 'trip-1',
  name: 'Da Nang',
  status: TRIP_STATUS.UPCOMING,
  startDate: FAR,
  endDate: FAR_END,
  ownerId: 'owner-1',
};

describe('applyTripDateRange', () => {
  it('requires acknowledgement before moving an open recruitment', async () => {
    const { tx, updates } = txFor('OPEN');
    await expect(
      applyTripDateRange(tx as never, {
        trip,
        previousDestinations: [{ id: 'd1', startDate: FAR, endDate: FAR_END }],
        nextDestinations: [{ id: 'd1', startDate: SOON, endDate: SOON }],
        actorId: 'owner-1',
        now: NOW,
      }),
    ).rejects.toMatchObject({
      response: { code: 'RECRUITMENT_IMPACT_ACK_REQUIRED' },
    });
    expect(updates).toEqual([]);
  });

  it('rejects a confirmed move that starts within 48 hours while open', async () => {
    const { tx } = txFor('OPEN');
    await expect(
      applyTripDateRange(tx as never, {
        trip,
        previousDestinations: [{ id: 'd1', startDate: FAR, endDate: FAR_END }],
        nextDestinations: [{ id: 'd1', startDate: SOON, endDate: SOON }],
        acknowledgeRecruitmentImpact: true,
        actorId: 'owner-1',
        now: NOW,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('allows a closed post to move close to departure', async () => {
    const { tx, updates } = txFor('CLOSED');
    await applyTripDateRange(tx as never, {
      trip,
      previousDestinations: [{ id: 'd1', startDate: FAR, endDate: FAR_END }],
      nextDestinations: [{ id: 'd1', startDate: SOON, endDate: SOON }],
      actorId: 'owner-1',
      now: NOW,
    });
    expect(updates).toEqual([
      { startDate: SOON, endDate: SOON },
    ]);
    expect(tx.tripRecruitment.update).not.toHaveBeenCalled();
  });
});

function tripUpdateBlocks(text: string): string[] {
  const blocks: string[] = [];
  const marker = /\.trip\.update(?:Many)?\(/g;
  let match: RegExpExecArray | null;
  while ((match = marker.exec(text))) {
    const open = text.indexOf('(', match.index);
    let depth = 0;
    for (let index = open; index < text.length; index += 1) {
      const char = text[index];
      if (char === '(') depth += 1;
      if (char === ')') {
        depth -= 1;
        if (depth === 0) {
          blocks.push(text.slice(match.index, index + 1));
          break;
        }
      }
    }
  }
  return blocks;
}

describe('trip startDate writers', () => {
  it('only applyTripDateRange assigns startDate on trip.update', () => {
    const root = path.join(__dirname);
    const offenders: string[] = [];
    const visit = (dir: string) => {
      for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const full = path.join(dir, entry.name);
        if (entry.isDirectory()) {
          visit(full);
          continue;
        }
        if (!entry.name.endsWith('.ts') || entry.name.endsWith('.spec.ts')) {
          continue;
        }
        if (entry.name === 'trip-date-range.ts') continue;
        const text = fs.readFileSync(full, 'utf8');
        for (const block of tripUpdateBlocks(text)) {
          if (/startDate\s*:/.test(block)) {
            offenders.push(path.relative(root, full));
            break;
          }
        }
      }
    };
    visit(root);
    expect(offenders).toEqual([]);
  });
});
