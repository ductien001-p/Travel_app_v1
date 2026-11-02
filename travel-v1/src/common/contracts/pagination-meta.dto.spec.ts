import { createPaginationMeta } from './pagination-meta.dto';
import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { PaginationDto } from '../../module/users/dto/pagination.dto';

describe('createPaginationMeta', () => {
  it('returns stable navigation flags', () => {
    expect(createPaginationMeta(2, 20, 45)).toEqual({
      page: 2,
      limit: 20,
      total: 45,
      totalPages: 3,
      hasNextPage: true,
      hasPreviousPage: true,
    });
  });

  it('handles an empty result', () => {
    expect(createPaginationMeta(1, 20, 0)).toEqual({
      page: 1,
      limit: 20,
      total: 0,
      totalPages: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    });
  });

  it('transforms query strings and rejects an excessive limit', async () => {
    const dto = plainToInstance(PaginationDto, { page: '2', limit: '101' });
    expect(dto.page).toBe(2);
    expect(dto.limit).toBe(101);
    const errors = await validate(dto);
    expect(errors.some((error) => error.property === 'limit')).toBe(true);
  });
});
