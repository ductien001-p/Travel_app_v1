// dto/create-activity.dto.ts
import {
  IsString,
  IsOptional,
  IsInt,
  IsNumber,
  Max,
  Min,
  IsDateString,
  IsNotEmpty,
  MaxLength,
} from 'class-validator';
import { Transform } from 'class-transformer';
import {
  ACTIVITY_COST_DECIMALS,
  MAX_ACTIVITY_COST,
  MAX_ACTIVITY_DURATION_MINUTES,
  MAX_ACTIVITY_TITLE_LENGTH,
} from './activity.constants';

export class CreateActivityDto {
  @IsString()
  @IsNotEmpty()
  placeId!: string;

  @IsOptional()
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @IsNotEmpty()
  @MaxLength(MAX_ACTIVITY_TITLE_LENGTH)
  title?: string;

  @IsOptional()
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @MaxLength(300)
  notes?: string;

  @IsOptional()
  @IsDateString()
  startTime?: string;

  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(MAX_ACTIVITY_DURATION_MINUTES)
  estimatedDuration?: number;

  @IsOptional()
  @IsNumber({ maxDecimalPlaces: ACTIVITY_COST_DECIMALS })
  @Min(0)
  @Max(MAX_ACTIVITY_COST)
  estimatedCost?: number;

  /** Omit both anchors to append at the end of the day. */
  @IsOptional()
  @IsString()
  insertAfterActivityId?: string;

  /** Use the day's first activity to insert at the start of the day. */
  @IsOptional()
  @IsString()
  insertBeforeActivityId?: string;
}
