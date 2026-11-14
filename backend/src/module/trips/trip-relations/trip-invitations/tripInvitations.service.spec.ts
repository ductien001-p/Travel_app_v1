import {
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import {
  INVITATION_STATUS,
  MEMBER_STATUS,
  NOTIFICATION_TYPE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { TripInvitationsService } from './tripInvitations.service';

describe('TripInvitationsService.acceptInvitation', () => {
  const invitation = {
    id: 'invitation-1',
    tripId: 'trip-1',
    inviterId: 'owner-1',
    inviteeId: 'user-1',
    status: INVITATION_STATUS.PENDING,
    trip: {
      id: 'trip-1',
      name: 'Da Nang',
      status: TRIP_STATUS.UPCOMING,
      maxMembers: 3,
    },
    invitee: { id: 'user-1', username: 'traveler' },
  };

  function setup(overrides: Record<string, unknown> = {}) {
    const current = {
      ...invitation,
      ...overrides,
      trip: { ...invitation.trip, ...((overrides.trip as object) ?? {}) },
    };
    const tx = {
      tripInvitation: {
        findUnique: jest
          .fn()
          .mockResolvedValueOnce(current)
          .mockResolvedValue({
            ...current,
            status: INVITATION_STATUS.ACCEPTED,
          }),
        updateMany: jest.fn().mockResolvedValue({ count: 1 }),
        update: jest.fn().mockResolvedValue({
          ...current,
          status: INVITATION_STATUS.ACCEPTED,
        }),
      },
      tripMember: {
        count: jest.fn().mockResolvedValue(1),
        findUnique: jest.fn().mockResolvedValue(null),
        upsert: jest.fn().mockResolvedValue({ id: 'member-1' }),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const notifications = { create: jest.fn() };
    const push = { sendToUser: jest.fn().mockResolvedValue(undefined) };
    const timeline = {
      createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
    };
    const gateway = { emitTimelineEvent: jest.fn() };
    return {
      service: new TripInvitationsService(
        prisma as never,
        notifications as never,
        push as never,
        timeline as never,
        gateway as never,
      ),
      tx,
      timeline,
      gateway,
    };
  }

  it('accepts a pending invitation to an upcoming trip atomically', async () => {
    const { service, tx } = setup();

    await expect(
      service.acceptInvitation('invitation-1', 'user-1'),
    ).resolves.toMatchObject({ status: INVITATION_STATUS.ACCEPTED });
    expect(tx.tripMember.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        create: expect.objectContaining({ status: MEMBER_STATUS.ACTIVE }),
      }),
    );
  });

  it('records MEMBER_JOINED in the same transaction and broadcasts it after commit', async () => {
    const { service, tx, timeline, gateway } = setup();

    await service.acceptInvitation('invitation-1', 'user-1');

    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'user-1', {
      type: 'MEMBER_JOINED',
      content: 'Đã tham gia chuyến đi',
      metadata: { via: 'INVITATION' },
      target: { type: 'MEMBER', id: 'member-1' },
    });
    expect(gateway.emitTimelineEvent).toHaveBeenCalledWith('trip-1', {
      id: 'event-1',
    });
  });

  it('does not broadcast anything when accepting fails', async () => {
    const { service, tx, gateway } = setup();
    tx.tripMember.count.mockResolvedValue(3);

    await expect(
      service.acceptInvitation('invitation-1', 'user-1'),
    ).rejects.toThrow('Trip is full');
    expect(gateway.emitTimelineEvent).not.toHaveBeenCalled();
  });

  it('rejects a different user', async () => {
    const { service } = setup();
    await expect(
      service.acceptInvitation('invitation-1', 'user-2'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it.each([INVITATION_STATUS.ACCEPTED, INVITATION_STATUS.REJECTED])(
    'rejects an invitation in %s status',
    async (status) => {
      const { service } = setup({ status });
      await expect(
        service.acceptInvitation('invitation-1', 'user-1'),
      ).rejects.toThrow('Invitation is no longer pending');
    },
  );

  it.each([TRIP_STATUS.CANCELLED, TRIP_STATUS.COMPLETED])(
    'rejects a %s trip',
    async (status) => {
      const { service } = setup({ trip: { status } });
      await expect(
        service.acceptInvitation('invitation-1', 'user-1'),
      ).rejects.toBeInstanceOf(ConflictException);
    },
  );

  it('rejects a full trip', async () => {
    const { service, tx } = setup();
    tx.tripMember.count.mockResolvedValue(3);
    await expect(
      service.acceptInvitation('invitation-1', 'user-1'),
    ).rejects.toThrow('Trip is full');
  });

  it('rejects an already active member', async () => {
    const { service, tx } = setup();
    tx.tripMember.findUnique.mockResolvedValue({
      id: 'member-1',
      status: MEMBER_STATUS.ACTIVE,
    });
    await expect(
      service.acceptInvitation('invitation-1', 'user-1'),
    ).rejects.toThrow('User is already a member of this trip');
  });
});

describe('TripInvitationsService.createInvitation', () => {
  const dto = { tripId: 'trip-1', inviteeId: 'user-2' };

  function setup(
    options: {
      status?: TRIP_STATUS;
      inviterRole?: string;
      activeMembers?: number;
      invitee?: { id: string } | null;
      member?: { status: MEMBER_STATUS } | null;
      existing?: { id: string; status: INVITATION_STATUS } | null;
    } = {},
  ) {
    const tx = {
      trip: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'trip-1',
          name: 'Da Nang',
          status: options.status ?? TRIP_STATUS.UPCOMING,
          maxMembers: 3,
          members: [
            {
              role: options.inviterRole ?? 'OWNER',
              status: MEMBER_STATUS.ACTIVE,
              user: { username: 'owner' },
            },
          ],
        }),
      },
      tripMember: {
        count: jest.fn().mockResolvedValue(options.activeMembers ?? 1),
        findUnique: jest.fn().mockResolvedValue(options.member ?? null),
      },
      user: {
        findFirst: jest
          .fn()
          .mockResolvedValue(
            options.invitee === undefined ? { id: 'user-2' } : options.invitee,
          ),
      },
      tripInvitation: {
        findUnique: jest.fn().mockResolvedValue(options.existing ?? null),
        create: jest.fn().mockResolvedValue({ id: 'invitation-new' }),
        update: jest.fn().mockResolvedValue({ id: 'invitation-old' }),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const notifications = { create: jest.fn().mockResolvedValue(undefined) };
    const push = { sendToUser: jest.fn().mockResolvedValue(undefined) };
    const service = new TripInvitationsService(
      prisma as never,
      notifications as never,
      push as never,
      {} as never,
      {} as never,
    );
    return { service, tx, notifications, push };
  }

  it('creates the invitation and notifies the invitee in-app and by push', async () => {
    const { service, tx, notifications, push } = setup();

    await expect(service.createInvitation(dto, 'owner-1')).resolves.toEqual({
      id: 'invitation-new',
    });
    expect(tx.tripInvitation.create).toHaveBeenCalled();
    expect(notifications.create).toHaveBeenCalledWith(
      tx,
      expect.objectContaining({
        userId: 'user-2',
        type: NOTIFICATION_TYPE.TRIP_INVITATION,
      }),
    );
    expect(push.sendToUser).toHaveBeenCalledWith(
      'user-2',
      expect.objectContaining({
        data: expect.objectContaining({ invitationId: 'invitation-new' }),
      }),
    );
  });

  it.each([
    INVITATION_STATUS.REJECTED,
    INVITATION_STATUS.CANCELLED,
    INVITATION_STATUS.ACCEPTED,
  ])(
    'reopens a previous %s invitation instead of duplicating it',
    async (status) => {
      const { service, tx } = setup({
        existing: { id: 'invitation-old', status },
      });

      await service.createInvitation(dto, 'owner-1');

      expect(tx.tripInvitation.update).toHaveBeenCalledWith({
        where: { id: 'invitation-old' },
        data: { inviterId: 'owner-1', status: INVITATION_STATUS.PENDING },
      });
      expect(tx.tripInvitation.create).not.toHaveBeenCalled();
    },
  );

  it('rejects a duplicate pending invitation', async () => {
    const { service, push } = setup({
      existing: { id: 'invitation-old', status: INVITATION_STATUS.PENDING },
    });

    await expect(
      service.createInvitation(dto, 'owner-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(push.sendToUser).not.toHaveBeenCalled();
  });

  it('rejects inviting yourself before touching the database', async () => {
    const { service, tx } = setup();

    await expect(
      service.createInvitation({ ...dto, inviteeId: 'owner-1' }, 'owner-1'),
    ).rejects.toThrow('You cannot invite yourself');
    expect(tx.trip.findUnique).not.toHaveBeenCalled();
  });

  it('forbids a regular member from inviting', async () => {
    const { service } = setup({ inviterRole: 'MEMBER' });

    await expect(
      service.createInvitation(dto, 'member-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it.each([TRIP_STATUS.ONGOING, TRIP_STATUS.COMPLETED, TRIP_STATUS.DRAFT])(
    'rejects inviting to a %s trip',
    async (status) => {
      const { service } = setup({ status });

      await expect(service.createInvitation(dto, 'owner-1')).rejects.toThrow(
        'Trip is not open for new members',
      );
    },
  );

  it('rejects inviting to a full trip', async () => {
    const { service } = setup({ activeMembers: 3 });

    await expect(service.createInvitation(dto, 'owner-1')).rejects.toThrow(
      'Trip is full',
    );
  });

  it('rejects an invitee that is deleted or inactive', async () => {
    const { service } = setup({ invitee: null });

    await expect(
      service.createInvitation(dto, 'owner-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('rejects an invitee who is already an active member', async () => {
    const { service } = setup({ member: { status: MEMBER_STATUS.ACTIVE } });

    await expect(service.createInvitation(dto, 'owner-1')).rejects.toThrow(
      'User is already a member of this trip',
    );
  });
});

describe('TripInvitationsService.rejectInvitation', () => {
  it('returns 409 when the invitation stopped being pending concurrently', async () => {
    const tx = {
      tripInvitation: {
        updateMany: jest.fn().mockResolvedValue({ count: 0 }),
        findUniqueOrThrow: jest.fn(),
      },
    };
    const prisma = {
      tripInvitation: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'invitation-1',
          tripId: 'trip-1',
          inviterId: 'owner-1',
          inviteeId: 'user-1',
          status: INVITATION_STATUS.PENDING,
          trip: { id: 'trip-1', name: 'Da Nang' },
          invitee: { id: 'user-1', username: 'traveler' },
        }),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const notifications = { create: jest.fn() };
    const push = { sendToUser: jest.fn().mockResolvedValue(undefined) };
    const service = new TripInvitationsService(
      prisma as never,
      notifications as never,
      push as never,
      {} as never,
      {} as never,
    );

    await expect(
      service.rejectInvitation('invitation-1', 'user-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(notifications.create).not.toHaveBeenCalled();
    expect(push.sendToUser).not.toHaveBeenCalled();
  });
});
