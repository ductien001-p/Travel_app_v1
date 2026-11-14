import {
  IsOptional,
  IsEnum,
  IsString,
  IsInt,
  Min,
  Max,
  IsBoolean,
} from 'class-validator';
import { Transform, Type } from 'class-transformer';
import {
  BudgetLevel,
  TRIP_TYPE,
  TRIP_VISIBILITY,
  TRIP_STATUS,
} from '../../../generated/prisma/client';

function toOptionalBoolean({ value }: { value: unknown }): boolean | undefined {
  if (value === undefined || value === null || value === '') {
    return undefined;
  }
  if (typeof value === 'boolean') {
    return value;
  }
  if (typeof value === 'string') {
    const normalized = value.trim().toLowerCase();
    if (normalized === 'true' || normalized === '1') {
      return true;
    }
    if (normalized === 'false' || normalized === '0') {
      return false;
    }
  }
  return value as boolean;
}

export class QueryTripDto {
  @IsOptional()
  @IsString()
  search?: string; // tìm theo name

  @IsOptional()
  @IsEnum(TRIP_TYPE)
  tripType?: TRIP_TYPE;

  @IsOptional()
  @IsEnum(TRIP_VISIBILITY)
  visibility?: TRIP_VISIBILITY;

  @IsOptional()
  @IsEnum(TRIP_STATUS)
  status?: TRIP_STATUS;

  @IsOptional()
  @IsEnum(BudgetLevel)
  budgetLevel?: BudgetLevel;

  @IsOptional()
  @IsString()
  ownerId?: string;

  /** Filter trips that include this DestinationCatalog id. */
  @IsOptional()
  @IsString()
  destinationCatalogId?: string;

  /**
   * Community Explore mode: PUBLIC + UPCOMING only, exclude trips the
   * caller already owns or has joined as an ACTIVE member.
   */
  @IsOptional()
  @Transform(toOptionalBoolean)
  @IsBoolean()
  discover?: boolean;

  /**
   * Only trips the caller owns or has joined as an ACTIVE member.
   * Omits public trips the caller cannot edit.
   */
  @IsOptional()
  @Transform(toOptionalBoolean)
  @IsBoolean()
  mine?: boolean;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page?: number = 1;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number = 20;
}
