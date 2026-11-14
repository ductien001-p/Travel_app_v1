// dto/update-activity.dto.ts
import {
  IsString,
  IsOptional,
  IsInt,
  IsNumber,
  Max,
  Min,
  IsDateString,
  MaxLength,
} from 'class-validator';
import {
  ACTIVITY_COST_DECIMALS,
  MAX_ACTIVITY_COST,
  MAX_ACTIVITY_DURATION_MINUTES,
  MAX_ACTIVITY_TITLE_LENGTH,
} from './activity.constants';

export class UpdateActivityDto {
  @IsOptional()
  @IsString()
  @MaxLength(MAX_ACTIVITY_TITLE_LENGTH)
  title?: string;

  @IsOptional()
  @IsString()
  @MaxLength(300)
  notes?: string | null;

  @IsOptional()
  @IsString()
  placeId?: string;

  @IsOptional()
  @IsDateString()
  startTime?: string | null;

  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(MAX_ACTIVITY_DURATION_MINUTES)
  estimatedDuration?: number | null;

  @IsOptional()
  @IsNumber({ maxDecimalPlaces: ACTIVITY_COST_DECIMALS })
  @Min(0)
  @Max(MAX_ACTIVITY_COST)
  estimatedCost?: number | null;
}
