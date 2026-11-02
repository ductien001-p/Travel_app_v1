import {
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
jest.mock('nanoid', () => ({
  customAlphabet: () => () => 'NEWCODE1',
}));

import { TripMembersService } from './trip-member.service';

type Member = {
  id?: string;
  userId: string;
  role: string;
  status: string;
  user?: { username: string; displayname?: string };
} | null;

function setup(options: {
  trip?: Record<string, unknown> | null;
  members?: Record<string, Member>;
  activeMemberCount?: number;
}) {
  const members = options.members ?? {};
  const tx = {
    $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
    trip: {
      findUnique: jest
        .fn()
        .mockResolvedValue(
          options.trip === undefined
            ? { id: 'trip-1', status: 'UPCOMING', maxMembers: 5 }
            : options.trip,
        ),
      update: jest.fn((args: { data: Record<string, unknown> }) =>
        Promise.resolve({ id: 'trip-1', ...args.data }),
      ),
    },
    tripRecruitment: {
      findUnique: jest.fn().mockResolvedValue(null),
    },
    tripMember: {
      findUnique: jest.fn(
        ({ where }: { where: { tripId_userId: { userId: string } } }) =>
          Promise.resolve(members[where.tripId_userId.userId] ?? null),
      ),
      count: jest.fn().mockResolvedValue(options.activeMemberCount ?? 1),
      upsert: jest.fn().mockResolvedValue({ id: 'member-new' }),
      update: jest.fn().mockResolvedValue({ id: 'member-updated' }),
    },
  };
  const prisma = {
    $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
      Promise.resolve().then(() => callback(tx)),
    ),
  };
  const activities = { recalculateAllActivitiesCompletion: jest.fn() };
  const timeline = {
    createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
  };
  const gateway = {
    emitTimelineEvent: jest.fn(),
    removeUserFromTripRoom: jest.fn().mockResolvedValue(undefined),
  };

  return {
    service: new TripMembersService(
      prisma as never,
      activities as never,
      timeline as never,
      gateway as never,
    ),
    prisma,
    tx,
    gateway,
    timeline,
  };
}

describe('TripMembersService.leaveTrip', () => {
  it('prevents the owner from leaving', async () => {
    const { service, tx } = setup({
      members: {
        'owner-1': { userId: 'owner-1', role: 'OWNER', status: 'ACTIVE' },
      },
    });
    await expect(service.leaveTrip('trip-1', 'owner-1')).rejects.toBeInstanceOf(
      ConflictException,
    );
    expect(tx.tripMember.update).not.toHaveBeenCalled();
  });

  it('marks an active member as LEFT and removes them from the chat room', async () => {
    const { service, tx, gateway } = setup({
      members: {
        'user-1': { userId: 'user-1', role: 'MEMBER', status: 'ACTIVE' },
      },
    });
    await service.leaveTrip('trip-1', 'user-1');
    expect(tx.tripMember.update).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ status: 'LEFT' }),
      }),
    );
    expect(gateway.removeUserFromTripRoom).toHaveBeenCalledWith(
      'trip-1',
      'user-1',
    );
  });

  it('still succeeds when removing the sockets fails after commit', async () => {
    const { service, gateway } = setup({
      members: {
        'user-1': { userId: 'user-1', role: 'MEMBER', status: 'ACTIVE' },
      },
    });
    gateway.removeUserFromTripRoom.mockRejectedValueOnce(new Error('down'));

    await expect(service.leaveTrip('trip-1', 'user-1')).resolves.toBeDefined();
    expect(gateway.emitTimelineEvent).toHaveBeenCalled();
  });
});

describe('TripMembersService.kickMember', () => {
  const admin = { userId: 'admin-1', role: 'ADMIN', status: 'ACTIVE' };

  it('forbids an admin from kicking the owner', async () => {
    const { service, tx } = setup({
      members: {
        'admin-1': admin,
        'owner-1': { userId: 'owner-1', role: 'OWNER', status: 'ACTIVE' },
      },
    });
    await expect(
      service.kickMember('trip-1', 'owner-1', 'admin-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripMember.update).not.toHaveBeenCalled();
  });

  it('lets an admin kick a regular member and drops their sockets', async () => {
    const { service, tx, gateway, timeline } = setup({
      members: {
        'admin-1': admin,
        'user-1': {
          id: 'member-lan',
          userId: 'user-1',
          role: 'MEMBER',
          status: 'ACTIVE',
          user: { username: 'lan', displayname: 'Lan Nguyễn' },
        },
      },
    });
    await service.kickMember('trip-1', 'user-1', 'admin-1');
    expect(tx.tripMember.update).toHaveBeenCalledWith({
      where: { tripId_userId: { tripId: 'trip-1', userId: 'user-1' } },
      data: { status: 'KICKED', leftAt: expect.any(Date) },
    });
    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'admin-1', {
      type: 'MEMBER_KICKED',
      content: 'Đã xóa lan khỏi chuyến đi',
      metadata: { targetMemberId: 'member-lan', targetName: 'Lan Nguyễn' },
      target: { type: 'MEMBER', id: 'member-lan' },
    });
    expect(gateway.removeUserFromTripRoom).toHaveBeenCalledWith(
      'trip-1',
      'user-1',
    );
  });

  it('rotates the invite code so the kicked member cannot share it', async () => {
    const { service, tx } = setup({
      members: {
        'admin-1': admin,
        'user-1': {
          userId: 'user-1',
          role: 'MEMBER',
          status: 'ACTIVE',
          user: { username: 'lan' },
        },
      },
    });
    await service.kickMember('trip-1', 'user-1', 'admin-1');
    expect(tx.trip.update).toHaveBeenCalledWith({
      where: { id: 'trip-1' },
      data: { inviteCode: 'NEWCODE1' },
    });
  });

  it('rejects kicking a member who is no longer active', async () => {
    const { service, tx } = setup({
      members: {
        'admin-1': admin,
        'user-1': { userId: 'user-1', role: 'MEMBER', status: 'LEFT' },
      },
    });
    await expect(
      service.kickMember('trip-1', 'user-1', 'admin-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(tx.tripMember.update).not.toHaveBeenCalled();
  });
});

describe('TripMembersService.rotateInviteCode', () => {
  const owner = { userId: 'owner-1', role: 'OWNER', status: 'ACTIVE' };

  it('lets the owner replace the invite code', async () => {
    const { service, tx } = setup({
      trip: { ownerId: 'owner-1', members: [owner] },
    });
    await expect(
      service.rotateInviteCode('trip-1', 'owner-1'),
    ).resolves.toEqual({ id: 'trip-1', inviteCode: 'NEWCODE1' });
    expect(tx.trip.update).toHaveBeenCalledWith(
      expect.objectContaining({ data: { inviteCode: 'NEWCODE1' } }),
    );
  });

  it('forbids anyone but the owner', async () => {
    const { service, tx } = setup({
      trip: {
        ownerId: 'owner-1',
        members: [{ userId: 'admin-1', role: 'ADMIN', status: 'ACTIVE' }],
      },
    });
    await expect(
      service.rotateInviteCode('trip-1', 'admin-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.trip.update).not.toHaveBeenCalled();
  });
});
