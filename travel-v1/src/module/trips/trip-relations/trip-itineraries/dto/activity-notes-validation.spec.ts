import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { CreateActivityDto } from './create-activity.dto';
import { CreateItineraryItemDto } from './create-itinerary-item.dto';
import { UpdateActivityDto } from './update-activity.dto';

describe('activity notes validation', () => {
  it.each([
    [CreateActivityDto, { placeId: 'place-1' }],
    [UpdateActivityDto, {}],
    [
      CreateItineraryItemDto,
      {
        dayId: 'day-1',
        placeId: 'place-1',
        title: 'Lunch',
        orderIndex: 0,
      },
    ],
  ])('%p rejects notes longer than 300 characters', async (Dto, base) => {
    const dto = plainToInstance(Dto, { ...base, notes: 'x'.repeat(301) });
    const errors = await validate(dto);
    expect(errors.some((error) => error.property === 'notes')).toBe(true);
  });

  it('accepts exactly 300 characters after trimming create input', async () => {
    const dto = plainToInstance(CreateActivityDto, {
      placeId: 'place-1',
      notes: `  ${'x'.repeat(300)}  `,
    });
    const errors = await validate(dto);
    expect(errors).toHaveLength(0);
    expect(dto.notes).toHaveLength(300);
  });
});
