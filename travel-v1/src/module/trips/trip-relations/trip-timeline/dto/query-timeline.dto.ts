import { ApiPropertyOptional } from '@nestjs/swagger';

import { Type } from 'class-transformer';

import { IsIn, IsInt, IsOptional, IsString, Max, Min } from 'class-validator';

import { TIMELINE_CATEGORIES } from '../timeline-category';
import type { TimelineCategory } from '../timeline-category';

export class QueryTripTimelineDto {
  @ApiPropertyOptional({
    minimum: 1,
    maximum: 100,
    default: 30,
  })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit: number = 30;

  @ApiPropertyOptional({
    description: 'Opaque cursor returned by the previous response',
  })
  @IsOptional()
  @IsString()
  cursor?: string;

  @ApiPropertyOptional({
    enum: TIMELINE_CATEGORIES,
    description:
      'Only return events of this group. Omit to return every event. The cursor must come from a response with the same category.',
  })
  @IsOptional()
  @IsIn(TIMELINE_CATEGORIES)
  category?: TimelineCategory;
}
