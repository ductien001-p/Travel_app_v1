import { Transform, Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayUnique,
  IsArray,
  IsDate,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
} from 'class-validator';
import { toCalendarDate } from './calendar-date.transform';
import { MAX_PENDING_PLACES_PER_DESTINATION } from './trip.constants';

const trim = ({ value }: { value: unknown }) =>
  typeof value === 'string' ? value.trim() : value;

export class TripDestinationInputDto {
  @IsOptional()
  @IsString()
  @IsNotEmpty()
  destinationId?: string;

  @Transform(trim)
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  country!: string;

  @Transform(trim)
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  city!: string;

  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  lat!: number;

  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  lng!: number;

  @IsInt()
  order!: number;

  /** `yyyy-MM-dd`; a full ISO datetime is accepted but only its date part is kept. */
  @Transform(toCalendarDate)
  @IsDate()
  startDate!: Date;

  /** `yyyy-MM-dd`; a full ISO datetime is accepted but only its date part is kept. */
  @Transform(toCalendarDate)
  @IsDate()
  endDate!: Date;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(MAX_PENDING_PLACES_PER_DESTINATION)
  @ArrayUnique()
  @IsUUID(undefined, { each: true })
  pendingPlaceIds?: string[];
}
