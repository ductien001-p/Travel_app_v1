import * as fs from 'fs';
import * as path from 'path';
import { TRIP_VISIBILITY } from '../../../../generated/prisma/enums';
import {
  deleteAbandonedWizardDrafts,
  expireRecruitments,
} from './trip-recruitment.cron';
import { legacyRecruitmentNotificationWhere } from './notify-legacy-recruitment';
import { notifyLegacyRecruitmentGaps } from './notify-legacy-recruitment';

describe('recruitment backfill SQL', () => {
  const sql = fs.readFileSync(
    path.join(
      __dirname,
      '../../../../../prisma/migrations/20261023150100_trip_recruitment_backfill/migration.sql',
    ),
    'utf8',
  );
  const [openInsert, unpublishedInsert] = sql.split('INSERT INTO').slice(1);

  it('marks a full legacy trip FULL and keeps previousVisibility PUBLIC', () => {
    expect(openInsert).toContain(
      'WHEN active.member_count >= t."maxMembers" THEN \'FULL\'',
    );
    expect(openInsert).toContain('\'PUBLIC\'::"TRIP_VISIBILITY"');
    expect(openInsert).toContain("INTERVAL '24 hours'");
    expect(openInsert).not.toContain("INTERVAL '48 hours'");
    expect(openInsert).toContain('NOT EXISTS');
  });

  it('does not notify trips that only fail the 48 hour window', () => {
    expect(unpublishedInsert).toContain("INTERVAL '48 hours'");
    expect(unpublishedInsert).toContain("'NOT_PUBLISHED'");
    expect(unpublishedInsert).toContain('NOT EXISTS');
  });
});

describe('expireRecruitments', () => {
  it('restores PRIVATE and notifies pending requests only after the row updates', async () => {
    const notifications: unknown[] = [];
    const tx = {
      tripRecruitment: {
        findMany: jest.fn().mockResolvedValue([
          {
            tripId: 'trip-1',
            previousVisibility: TRIP_VISIBILITY.PRIVATE,
            trip: { name: 'Da Nang', ownerId: 'owner-1' },
          },
        ]),
        updateMany: jest.fn().mockResolvedValue({ count: 1 }),
      },
      trip: { update: jest.fn().mockResolvedValue({}) },
      tripJoinRequest: {
        findMany: jest.fn().mockResolvedValue([{ requesterId: 'guest-1' }]),
      },
      notification: {
        createMany: jest.fn((args: { data: unknown[] }) => {
          notifications.push(...args.data);
          return Promise.resolve({ count: args.data.length });
        }),
      },
    };

    await expect(
      expireRecruitments(tx as never, new Date('2026-10-23T00:00:00.000Z')),
    ).resolves.toBe(1);
    expect(tx.trip.update).toHaveBeenCalledWith({
      where: { id: 'trip-1' },
      data: { visibility: TRIP_VISIBILITY.PRIVATE },
    });
    expect(tx.tripRecruitment.updateMany).toHaveBeenCalledWith(
      expect.objectContaining({
        data: { state: 'CLOSED', previousVisibility: null },
      }),
    );
    expect(notifications).toHaveLength(1);
  });
});

describe('deleteAbandonedWizardDrafts', () => {
  it('only targets publish-wizard drafts that have no itinerary', async () => {
    const tx = {
      trip: {
        deleteMany: jest.fn().mockResolvedValue({ count: 0 }),
      },
    };
    await deleteAbandonedWizardDrafts(
      tx as never,
      new Date('2026-10-23T00:00:00.000Z'),
    );
    expect(tx.trip.deleteMany).toHaveBeenCalledWith({
      where: {
        status: 'DRAFT',
        updatedAt: { lt: expect.any(Date) },
        recruitment: { is: { origin: 'PUBLISH_WIZARD' } },
        itineraryItems: { none: {} },
      },
    });
  });
});

describe('notifyLegacyRecruitmentGaps', () => {
  it('sends only the legacy unpublished filter', async () => {
    const created: Array<{ userId: string }> = [];
    const prisma = {
      tripRecruitment: {
        findMany: jest.fn().mockResolvedValue([
          {
            tripId: 'legacy-1',
            trip: { ownerId: 'owner-1', name: 'Hue' },
          },
        ]),
        update: jest.fn().mockResolvedValue({}),
      },
      notification: {
        create: jest.fn((args: { data: { userId: string } }) => {
          created.push(args.data);
          return Promise.resolve({});
        }),
      },
    };

    await expect(notifyLegacyRecruitmentGaps(prisma)).resolves.toBe(1);
    expect(prisma.tripRecruitment.findMany).toHaveBeenCalledWith(
      expect.objectContaining({ where: legacyRecruitmentNotificationWhere }),
    );
    expect(legacyRecruitmentNotificationWhere).toEqual({
      origin: 'LEGACY_BACKFILL',
      state: 'NOT_PUBLISHED',
      notifiedAt: null,
    });
    expect(created).toEqual([expect.objectContaining({ userId: 'owner-1' })]);
  });
});
