import {
  DestinationPolicy,
  MAX_DESTINATION_DAYS,
  MAX_TRIP_DAYS,
} from './destination.policy';

describe('DestinationPolicy length limits', () => {
  const tooLong = expect.objectContaining({
    response: expect.objectContaining({ code: 'RANGE_TOO_LONG' }),
  });

  it(`accepts a destination of exactly ${MAX_DESTINATION_DAYS} days`, () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-10-01', endDate: '2026-10-30' },
      ]),
    ).not.toThrow();
  });

  it(`rejects a destination longer than ${MAX_DESTINATION_DAYS} days`, () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-10-01', endDate: '2026-10-31' },
      ]),
    ).toThrow(tooLong);
  });

  it('applies the destination limit to a single persisted range', () => {
    expect(() =>
      DestinationPolicy.validatePersistedDateRange(
        new Date('2026-10-01T00:00:00.000Z'),
        new Date('2026-11-15T00:00:00.000Z'),
      ),
    ).toThrow(tooLong);
  });

  it(`accepts a trip of exactly ${MAX_TRIP_DAYS} days`, () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-01-01', endDate: '2026-01-30' },
        { order: 2, startDate: '2026-01-31', endDate: '2026-03-01' },
        { order: 3, startDate: '2026-03-02', endDate: '2026-03-31' },
      ]),
    ).not.toThrow();
  });

  it(`rejects a trip longer than ${MAX_TRIP_DAYS} days`, () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-01-01', endDate: '2026-01-05' },
        { order: 2, startDate: '2026-03-30', endDate: '2026-04-02' },
      ]),
    ).toThrow(tooLong);
  });
});

describe('DestinationPolicy.validateTimeline', () => {
  it('accepts destinations whose order follows the travel dates', () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-10-01', endDate: '2026-10-03' },
        { order: 2, startDate: '2026-10-04', endDate: '2026-10-06' },
      ]),
    ).not.toThrow();
  });

  it('rejects an order that goes back in time', () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-10-10', endDate: '2026-10-12' },
        { order: 2, startDate: '2026-10-01', endDate: '2026-10-03' },
      ]),
    ).toThrow(
      expect.objectContaining({
        response: expect.objectContaining({
          code: 'DESTINATION_ORDER_INVALID',
        }),
      }),
    );
  });

  it('rejects a non-adjacent overlap hidden behind a later destination', () => {
    expect(() =>
      DestinationPolicy.validateTimeline([
        { order: 1, startDate: '2026-10-01', endDate: '2026-10-03' },
        { order: 2, startDate: '2026-10-10', endDate: '2026-10-12' },
        { order: 3, startDate: '2026-10-02', endDate: '2026-10-04' },
      ]),
    ).toThrow(
      expect.objectContaining({
        response: expect.objectContaining({
          code: 'DESTINATION_ORDER_INVALID',
        }),
      }),
    );
  });
});
