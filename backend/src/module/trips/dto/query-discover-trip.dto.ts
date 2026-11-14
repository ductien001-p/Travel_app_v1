import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Matches,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';
import {
  DISCOVER_CATEGORIES,
  type DiscoverCategory,
} from '../trip-discover/trip-discover.where';

export class QueryDiscoverTripDto {
  @ApiPropertyOptional({ enum: DISCOVER_CATEGORIES, default: 'all' })
  @IsOptional()
  @IsIn(DISCOVER_CATEGORIES)
  category: DiscoverCategory = 'all';

  /** Stable for one Home visit. A new visit or pull-to-refresh sends a new seed. */
  @ApiProperty({ minLength: 8, maxLength: 64, example: 'a1b2c3d4e5f67890' })
  @IsString()
  @MinLength(8)
  @MaxLength(64)
  @Matches(/^[A-Za-z0-9_-]+$/)
  seed!: string;

  /** Viewer offset in minutes, used for the weekend category. Default UTC+7. */
  @ApiPropertyOptional({ minimum: -840, maximum: 840, default: 420 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(-14 * 60)
  @Max(14 * 60)
  timezoneOffsetMinutes: number = 420;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(200)
  search?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(64)
  destinationCatalogId?: string;

  @ApiPropertyOptional({ minimum: 1, default: 1 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page: number = 1;

  @ApiPropertyOptional({ minimum: 1, maximum: 100, default: 20 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit: number = 20;
}
