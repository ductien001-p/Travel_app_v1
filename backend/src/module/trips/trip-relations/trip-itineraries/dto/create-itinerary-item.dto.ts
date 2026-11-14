import {
  IsBoolean,
  IsDateString,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  Max,
  Min,
  MaxLength,
} from 'class-validator';
import { Transform } from 'class-transformer';
import {
  ACTIVITY_COST_DECIMALS,
  MAX_ACTIVITY_COST,
  MAX_ACTIVITY_DURATION_MINUTES,
  MAX_ACTIVITY_TITLE_LENGTH,
} from './activity.constants';

export class CreateItineraryItemDto {
  @IsString()
  @IsNotEmpty()
  dayId!: string;

  @IsString()
  @IsNotEmpty()
  placeId!: string;

  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @IsNotEmpty()
  @MaxLength(MAX_ACTIVITY_TITLE_LENGTH)
  title!: string;

  @IsOptional()
  @IsString()
  @MaxLength(300)
  notes?: string;

  @IsOptional()
  @IsDateString()
  startTime?: string;

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(MAX_ACTIVITY_DURATION_MINUTES)
  estimatedDuration?: number;

  @IsOptional()
  @IsNumber({ maxDecimalPlaces: ACTIVITY_COST_DECIMALS })
  @Min(0)
  @Max(MAX_ACTIVITY_COST)
  estimatedCost?: number;

  /**
   * @deprecated Ignored: check-in completion is computed by the server.
   * Still accepted so older clients are not rejected by forbidNonWhitelisted.
   */
  @IsOptional()
  @IsBoolean()
  isCheckin?: boolean;

  /**
   * Relative order among the items sent for the same day. The stored
   * orderIndex is assigned by the server after the day's existing activities.
   */
  @IsOptional()
  @IsInt()
  @Min(0)
  orderIndex?: number;
}
