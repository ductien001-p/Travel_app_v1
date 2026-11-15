import { NotFoundException } from '@nestjs/common';
import { NotificationsService } from './notification.service';

describe('NotificationsService inbox', () => {
  const row = {
    id: 'n-1',
    type: 'TRIP_INVITATION',
    title: 'Lời mời',
    message: 'Alex mời bạn',
    isRead: false,
    createdAt: new Date('2026-07-19T07:00:00.000Z'),
    tripId: 'trip-1',
    actorId: 'user-2',
  };

  function setup() {
    const prisma = {
      notification: {
        findMany: jest.fn().mockResolvedValue([row]),
        count: jest.fn().mockResolvedValue(1),
        findFirst: jest.fn().mockResolvedValue(row),
        update: jest.fn().mockResolvedValue({ ...row, isRead: true }),
        updateMany: jest.fn().mockResolvedValue({ count: 2 }),
      },
    };
    const service = new NotificationsService(prisma as never, {} as never);
    return { service, prisma };
  }

  it('lists the caller rows newest first with an unread count', async () => {
    const { service, prisma } = setup();

    const page = await service.listForUser('user-1', 30);

    expect(prisma.notification.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { userId: 'user-1' },
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      }),
    );
    expect(page.data[0]).toEqual(
      expect.objectContaining({
        id: 'n-1',
        tripId: 'trip-1',
        isRead: false,
        createdAt: '2026-07-19T07:00:00.000Z',
      }),
    );
    expect(page.meta.unreadCount).toBe(1);
    expect(page.meta.hasMore).toBe(false);
  });

  it('marks one notification read only when it belongs to the caller', async () => {
    const { service, prisma } = setup();
    prisma.notification.findFirst.mockResolvedValueOnce(null);

    await expect(service.markRead('user-1', 'missing')).rejects.toBeInstanceOf(
      NotFoundException,
    );

    const item = await service.markRead('user-1', 'n-1');
    expect(item.isRead).toBe(true);
    expect(prisma.notification.update).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { id: 'n-1' },
        data: expect.objectContaining({ isRead: true }),
      }),
    );
  });

  it('marks every unread row for the caller', async () => {
    const { service } = setup();
    await expect(service.markAllRead('user-1')).resolves.toEqual({
      updated: 2,
    });
  });
});
