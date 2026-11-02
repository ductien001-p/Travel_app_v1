import 'reflect-metadata';
import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { TripDestinationInputDto } from './trip-destinations.dto';
import { UpdateTripDestinationDto, UpdateTripDto } from './update-trip.dto';
import { CreateTripDraftDto } from './create-trip-draft.dto';
import { MAX_DESTINATIONS_PER_TRIP } from './trip.constants';

const destination = {
  country: 'Vietnam',
  city: 'Da Nang',
  lat: 16.0544,
  lng: 108.2022,
  order: 1,
  startDate: '2026-10-10',
  endDate: '2026-10-12',
};

// Mirrors the global ValidationPipe options in main.ts.
const pipeOptions = { whitelist: true, forbidNonWhitelisted: true };

describe('TripDestinationInputDto (UTC only)', () => {
  it('accepts a destination without any timezone', async () => {
    const errors = await validate(
      plainToInstance(TripDestinationInputDto, destination),
      pipeOptions,
    );
    expect(errors).toHaveLength(0);
  });

  it('rejects the removed timeZone field', async () => {
    const errors = await validate(
      plainToInstance(TripDestinationInputDto, {
        ...destination,
        timeZone: 'Asia/Ho_Chi_Minh',
      }),
      pipeOptions,
    );
    expect(errors.map((error) => error.property)).toEqual(['timeZone']);
  });
});

describe('UpdateTripDestinationDto', () => {
  it('rejects the removed timeZone field', async () => {
    const errors = await validate(
      plainToInstance(UpdateTripDestinationDto, {
        id: 'destination-1',
        timeZone: 'Asia/Ho_Chi_Minh',
      }),
      pipeOptions,
    );
    expect(errors.map((error) => error.property)).toEqual(['timeZone']);
  });

  it.each(['city', 'country', 'lat', 'startDate'])(
    'rejects clearing the required %s with null',
    async (property) => {
      const errors = await validate(
        plainToInstance(UpdateTripDestinationDto, {
          id: 'destination-1',
          [property]: null,
        }),
      );
      expect(errors.map((error) => error.property)).toContain(property);
    },
  );
});

describe('TripDestinationInputDto dates', () => {
  function datesOf(input: object) {
    return plainToInstance(TripDestinationInputDto, {
      ...destination,
      ...input,
    });
  }

  it.each([
    ['a plain date', '2026-10-10'],
    ['midnight with a positive offset', '2026-10-10T00:00:00+07:00'],
    ['late evening with a negative offset', '2026-10-10T23:30:00-05:00'],
    ['UTC midnight', '2026-10-10T00:00:00.000Z'],
  ])(
    'keeps the calendar day the client wrote for %s',
    async (_label, value) => {
      const dto = datesOf({ startDate: value });

      expect(await validate(dto)).toHaveLength(0);
      expect(dto.startDate.toISOString()).toBe('2026-10-10T00:00:00.000Z');
    },
  );

  it.each(['2026-02-30', '2026-13-01', '10/10/2026', '2026-10-10Tnope', 42])(
    'rejects %p',
    async (value) => {
      const errors = await validate(datesOf({ startDate: value }));
      expect(errors.map((error) => error.property)).toContain('startDate');
    },
  );
});

describe('TripDestinationInputDto text fields', () => {
  it('trims city and country', () => {
    const dto = plainToInstance(TripDestinationInputDto, {
      ...destination,
      city: '  Hoi An ',
      country: ' Vietnam ',
    });
    expect(dto.city).toBe('Hoi An');
    expect(dto.country).toBe('Vietnam');
  });

  it.each(['city', 'country'])('rejects a blank %s', async (property) => {
    const errors = await validate(
      plainToInstance(TripDestinationInputDto, {
        ...destination,
        [property]: '   ',
      }),
    );
    expect(errors.map((error) => error.property)).toContain(property);
  });
});

describe('UpdateTripDto nullability', () => {
  async function errorsFor(input: object) {
    const errors = await validate(plainToInstance(UpdateTripDto, input));
    return errors.map((error) => error.property);
  }

  it.each([
    'name',
    'maxMembers',
    'tripType',
    'visibility',
    'coverMediaId',
    'interestIds',
    'addDestinations',
    'removeDestinationIds',
    'updateDestinations',
  ])('rejects null for %s', async (property) => {
    expect(await errorsFor({ [property]: null })).toContain(property);
  });

  it.each(['description', 'budgetLevel', 'estimatedBudgetPerPerson'])(
    'still lets the nullable %s be cleared',
    async (property) => {
      expect(await errorsFor({ [property]: null })).not.toContain(property);
    },
  );

  it('accepts an empty partial update', async () => {
    expect(await errorsFor({})).toHaveLength(0);
  });

  it('caps the number of destinations per request', async () => {
    expect(
      await errorsFor({
        removeDestinationIds: Array.from(
          { length: MAX_DESTINATIONS_PER_TRIP + 1 },
          (_, index) => `d-${index}`,
        ),
      }),
    ).toContain('removeDestinationIds');
  });
});

describe('CreateTripDraftDto nullability', () => {
  it.each(['tripType', 'visibility', 'destinations', 'interestIds'])(
    'rejects null for %s',
    async (property) => {
      const errors = await validate(
        plainToInstance(CreateTripDraftDto, { [property]: null }),
      );
      expect(errors.map((error) => error.property)).toContain(property);
    },
  );

  it('accepts an empty draft', async () => {
    expect(
      await validate(plainToInstance(CreateTripDraftDto, {})),
    ).toHaveLength(0);
  });
});
