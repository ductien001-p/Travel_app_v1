import { Type } from 'class-transformer';
import {
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
} from 'class-validator';
import { MAX_TRIP_DAYS } from '../../../policies/destination.policy';

export class QueryMemoriesDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(50)
  limit: number = 20;

  /** Memory id of the last item; only valid with the filters it was issued for. */
  @IsOptional()
  @IsString()
  cursor?: string;

  /** 1-based trip day, counted in UTC from the trip start date. */
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(MAX_TRIP_DAYS)
  day?: number;

  /** Only photos uploaded by this user. */
  @IsOptional()
  @IsString()
  @IsNotEmpty()
  @MaxLength(64)
  userId?: string;
}
