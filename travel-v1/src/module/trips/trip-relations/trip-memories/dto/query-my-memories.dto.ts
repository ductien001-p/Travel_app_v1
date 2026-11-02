import { Type } from 'class-transformer';
import {
  IsInt,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  ValidateIf,
} from 'class-validator';

export class QueryMyMemoriesDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(50)
  limit: number = 20;

  /** Memory id of the last item; only valid with the filters it was issued for. */
  @IsOptional()
  @IsString()
  @MaxLength(64)
  cursor?: string;

  /** Empty means every trip the viewer belongs to. */
  @IsOptional()
  @IsString()
  @MaxLength(64)
  tripId?: string;

  /** Caption search. Blank is ignored. */
  @IsOptional()
  @IsString()
  @MaxLength(100)
  q?: string;

  /** Viewer's calendar year. Required together with [month]. */
  @ValidateIf(
    (dto: QueryMyMemoriesDto) =>
      dto.year !== undefined || dto.month !== undefined,
  )
  @Type(() => Number)
  @IsInt()
  @Min(2000)
  @Max(2100)
  year?: number;

  /** Viewer's calendar month, 1-12. Required together with [year]. */
  @ValidateIf(
    (dto: QueryMyMemoriesDto) =>
      dto.year !== undefined || dto.month !== undefined,
  )
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(12)
  month?: number;

  /**
   * Minutes east of UTC for the viewer's device clock. The highlight month
   * is this calendar month, not the UTC month. Defaults to UTC.
   */
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(-840)
  @Max(840)
  utcOffsetMinutes: number = 0;
}
