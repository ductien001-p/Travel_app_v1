import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../../../prisma.service';

import {
  CURRENCY,
  EXPENSE_CATEGORY,
  EXPENSE_SPLIT_TYPE,
  MEMBER_STATUS,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { Prisma } from '../../../../generated/prisma/client';

import { CreateExpenseDto } from './dto/create-expense.dto';
import { TripGateway } from '../../../../websocket/gateway';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import { TripAccessPolicy, TripResourcePolicy } from '../../policies';
import { MediaService } from '../../../media/media.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import {
  TripExpenseCategoryShareDto,
  TripExpenseListItemDto,
  TripExpenseOverviewDto,
  TripExpenseReceiptDto,
  TripExpenseSettleStatusDto,
  TripExpenseSettlementDto,
  TripExpenseSettlementStatusDto,
} from '../../../../common/contracts/extended-response.dto';

/** Decimal places of the smallest unit actually used for each currency. */
const CURRENCY_DECIMALS: Record<CURRENCY, number> = {
  [CURRENCY.VND]: 0,
  [CURRENCY.USD]: 2,
};

const CLOSED_TRIP_STATUSES: readonly TRIP_STATUS[] = [
  TRIP_STATUS.DRAFT,
  TRIP_STATUS.CANCELLED,
];

type MinorSplit = { tripMemberId: string; minor: number };

const EXPENSE_MEMBER_SELECT = {
  id: true,
  userId: true,
  user: {
    select: {
      id: true,
      username: true,
      avatarId: true,
      displayname: true,
    },
  },
} satisfies Prisma.TripMemberSelect;

const RECEIPT_INCLUDE = {
  orderBy: { sortOrder: 'asc' as const },
  select: {
    mediaId: true,
    sortOrder: true,
    media: { select: { objectKey: true } },
  },
} satisfies Prisma.TripExpense$receiptsArgs;

const OVERVIEW_EXPENSE_INCLUDE = {
  payer: { select: EXPENSE_MEMBER_SELECT },
  splits: {
    include: { member: { select: EXPENSE_MEMBER_SELECT } },
    orderBy: { id: 'asc' as const },
  },
  receipts: RECEIPT_INCLUDE,
} satisfies Prisma.TripExpenseInclude;

type OverviewExpense = Prisma.TripExpenseGetPayload<{
  include: typeof OVERVIEW_EXPENSE_INCLUDE;
}>;

@Injectable()
export class TripExpenseService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly tripGateway: TripGateway,
    private readonly tripTimelineService: TripTimelineService,
    private readonly mediaService: MediaService,
    private readonly s3: S3Service,
  ) {}

  async createExpense(tripId: string, userId: string, dto: CreateExpenseDto) {
    const currency = dto.currency ?? CURRENCY.VND;
    const decimals = CURRENCY_DECIMALS[currency];
    const totalMinor = this.toMinorUnits(dto.amount, decimals, currency);
    const receiptMediaIds = [...new Set(dto.receiptMediaIds ?? [])];
    const locationNote = dto.locationNote?.trim() || null;

    if (receiptMediaIds.length > 0) {
      const mediaById = await TripResourcePolicy.assertOwnedImages(
        this.prisma,
        userId,
        receiptMediaIds,
      );
      await Promise.all(
        [...mediaById.values()].map((media) =>
          this.mediaService.validateMediaExists(media.objectKey),
        ),
      );
    }

    const result = await this.prisma.$transaction(async (tx) => {
      const actor = await tx.tripMember.findUnique({
        where: { tripId_userId: { tripId, userId } },
        select: {
          id: true,
          role: true,
          status: true,
          trip: {
            select: {
              status: true,
              startDate: true,
              endDate: true,
            },
          },
        },
      });

      TripAccessPolicy.assertAllowed(actor, 'MANAGE_EXPENSES');
      if (CLOSED_TRIP_STATUSES.includes(actor.trip.status)) {
        throw new ConflictException(
          `Cannot add expenses while the trip is ${actor.trip.status}`,
        );
      }

      const payer = await this.resolvePayer(tx, tripId, actor.id, dto);
      const spentAt = this.resolveSpentAt(dto.spentAt, actor.trip);

      const members = await tx.tripMember.findMany({
        where: { tripId, status: MEMBER_STATUS.ACTIVE },
        select: { id: true },
      });

      if (members.length === 0) {
        throw new BadRequestException('Trip has no active members');
      }

      const splits = this.calculateSplits(
        dto,
        members.map((member) => member.id),
        totalMinor,
        decimals,
        currency,
      );

      const expense = await tx.tripExpense.create({
        data: {
          tripId,
          payerId: payer.id,
          amount: this.fromMinorUnits(totalMinor, decimals),
          currency,
          category: dto.category,
          splitType: dto.splitType,
          description: dto.description,
          spentAt,
          locationNote,
        },
      });

      await tx.tripExpenseSplit.createMany({
        data: splits.map((split) => ({
          expenseId: expense.id,
          tripMemberId: split.tripMemberId,
          amount: this.fromMinorUnits(split.minor, decimals),
          isSettled: split.tripMemberId === payer.id,
        })),
      });

      if (receiptMediaIds.length > 0) {
        await tx.tripExpenseReceipt.createMany({
          data: receiptMediaIds.map((mediaId, index) => ({
            expenseId: expense.id,
            mediaId,
            sortOrder: index,
          })),
        });
      }

      const updatedExpense = await tx.tripExpense.findUniqueOrThrow({
        where: { id: expense.id },
        include: {
          payer: { select: EXPENSE_MEMBER_SELECT },
          splits: { include: { member: { select: EXPENSE_MEMBER_SELECT } } },
          receipts: RECEIPT_INCLUDE,
        },
      });

      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.EXPENSE_CREATED,
          content: 'Đã thêm một chi phí mới',
          metadata: {
            amount: this.fromMinorUnits(totalMinor, decimals).toFixed(decimals),
            currency,
            category: dto.category,
            description: dto.description?.trim() || null,
            splitType: dto.splitType,
            splitCount: splits.length,
            payerMemberId: payer.id,
            spentAt: spentAt.toISOString(),
            receiptCount: receiptMediaIds.length,
          },
          target: { type: TIMELINE_TARGET_TYPE.EXPENSE, id: expense.id },
        },
      );

      return {
        updatedExpense,
        timelineEvent,
      };
    });

    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);

    return this.toCreateResponse(result.updatedExpense, decimals);
  }

  /**
   * Group-fund screen: totals, category breakdown, unsettled share suggestions,
   * and the expense feed for one trip.
   */
  async getExpenses(
    tripId: string,
    userId: string,
  ): Promise<TripExpenseOverviewDto> {
    const viewer = await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_EXPENSES',
    );

    const trip = await this.prisma.trip.findUniqueOrThrow({
      where: { id: tripId },
      select: {
        id: true,
        name: true,
        budgetCurrency: true,
        members: {
          where: { status: MEMBER_STATUS.ACTIVE },
          select: {
            id: true,
            userId: true,
            user: { select: { displayname: true } },
          },
        },
      },
    });

    const expenses = await this.prisma.tripExpense.findMany({
      where: { tripId, deletedAt: null },
      include: OVERVIEW_EXPENSE_INCLUDE,
      orderBy: [{ spentAt: 'desc' }, { id: 'desc' }],
    });

    const currency = overviewCurrency(
      expenses.map((expense) => expense.currency),
      trip.budgetCurrency ?? null,
    );
    const inCurrency = expenses.filter((expense) => expense.currency === currency);

    const memberNames = new Map(
      trip.members.map((member) => [
        member.id,
        member.user.displayname?.trim() || 'Thành viên',
      ]),
    );

    const listItems = inCurrency.map((expense) =>
      this.toListItem(expense, viewer.userId, currency),
    );

    const totalAmount = inCurrency.reduce(
      (sum, expense) => sum + expense.amount.toNumber(),
      0,
    );
    const viewerPaidAmount = inCurrency
      .filter((expense) => expense.payer.userId === userId)
      .reduce((sum, expense) => sum + expense.amount.toNumber(), 0);

    let viewerCredited = 0;
    let viewerDebited = 0;
    for (const expense of inCurrency) {
      for (const split of expense.splits) {
        if (split.isSettled) continue;
        if (split.tripMemberId === expense.payerId) continue;
        const amount = split.amount.toNumber();
        if (expense.payer.userId === userId) viewerCredited += amount;
        if (split.member.userId === userId) viewerDebited += amount;
      }
    }

    return {
      tripId: trip.id,
      tripName: trip.name,
      memberCount: trip.members.length,
      currency,
      viewerUserId: userId,
      summary: {
        totalAmount,
        viewerPaidAmount,
        viewerNetBalance: viewerCredited - viewerDebited,
      },
      categories: buildCategoryShares(inCurrency, totalAmount),
      settlements: buildSettlements(inCurrency, userId, memberNames),
      expenses: listItems,
    };
  }

  /**
   * Marks one member's share as paid. Only the two people involved may do it:
   * the debtor ("I paid") or the payer ("I received the money").
   */
  async settleSplit(
    tripId: string,
    expenseId: string,
    splitId: string,
    userId: string,
  ) {
    const result = await this.prisma.$transaction(async (tx) => {
      const actor = await TripAccessPolicy.authorize(
        tx,
        tripId,
        userId,
        'MANAGE_EXPENSES',
      );

      const split = await tx.tripExpenseSplit.findFirst({
        where: {
          id: splitId,
          expenseId,
          expense: { tripId, deletedAt: null },
        },
        select: {
          id: true,
          amount: true,
          isSettled: true,
          tripMemberId: true,
          member: { select: { user: { select: { displayname: true } } } },
          expense: {
            select: {
              payerId: true,
              currency: true,
              description: true,
              payer: { select: { user: { select: { displayname: true } } } },
            },
          },
        },
      });
      if (!split) {
        throw new NotFoundException('Expense share not found in this trip');
      }

      const isDebtor = split.tripMemberId === actor.id;
      const isPayer = split.expense.payerId === actor.id;
      if (!isDebtor && !isPayer) {
        throw new ForbiddenException(
          'Only the payer or the member who owes this share can settle it',
        );
      }
      if (split.isSettled) {
        throw new ConflictException('This share is already settled');
      }

      // Guarded on isSettled so two concurrent requests cannot both succeed.
      const { count } = await tx.tripExpenseSplit.updateMany({
        where: { id: split.id, isSettled: false },
        data: { isSettled: true },
      });
      if (count !== 1) {
        throw new ConflictException('This share is already settled');
      }

      const payerName = split.expense.payer.user.displayname;
      const debtorName = split.member.user.displayname;
      const decimals = CURRENCY_DECIMALS[split.expense.currency];

      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.EXPENSE_SETTLED,
          content: isDebtor
            ? `Đã thanh toán cho ${payerName}`
            : `Đã xác nhận nhận tiền từ ${debtorName}`,
          metadata: {
            amount: split.amount.toFixed(decimals),
            currency: split.expense.currency,
            description: split.expense.description,
            payerMemberId: split.expense.payerId,
            payerName,
            debtorMemberId: split.tripMemberId,
            debtorName,
          },
          target: { type: TIMELINE_TARGET_TYPE.EXPENSE, id: expenseId },
        },
      );

      const settled = await tx.tripExpenseSplit.findUniqueOrThrow({
        where: { id: split.id },
        include: { member: { select: EXPENSE_MEMBER_SELECT } },
      });

      return { settled, timelineEvent };
    });

    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);

    return result.settled;
  }

  private calculateSplits(
    dto: CreateExpenseDto,
    memberIds: string[],
    totalMinor: number,
    decimals: number,
    currency: CURRENCY,
  ): MinorSplit[] {
    switch (dto.splitType) {
      case EXPENSE_SPLIT_TYPE.EQUAL:
        if (dto.splits?.length) {
          throw new BadRequestException(
            'splits must be omitted for EQUAL split type',
          );
        }
        return this.splitEqual(totalMinor, memberIds);

      case EXPENSE_SPLIT_TYPE.CUSTOM:
        return this.splitCustom(dto, memberIds, totalMinor, decimals, currency);

      default:
        throw new BadRequestException('Invalid split type');
    }
  }

  /** Spreads the remainder one smallest unit at a time, so shares differ by ≤ 1. */
  private splitEqual(totalMinor: number, memberIds: string[]): MinorSplit[] {
    const base = Math.floor(totalMinor / memberIds.length);
    const remainder = totalMinor - base * memberIds.length;

    return memberIds.map((tripMemberId, index) => ({
      tripMemberId,
      minor: base + (index < remainder ? 1 : 0),
    }));
  }

  private splitCustom(
    dto: CreateExpenseDto,
    memberIds: string[],
    totalMinor: number,
    decimals: number,
    currency: CURRENCY,
  ): MinorSplit[] {
    if (!dto.splits?.length) {
      throw new BadRequestException('splits is required for this split type');
    }

    const validMemberIds = new Set(memberIds);

    for (const split of dto.splits) {
      if (!validMemberIds.has(split.tripMemberId)) {
        throw new BadRequestException(
          `Member ${split.tripMemberId} is not an active member`,
        );
      }
    }

    // Không cho cùng một member xuất hiện 2 lần
    const uniqueIds = new Set(dto.splits.map((split) => split.tripMemberId));

    if (uniqueIds.size !== dto.splits.length) {
      throw new BadRequestException('A member cannot appear more than once');
    }

    const splits = dto.splits.map((split) => ({
      tripMemberId: split.tripMemberId,
      minor: this.toMinorUnits(split.amount, decimals, currency),
    }));
    const splitTotal = splits.reduce((sum, split) => sum + split.minor, 0);
    if (splitTotal !== totalMinor) {
      throw new BadRequestException('Split amounts must equal expense amount');
    }

    return splits;
  }

  private toMinorUnits(
    amount: number,
    decimals: number,
    currency: CURRENCY,
  ): number {
    const scaled = amount * 10 ** decimals;
    const minor = Math.round(scaled);
    if (Math.abs(scaled - minor) > 1e-6) {
      throw new BadRequestException(
        `${currency} amounts allow at most ${decimals} decimal places`,
      );
    }
    return minor;
  }

  private fromMinorUnits(minor: number, decimals: number): Prisma.Decimal {
    return new Prisma.Decimal(minor).div(10 ** decimals);
  }

  private toListItem(
    expense: OverviewExpense,
    viewerUserId: string,
    overviewCurrency: CURRENCY,
  ): TripExpenseListItemDto {
    const decimals = CURRENCY_DECIMALS[expense.currency];
    const splitCount = expense.splits.length;
    const settledCount = expense.splits.filter((split) => split.isSettled).length;
    const amountPerPerson =
      expense.splitType === EXPENSE_SPLIT_TYPE.EQUAL && splitCount > 0
        ? expense.amount.toNumber() / splitCount
        : null;

    return {
      id: expense.id,
      tripId: expense.tripId,
      description: expense.description,
      amount: expense.amount.toFixed(Math.max(decimals, 2)),
      currency: expense.currency,
      category: expense.category,
      splitType: expense.splitType,
      spentAt: expense.spentAt.toISOString(),
      locationNote: expense.locationNote,
      createdAt: expense.createdAt.toISOString(),
      payerId: expense.payerId,
      payerIsViewer: expense.payer.userId === viewerUserId,
      payer: {
        id: expense.payer.id,
        userId: expense.payer.userId,
        displayName:
          expense.payer.user.displayname?.trim() || expense.payer.user.username,
        title: null,
        user: {
          id: expense.payer.user.id,
          username: expense.payer.user.username,
          avatarId: expense.payer.user.avatarId,
        },
      },
      splitCount,
      amountPerPerson,
      splitNote: buildSplitNote(expense, amountPerPerson, overviewCurrency),
      settledCount,
      status: settleStatusOf(settledCount, splitCount),
      splits: expense.splits.map((split) => ({
        id: split.id,
        expenseId: split.expenseId,
        tripMemberId: split.tripMemberId,
        amount: split.amount.toFixed(Math.max(decimals, 2)),
        isSettled: split.isSettled,
      })),
      receipts: this.mapReceipts(expense.receipts),
    };
  }

  private async resolvePayer(
    tx: Prisma.TransactionClient,
    tripId: string,
    actorMemberId: string,
    dto: CreateExpenseDto,
  ): Promise<{ id: string }> {
    if (!dto.payerTripMemberId || dto.payerTripMemberId === actorMemberId) {
      return { id: actorMemberId };
    }

    const payer = await tx.tripMember.findFirst({
      where: {
        id: dto.payerTripMemberId,
        tripId,
        status: MEMBER_STATUS.ACTIVE,
      },
      select: { id: true },
    });
    if (!payer) {
      throw new BadRequestException(
        'Payer must be an active member of this trip',
      );
    }
    return payer;
  }

  private resolveSpentAt(
    raw: string | undefined,
    trip: { startDate: Date; endDate: Date },
  ): Date {
    const spentAt = raw ? new Date(raw) : new Date();
    if (Number.isNaN(spentAt.getTime())) {
      throw new BadRequestException('spentAt must be a valid ISO date');
    }
    const earliest = new Date(trip.startDate);
    earliest.setUTCDate(earliest.getUTCDate() - 1);
    const latest = new Date();
    latest.setUTCDate(latest.getUTCDate() + 1);
    if (spentAt < earliest || spentAt > latest) {
      throw new BadRequestException(
        'spentAt must be within the trip window (start − 1 day to now + 1 day)',
      );
    }
    return spentAt;
  }

  private mapReceipts(
    receipts: Array<{
      mediaId: string;
      sortOrder: number;
      media: { objectKey: string };
    }>,
  ): TripExpenseReceiptDto[] {
    return receipts.map((receipt) => ({
      mediaId: receipt.mediaId,
      sortOrder: receipt.sortOrder,
      url: this.s3.getPublicUrl(receipt.media.objectKey),
    }));
  }

  private toCreateResponse(
    expense: {
      id: string;
      tripId: string;
      payerId: string;
      amount: Prisma.Decimal;
      currency: CURRENCY;
      category: EXPENSE_CATEGORY;
      splitType: EXPENSE_SPLIT_TYPE;
      description: string | null;
      spentAt: Date;
      locationNote: string | null;
      createdAt: Date;
      payer: OverviewExpense['payer'];
      splits: Array<{
        id: string;
        expenseId: string;
        tripMemberId: string;
        amount: Prisma.Decimal;
        isSettled: boolean;
        member: OverviewExpense['payer'];
      }>;
      receipts: OverviewExpense['receipts'];
    },
    decimals: number,
  ) {
    return {
      id: expense.id,
      tripId: expense.tripId,
      payerId: expense.payerId,
      amount: expense.amount.toFixed(Math.max(decimals, 2)),
      currency: expense.currency,
      category: expense.category,
      splitType: expense.splitType,
      description: expense.description,
      spentAt: expense.spentAt.toISOString(),
      locationNote: expense.locationNote,
      createdAt: expense.createdAt.toISOString(),
      payer: expense.payer,
      splits: expense.splits.map((split) => ({
        id: split.id,
        expenseId: split.expenseId,
        tripMemberId: split.tripMemberId,
        amount: split.amount.toFixed(Math.max(decimals, 2)),
        isSettled: split.isSettled,
        member: split.member,
      })),
      receipts: this.mapReceipts(expense.receipts),
    };
  }
}

function overviewCurrency(
  expenseCurrencies: CURRENCY[],
  budgetCurrency: string | null,
): CURRENCY {
  const fallback = isCurrency(budgetCurrency) ? budgetCurrency : CURRENCY.VND;
  if (expenseCurrencies.length === 0) return fallback;
  const distinct = new Set(expenseCurrencies);
  if (distinct.size === 1) return [...distinct][0];
  const counts = new Map<CURRENCY, number>();
  for (const currency of expenseCurrencies) {
    counts.set(currency, (counts.get(currency) ?? 0) + 1);
  }
  let best = fallback;
  let bestCount = -1;
  for (const [currency, count] of counts) {
    if (count > bestCount) {
      best = currency;
      bestCount = count;
    }
  }
  return best;
}

function isCurrency(value: string | null): value is CURRENCY {
  return Object.values<string>(CURRENCY).includes(value ?? '');
}

function settleStatusOf(
  settledCount: number,
  splitCount: number,
): TripExpenseSettleStatusDto {
  if (splitCount > 0 && settledCount >= splitCount) {
    return TripExpenseSettleStatusDto.SETTLED;
  }
  // Only the payer's auto-settled share (or nothing) → still waiting on others.
  if (settledCount <= 1) return TripExpenseSettleStatusDto.PENDING;
  return TripExpenseSettleStatusDto.PARTIAL;
}

function buildCategoryShares(
  expenses: OverviewExpense[],
  totalAmount: number,
): TripExpenseCategoryShareDto[] {
  const byCategory = new Map<EXPENSE_CATEGORY, number>();
  for (const expense of expenses) {
    byCategory.set(
      expense.category,
      (byCategory.get(expense.category) ?? 0) + expense.amount.toNumber(),
    );
  }
  const rows = [...byCategory.entries()]
    .map(([category, amount]) => ({ category, amount }))
    .sort((a, b) => b.amount - a.amount);
  if (rows.length === 0 || totalAmount <= 0) return [];

  const withFloor = rows.map((row) => {
    const exact = (row.amount / totalAmount) * 100;
    return { ...row, percent: Math.floor(exact), remainder: exact % 1 };
  });
  let leftover = 100 - withFloor.reduce((sum, row) => sum + row.percent, 0);
  withFloor
    .slice()
    .sort((a, b) => b.remainder - a.remainder)
    .forEach((row) => {
      if (leftover <= 0) return;
      row.percent += 1;
      leftover -= 1;
    });

  return withFloor.map(({ category, amount, percent }) => ({
    category,
    amount,
    percent,
  }));
}

function buildSettlements(
  expenses: OverviewExpense[],
  viewerUserId: string,
  memberNames: Map<string, string>,
): TripExpenseSettlementDto[] {
  const rows: TripExpenseSettlementDto[] = [];
  for (const expense of expenses) {
    for (const split of expense.splits) {
      if (split.isSettled) continue;
      if (split.tripMemberId === expense.payerId) continue;

      const fromName =
        memberNames.get(split.tripMemberId) ??
        split.member.user.displayname?.trim() ??
        split.member.user.username;
      const toName =
        memberNames.get(expense.payerId) ??
        expense.payer.user.displayname?.trim() ??
        expense.payer.user.username;
      const fromIsViewer = split.member.userId === viewerUserId;
      const toIsViewer = expense.payer.userId === viewerUserId;

      rows.push({
        id: split.id,
        fromMemberId: split.tripMemberId,
        fromDisplayName: fromIsViewer ? `${fromName} (Bạn)` : fromName,
        fromInitials: initialsOf(fromName),
        fromIsViewer,
        toMemberId: expense.payerId,
        toDisplayName: toIsViewer ? `${toName} (Bạn)` : toName,
        toIsViewer,
        amount: split.amount.toNumber(),
        note: expense.description,
        status: toIsViewer
          ? TripExpenseSettlementStatusDto.ACTIONABLE
          : TripExpenseSettlementStatusDto.PENDING,
        expenseId: expense.id,
        splitId: split.id,
      });
    }
  }

  return rows.sort((a, b) => {
    const aMine = a.toIsViewer || a.fromIsViewer ? 0 : 1;
    const bMine = b.toIsViewer || b.fromIsViewer ? 0 : 1;
    if (aMine !== bMine) return aMine - bMine;
    if (a.toIsViewer !== b.toIsViewer) return a.toIsViewer ? -1 : 1;
    return b.amount - a.amount;
  });
}

function buildSplitNote(
  expense: OverviewExpense,
  amountPerPerson: number | null,
  currency: CURRENCY,
): string {
  const count = expense.splits.length;
  if (expense.splitType === EXPENSE_SPLIT_TYPE.CUSTOM) {
    return 'Chia theo phần riêng';
  }
  if (amountPerPerson == null) return `Chia đều ${count} người`;
  return `${count} người • ${formatMoneyLabel(amountPerPerson, currency)}/người`;
}

function formatMoneyLabel(amount: number, currency: CURRENCY): string {
  const rounded = Math.round(amount);
  const digits = Math.abs(rounded).toString();
  const grouped = digits.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
  return currency === CURRENCY.VND ? `${grouped} đ` : `${grouped} ${currency}`;
}

function initialsOf(name: string): string {
  const words = name
    .trim()
    .split(/\s+/)
    .filter((word) => word.length > 0);
  if (words.length === 0) return '?';
  if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
  return `${words[0][0]}${words[words.length - 1][0]}`.toUpperCase();
}
