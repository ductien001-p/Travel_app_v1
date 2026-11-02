import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import {
  CURRENCY,
  EXPENSE_CATEGORY,
  EXPENSE_SPLIT_TYPE,
  MEMBER_STATUS,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { TripExpenseService } from './tripExpense.service';
import { CreateExpenseDto } from './dto/create-expense.dto';

describe('TripExpenseService.createExpense', () => {
  function setup(
    options: {
      tripStatus?: TRIP_STATUS;
      role?: string;
      memberIds?: string[];
      startDate?: Date;
      endDate?: Date;
    } = {},
  ) {
    const startDate = options.startDate ?? new Date('2025-07-01T00:00:00.000Z');
    const endDate = options.endDate ?? new Date('2025-07-15T00:00:00.000Z');
    const tx = {
      tripMember: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'm1',
          role: options.role ?? 'MEMBER',
          status: MEMBER_STATUS.ACTIVE,
          trip: {
            status: options.tripStatus ?? TRIP_STATUS.ONGOING,
            startDate,
            endDate,
          },
        }),
        findFirst: jest.fn().mockImplementation(
          async ({ where }: { where: { id?: string } }) => {
            const ids = options.memberIds ?? ['m1', 'm2', 'm3'];
            if (where.id && ids.includes(where.id)) {
              return { id: where.id };
            }
            return null;
          },
        ),
        findMany: jest
          .fn()
          .mockResolvedValue(
            (options.memberIds ?? ['m1', 'm2', 'm3']).map((id) => ({ id })),
          ),
      },
      tripExpense: {
        create: jest.fn().mockResolvedValue({ id: 'expense-1' }),
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          id: 'expense-1',
          tripId: 'trip-1',
          payerId: 'm1',
          amount: new Prisma.Decimal(100),
          currency: CURRENCY.VND,
          category: Object.values(EXPENSE_CATEGORY)[0],
          splitType: EXPENSE_SPLIT_TYPE.EQUAL,
          description: null,
          spentAt: new Date('2025-07-10T10:00:00.000Z'),
          locationNote: null,
          createdAt: new Date('2025-07-10T10:00:00.000Z'),
          payer: {
            id: 'm1',
            userId: 'user-1',
            user: {
              id: 'user-1',
              username: 'alex',
              avatarId: null,
              displayname: 'Alex',
            },
          },
          splits: [],
          receipts: [],
        }),
      },
      tripExpenseSplit: {
        createMany: jest.fn().mockResolvedValue({ count: 3 }),
      },
      tripExpenseReceipt: {
        createMany: jest.fn().mockResolvedValue({ count: 0 }),
      },
      uploadedMedia: {
        findMany: jest.fn().mockResolvedValue([]),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
      uploadedMedia: tx.uploadedMedia,
    };
    const gateway = { emitTimelineEvent: jest.fn() };
    const timeline = {
      createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
    };
    const mediaService = {
      validateMediaExists: jest.fn().mockResolvedValue(undefined),
    };
    const s3 = {
      getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
    };
    const service = new TripExpenseService(
      prisma as never,
      gateway as never,
      timeline as never,
      mediaService as never,
      s3 as never,
    );
    return { service, tx, gateway, timeline, mediaService, s3, prisma };
  }

  function expense(overrides: Partial<CreateExpenseDto>): CreateExpenseDto {
    return {
      amount: 100,
      category: Object.values(EXPENSE_CATEGORY)[0],
      splitType: EXPENSE_SPLIT_TYPE.EQUAL,
      ...overrides,
    } as CreateExpenseDto;
  }

  function splitAmounts(tx: ReturnType<typeof setup>['tx']) {
    const [{ data }] = tx.tripExpenseSplit.createMany.mock.calls[0] as [
      { data: Array<{ tripMemberId: string; amount: { toString(): string } }> },
    ];
    return data.map((split) => split.amount.toString());
  }

  it('splits VND equally in whole units and gives the remainder out one by one', async () => {
    const { service, tx, gateway } = setup();

    await service.createExpense(
      'trip-1',
      'user-1',
      expense({ amount: 100, currency: CURRENCY.VND }),
    );

    expect(splitAmounts(tx)).toEqual(['34', '33', '33']);
    expect(gateway.emitTimelineEvent).toHaveBeenCalledWith('trip-1', {
      id: 'event-1',
    });
  });

  it('splits USD by cents so the shares add up exactly', async () => {
    const { service, tx } = setup();

    await service.createExpense(
      'trip-1',
      'user-1',
      expense({ amount: 10, currency: CURRENCY.USD }),
    );

    expect(splitAmounts(tx)).toEqual(['3.34', '3.33', '3.33']);
  });

  it('marks only the payer share as settled', async () => {
    const { service, tx } = setup();

    await service.createExpense('trip-1', 'user-1', expense({}));

    const [{ data }] = tx.tripExpenseSplit.createMany.mock.calls[0] as [
      { data: Array<{ tripMemberId: string; isSettled: boolean }> },
    ];
    expect(
      data.filter((split) => split.isSettled).map((s) => s.tripMemberId),
    ).toEqual(['m1']);
  });

  it('rejects VND amounts with decimals', async () => {
    const { service, tx } = setup();

    await expect(
      service.createExpense(
        'trip-1',
        'user-1',
        expense({ amount: 100.5, currency: CURRENCY.VND }),
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.tripExpense.create).not.toHaveBeenCalled();
  });

  it('accepts custom splits that match the total to the cent', async () => {
    const { service, tx } = setup();

    await service.createExpense(
      'trip-1',
      'user-1',
      expense({
        amount: 0.3,
        currency: CURRENCY.USD,
        splitType: EXPENSE_SPLIT_TYPE.CUSTOM,
        splits: [
          { tripMemberId: 'm1', amount: 0.1 },
          { tripMemberId: 'm2', amount: 0.2 },
        ],
      }),
    );

    expect(splitAmounts(tx)).toEqual(['0.1', '0.2']);
  });

  it('rejects custom splits whose sum differs from the total', async () => {
    const { service } = setup();

    await expect(
      service.createExpense(
        'trip-1',
        'user-1',
        expense({
          amount: 100,
          splitType: EXPENSE_SPLIT_TYPE.CUSTOM,
          splits: [
            { tripMemberId: 'm1', amount: 50 },
            { tripMemberId: 'm2', amount: 49 },
          ],
        }),
      ),
    ).rejects.toThrow('Split amounts must equal expense amount');
  });

  it('rejects custom splits for members that are not active', async () => {
    const { service } = setup({ memberIds: ['m1', 'm2'] });

    await expect(
      service.createExpense(
        'trip-1',
        'user-1',
        expense({
          splitType: EXPENSE_SPLIT_TYPE.CUSTOM,
          splits: [
            { tripMemberId: 'm1', amount: 50 },
            { tripMemberId: 'gone', amount: 50 },
          ],
        }),
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects splits sent with the EQUAL split type', async () => {
    const { service } = setup();

    await expect(
      service.createExpense(
        'trip-1',
        'user-1',
        expense({ splits: [{ tripMemberId: 'm1', amount: 100 }] }),
      ),
    ).rejects.toThrow('splits must be omitted for EQUAL split type');
  });

  it.each([TRIP_STATUS.DRAFT, TRIP_STATUS.CANCELLED])(
    'rejects expenses on a %s trip',
    async (tripStatus) => {
      const { service, tx } = setup({ tripStatus });

      await expect(
        service.createExpense('trip-1', 'user-1', expense({})),
      ).rejects.toBeInstanceOf(ConflictException);
      expect(tx.tripExpense.create).not.toHaveBeenCalled();
    },
  );

  it('rejects users without an active membership', async () => {
    const { service, tx } = setup();
    tx.tripMember.findUnique.mockResolvedValue(null);

    await expect(
      service.createExpense('trip-1', 'user-1', expense({})),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('records the amount, split count and target on the timeline', async () => {
    const { service, tx, timeline } = setup();

    await service.createExpense(
      'trip-1',
      'user-1',
      expense({ amount: 1200000, description: '  Hải sản  ' }),
    );

    expect(timeline.createEvent).toHaveBeenCalledWith(
      tx,
      'trip-1',
      'user-1',
      expect.objectContaining({
        type: 'EXPENSE_CREATED',
        content: 'Đã thêm một chi phí mới',
        metadata: expect.objectContaining({
          amount: '1200000',
          currency: CURRENCY.VND,
          category: Object.values(EXPENSE_CATEGORY)[0],
          description: 'Hải sản',
          splitType: EXPENSE_SPLIT_TYPE.EQUAL,
          splitCount: 3,
          payerMemberId: 'm1',
          receiptCount: 0,
        }),
        target: { type: 'EXPENSE', id: 'expense-1' },
      }),
    );
  });

  it('lets the actor set another active member as payer', async () => {
    const { service, tx } = setup();

    await service.createExpense(
      'trip-1',
      'user-1',
      expense({ payerTripMemberId: 'm2' }),
    );

    expect(tx.tripExpense.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ payerId: 'm2' }),
      }),
    );
    const [{ data }] = tx.tripExpenseSplit.createMany.mock.calls[0] as [
      { data: Array<{ tripMemberId: string; isSettled: boolean }> },
    ];
    expect(
      data.filter((split) => split.isSettled).map((s) => s.tripMemberId),
    ).toEqual(['m2']);
  });

  it('rejects a payer who is not an active trip member', async () => {
    const { service } = setup();

    await expect(
      service.createExpense(
        'trip-1',
        'user-1',
        expense({ payerTripMemberId: 'gone' }),
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects spentAt outside the allowed window', async () => {
    const { service } = setup();

    await expect(
      service.createExpense(
        'trip-1',
        'user-1',
        expense({ spentAt: '2020-01-01T00:00:00.000Z' }),
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('attaches owned receipt media ids', async () => {
    const { service, tx, prisma, mediaService } = setup();
    prisma.uploadedMedia.findMany.mockResolvedValue([
      { id: 'media-1', objectKey: 'trips/user-1/r1.jpg' },
    ]);

    await service.createExpense(
      'trip-1',
      'user-1',
      expense({ receiptMediaIds: ['media-1'] }),
    );

    expect(mediaService.validateMediaExists).toHaveBeenCalledWith(
      'trips/user-1/r1.jpg',
    );
    expect(tx.tripExpenseReceipt.createMany).toHaveBeenCalledWith({
      data: [{ expenseId: 'expense-1', mediaId: 'media-1', sortOrder: 0 }],
    });
  });
});

describe('TripExpenseService.settleSplit', () => {
  function setup(
    options: {
      actor?: { id: string; status?: string } | null;
      split?: Record<string, unknown> | null;
      updatedCount?: number;
    } = {},
  ) {
    const split =
      options.split === undefined
        ? {
            id: 'split-2',
            amount: new Prisma.Decimal('850000'),
            isSettled: false,
            tripMemberId: 'm2',
            member: { user: { displayname: 'Minh Trang' } },
            expense: {
              payerId: 'm1',
              currency: CURRENCY.VND,
              description: 'Khách sạn',
              payer: { user: { displayname: 'Lan' } },
            },
          }
        : options.split;
    const actor =
      options.actor === undefined
        ? { id: 'm2', status: 'ACTIVE' }
        : options.actor;
    const tx = {
      tripMember: {
        findUnique: jest.fn().mockResolvedValue(
          actor
            ? {
                id: actor.id,
                userId: 'user-x',
                tripId: 'trip-1',
                role: 'MEMBER',
                status: actor.status ?? 'ACTIVE',
              }
            : null,
        ),
      },
      trip: { findUnique: jest.fn().mockResolvedValue({ id: 'trip-1' }) },
      tripExpenseSplit: {
        findFirst: jest.fn().mockResolvedValue(split),
        updateMany: jest
          .fn()
          .mockResolvedValue({ count: options.updatedCount ?? 1 }),
        findUniqueOrThrow: jest
          .fn()
          .mockResolvedValue({ id: 'split-2', isSettled: true }),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const gateway = { emitTimelineEvent: jest.fn() };
    const timeline = {
      createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
    };
    const service = new TripExpenseService(
      prisma as never,
      gateway as never,
      timeline as never,
      { validateMediaExists: jest.fn() } as never,
      { getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`) } as never,
    );
    return { service, tx, gateway, timeline };
  }

  it('lets the debtor mark their share as paid and records who was paid', async () => {
    const { service, tx, gateway, timeline } = setup();

    await expect(
      service.settleSplit('trip-1', 'expense-1', 'split-2', 'user-2'),
    ).resolves.toEqual({ id: 'split-2', isSettled: true });

    expect(tx.tripExpenseSplit.findFirst).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          id: 'split-2',
          expenseId: 'expense-1',
          expense: { tripId: 'trip-1', deletedAt: null },
        },
      }),
    );
    expect(tx.tripExpenseSplit.updateMany).toHaveBeenCalledWith({
      where: { id: 'split-2', isSettled: false },
      data: { isSettled: true },
    });
    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'user-2', {
      type: 'EXPENSE_SETTLED',
      content: 'Đã thanh toán cho Lan',
      metadata: {
        amount: '850000',
        currency: CURRENCY.VND,
        description: 'Khách sạn',
        payerMemberId: 'm1',
        payerName: 'Lan',
        debtorMemberId: 'm2',
        debtorName: 'Minh Trang',
      },
      target: { type: 'EXPENSE', id: 'expense-1' },
    });
    expect(gateway.emitTimelineEvent).toHaveBeenCalledWith('trip-1', {
      id: 'event-1',
    });
  });

  it('lets the payer confirm they received the money', async () => {
    const { service, timeline } = setup({ actor: { id: 'm1' } });

    await service.settleSplit('trip-1', 'expense-1', 'split-2', 'user-1');

    expect(timeline.createEvent).toHaveBeenCalledWith(
      expect.anything(),
      'trip-1',
      'user-1',
      expect.objectContaining({
        content: 'Đã xác nhận nhận tiền từ Minh Trang',
      }),
    );
  });

  it('forbids members who are neither the payer nor the debtor', async () => {
    const { service, tx, gateway } = setup({ actor: { id: 'm3' } });

    await expect(
      service.settleSplit('trip-1', 'expense-1', 'split-2', 'user-3'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripExpenseSplit.updateMany).not.toHaveBeenCalled();
    expect(gateway.emitTimelineEvent).not.toHaveBeenCalled();
  });

  it('forbids users without an active membership', async () => {
    const { service, tx } = setup({ actor: { id: 'm2', status: 'LEFT' } });

    await expect(
      service.settleSplit('trip-1', 'expense-1', 'split-2', 'user-2'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripExpenseSplit.findFirst).not.toHaveBeenCalled();
  });

  it('returns 404 for a share outside this trip or a deleted expense', async () => {
    const { service } = setup({ split: null });

    await expect(
      service.settleSplit('trip-1', 'expense-1', 'split-x', 'user-2'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('rejects a share that is already settled', async () => {
    const { service, tx } = setup({
      split: {
        id: 'split-2',
        amount: new Prisma.Decimal('850000'),
        isSettled: true,
        tripMemberId: 'm2',
        member: { user: { displayname: 'Minh Trang' } },
        expense: {
          payerId: 'm1',
          currency: CURRENCY.VND,
          description: null,
          payer: { user: { displayname: 'Lan' } },
        },
      },
    });

    await expect(
      service.settleSplit('trip-1', 'expense-1', 'split-2', 'user-2'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripExpenseSplit.updateMany).not.toHaveBeenCalled();
  });

  it('lets only one of two concurrent settle requests win', async () => {
    const { service, timeline } = setup({ updatedCount: 0 });

    await expect(
      service.settleSplit('trip-1', 'expense-1', 'split-2', 'user-2'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(timeline.createEvent).not.toHaveBeenCalled();
  });
});

describe('TripExpenseService.getExpenses', () => {
  function member(
    id: string,
    userId: string,
    displayname: string,
    username = displayname.toLowerCase().replace(/\s+/g, ''),
  ) {
    return {
      id,
      userId,
      user: { id: userId, username, avatarId: null, displayname },
    };
  }

  function setup() {
    const alex = member('m-alex', 'user-alex', 'Alex Nguyễn', 'alex');
    const trang = member('m-trang', 'user-trang', 'Minh Trang', 'minhtrang');
    const phuong = member('m-phuong', 'user-phuong', 'Lan Phương', 'lanphuong');

    const prisma = {
      tripMember: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'm-alex',
          userId: 'user-alex',
          tripId: 'trip-1',
          role: 'OWNER',
          status: MEMBER_STATUS.ACTIVE,
        }),
      },
      trip: {
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          id: 'trip-1',
          name: 'Mùa hè rực rỡ 2025',
          budgetCurrency: CURRENCY.VND,
          members: [
            { id: 'm-alex', userId: 'user-alex', user: { displayname: 'Alex Nguyễn' } },
            {
              id: 'm-trang',
              userId: 'user-trang',
              user: { displayname: 'Minh Trang' },
            },
            {
              id: 'm-phuong',
              userId: 'user-phuong',
              user: { displayname: 'Lan Phương' },
            },
          ],
        }),
      },
      tripExpense: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'expense-cruise',
            tripId: 'trip-1',
            payerId: 'm-alex',
            amount: new Prisma.Decimal('1000000'),
            currency: CURRENCY.VND,
            category: EXPENSE_CATEGORY.ACTIVITY,
            splitType: EXPENSE_SPLIT_TYPE.CUSTOM,
            description: 'Du thuyền ngắm Cầu Rồng',
            spentAt: new Date('2025-07-18T09:30:00.000Z'),
            locationNote: null,
            createdAt: new Date('2025-07-18T09:30:00.000Z'),
            payer: alex,
            receipts: [],
            splits: [
              {
                id: 'split-cruise-alex',
                expenseId: 'expense-cruise',
                tripMemberId: 'm-alex',
                amount: new Prisma.Decimal('250000'),
                isSettled: true,
                member: alex,
              },
              {
                id: 'split-cruise-phuong',
                expenseId: 'expense-cruise',
                tripMemberId: 'm-phuong',
                amount: new Prisma.Decimal('320000'),
                isSettled: false,
                member: phuong,
              },
              {
                id: 'split-cruise-trang',
                expenseId: 'expense-cruise',
                tripMemberId: 'm-trang',
                amount: new Prisma.Decimal('430000'),
                isSettled: false,
                member: trang,
              },
            ],
          },
          {
            id: 'expense-seafood',
            tripId: 'trip-1',
            payerId: 'm-trang',
            amount: new Prisma.Decimal('900000'),
            currency: CURRENCY.VND,
            category: EXPENSE_CATEGORY.FOOD,
            splitType: EXPENSE_SPLIT_TYPE.EQUAL,
            description: 'Bữa tối hải sản',
            spentAt: new Date('2025-07-17T13:15:00.000Z'),
            locationNote: 'Chợ đêm',
            createdAt: new Date('2025-07-17T13:15:00.000Z'),
            payer: trang,
            receipts: [
              {
                mediaId: 'media-seafood',
                sortOrder: 0,
                media: { objectKey: 'trips/user-trang/bill.jpg' },
              },
            ],
            splits: [
              {
                id: 'split-seafood-alex',
                expenseId: 'expense-seafood',
                tripMemberId: 'm-alex',
                amount: new Prisma.Decimal('300000'),
                isSettled: true,
                member: alex,
              },
              {
                id: 'split-seafood-trang',
                expenseId: 'expense-seafood',
                tripMemberId: 'm-trang',
                amount: new Prisma.Decimal('300000'),
                isSettled: true,
                member: trang,
              },
              {
                id: 'split-seafood-phuong',
                expenseId: 'expense-seafood',
                tripMemberId: 'm-phuong',
                amount: new Prisma.Decimal('300000'),
                isSettled: false,
                member: phuong,
              },
            ],
          },
        ]),
      },
    };

    const service = new TripExpenseService(
      prisma as never,
      { emitTimelineEvent: jest.fn() } as never,
      { createEvent: jest.fn() } as never,
      { validateMediaExists: jest.fn() } as never,
      {
        getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
      } as never,
    );
    return { service, prisma };
  }

  it('returns overview totals, categories, settlements and enriched expenses', async () => {
    const { service } = setup();

    const result = await service.getExpenses('trip-1', 'user-alex');

    expect(result.tripId).toBe('trip-1');
    expect(result.tripName).toBe('Mùa hè rực rỡ 2025');
    expect(result.memberCount).toBe(3);
    expect(result.currency).toBe(CURRENCY.VND);
    expect(result.viewerUserId).toBe('user-alex');
    expect(result.summary).toEqual({
      totalAmount: 1_900_000,
      viewerPaidAmount: 1_000_000,
      // Alex is owed 320k+430k on cruise; owes nothing unsettled on seafood.
      viewerNetBalance: 750_000,
    });
    expect(result.categories.map((row) => row.category)).toEqual([
      EXPENSE_CATEGORY.ACTIVITY,
      EXPENSE_CATEGORY.FOOD,
    ]);
    expect(result.categories.reduce((sum, row) => sum + row.percent, 0)).toBe(
      100,
    );
    expect(result.settlements[0]).toEqual(
      expect.objectContaining({
        fromDisplayName: 'Minh Trang',
        fromIsViewer: false,
        toIsViewer: true,
        status: 'ACTIONABLE',
        amount: 430_000,
        splitId: 'split-cruise-trang',
      }),
    );
    expect(result.settlements.map((row) => row.splitId)).toEqual([
      'split-cruise-trang',
      'split-cruise-phuong',
      'split-seafood-phuong',
    ]);
    expect(result.expenses).toHaveLength(2);
    expect(result.expenses[0]).toEqual(
      expect.objectContaining({
        id: 'expense-cruise',
        payerIsViewer: true,
        status: 'PENDING',
        settledCount: 1,
        splitCount: 3,
        amountPerPerson: null,
      }),
    );
    expect(result.expenses[1]).toEqual(
      expect.objectContaining({
        id: 'expense-seafood',
        payerIsViewer: false,
        status: 'PARTIAL',
        settledCount: 2,
        amountPerPerson: 300_000,
      }),
    );
  });

  it('rejects non-members', async () => {
    const { service, prisma } = setup();
    prisma.tripMember.findUnique.mockResolvedValue(null);
    prisma.trip = {
      ...prisma.trip,
      findUnique: jest.fn().mockResolvedValue({ id: 'trip-1' }),
    } as never;

    await expect(
      service.getExpenses('trip-1', 'user-x'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});
