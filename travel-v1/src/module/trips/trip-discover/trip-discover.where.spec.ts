import {
  BudgetLevel,
  PLACE_CATEGORY,
  TRIP_TYPE,
} from '../../../generated/prisma/enums';
import {
  buildDiscoverCategoryWhere,
  buildDiscoverListWhere,
  weekendWindow,
} from './trip-discover.where';

describe('weekendWindow', () => {
  const offset = 420;

  it('uses the coming Saturday and Sunday before the weekend', () => {
    const window = weekendWindow(new Date('2026-10-21T03:00:00.000Z'), offset);
    expect(window.start.toISOString()).toBe('2026-10-23T17:00:00.000Z');
    expect(window.end.toISOString()).toBe('2026-10-25T16:59:59.999Z');
  });

  it('keeps the weekend that is already in progress on Sunday', () => {
    const window = weekendWindow(new Date('2026-10-25T05:00:00.000Z'), offset);
    expect(window.start.toISOString()).toBe('2026-10-23T17:00:00.000Z');
    expect(window.end.toISOString()).toBe('2026-10-25T16:59:59.999Z');
  });

  it('moves to the next weekend after Sunday', () => {
    const window = weekendWindow(new Date('2026-10-26T03:00:00.000Z'), offset);
    expect(window.start.toISOString()).toBe('2026-10-30T17:00:00.000Z');
    expect(window.end.toISOString()).toBe('2026-11-01T16:59:59.999Z');
  });
});

describe('buildDiscoverCategoryWhere', () => {
  const now = new Date('2026-10-21T03:00:00.000Z');

  it('does not add a filter for all', () => {
    expect(buildDiscoverCategoryWhere('all', now, 420)).toEqual({});
  });

  it('filters backpacker, budget, beach, camping, and weekend before ranking', () => {
    expect(buildDiscoverCategoryWhere('backpacker', now, 420)).toEqual({
      tripType: TRIP_TYPE.BACKPACKER,
    });
    expect(buildDiscoverCategoryWhere('budget', now, 420)).toEqual({
      budgetLevel: BudgetLevel.LOW,
    });
    expect(buildDiscoverCategoryWhere('beach', now, 420)).toEqual({
      OR: [
        {
          destinations: {
            some: {
              destinationType: {
                equals: PLACE_CATEGORY.BEACH,
                mode: 'insensitive',
              },
            },
          },
        },
        {
          itineraryItems: {
            some: { place: { category: PLACE_CATEGORY.BEACH } },
          },
        },
      ],
    });
    expect(buildDiscoverCategoryWhere('camping', now, 420)).toEqual({
      OR: [
        {
          destinations: {
            some: {
              destinationType: {
                equals: PLACE_CATEGORY.CAMPING,
                mode: 'insensitive',
              },
            },
          },
        },
        {
          itineraryItems: {
            some: { place: { category: PLACE_CATEGORY.CAMPING } },
          },
        },
      ],
    });
    expect(buildDiscoverCategoryWhere('weekend', now, 420)).toEqual({
      startDate: {
        gte: new Date('2026-10-23T17:00:00.000Z'),
        lte: new Date('2026-10-25T16:59:59.999Z'),
      },
    });
  });
});

describe('buildDiscoverListWhere', () => {
  it('keeps the public recruiting discover constraint with the category', () => {
    const where = buildDiscoverListWhere({
      userId: 'user-1',
      now: new Date('2026-10-24T00:00:00.000Z'),
      category: 'beach',
      timezoneOffsetMinutes: 420,
      search: 'Cô Tô',
      destinationCatalogId: 'catalog-1',
    });
    expect(where.AND).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          visibility: 'PUBLIC',
          status: 'UPCOMING',
          NOT: {
            OR: [
              { ownerId: 'user-1' },
              {
                members: {
                  some: { userId: 'user-1', status: 'ACTIVE' },
                },
              },
            ],
          },
        }),
        expect.objectContaining({
          OR: expect.arrayContaining([
            expect.objectContaining({
              destinations: expect.objectContaining({
                some: expect.objectContaining({
                  destinationType: expect.objectContaining({ equals: 'BEACH' }),
                }),
              }),
            }),
          ]),
        }),
        { name: { contains: 'Cô Tô', mode: 'insensitive' } },
        { destinations: { some: { destinationId: 'catalog-1' } } },
      ]),
    );
  });
});
