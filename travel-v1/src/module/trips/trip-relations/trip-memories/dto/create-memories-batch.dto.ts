import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  ValidateNested,
} from 'class-validator';

import { CreateMemoryDto } from './create-memories.dto';

/** Upper bound of photos added in one request (one timeline card). */
export const MAX_MEMORIES_PER_BATCH = 20;

export class CreateMemoriesBatchDto {
  @ApiProperty({
    type: [CreateMemoryDto],
    minItems: 1,
    maxItems: MAX_MEMORIES_PER_BATCH,
  })
  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(MAX_MEMORIES_PER_BATCH)
  @ValidateNested({ each: true })
  @Type(() => CreateMemoryDto)
  items!: CreateMemoryDto[];
}
