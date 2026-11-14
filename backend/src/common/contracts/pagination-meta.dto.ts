import { ApiProperty } from '@nestjs/swagger';

export class PaginationMetaDto {
  @ApiProperty({ minimum: 1, example: 1 })
  page!: number;

  @ApiProperty({ minimum: 1, maximum: 100, example: 20 })
  limit!: number;

  @ApiProperty({ minimum: 0, example: 42 })
  total!: number;

  @ApiProperty({ minimum: 0, example: 3 })
  totalPages!: number;

  @ApiProperty()
  hasNextPage!: boolean;

  @ApiProperty()
  hasPreviousPage!: boolean;
}

export function createPaginationMeta(
  page: number,
  limit: number,
  total: number,
): PaginationMetaDto {
  const totalPages = Math.ceil(total / limit);
  return {
    page,
    limit,
    total,
    totalPages,
    hasNextPage: page < totalPages,
    hasPreviousPage: page > 1,
  };
}

export class CursorMetaDto {
  @ApiProperty({ nullable: true, example: 'cm123', type: String })
  nextCursor!: string | null;

  @ApiProperty()
  hasMore!: boolean;
}
