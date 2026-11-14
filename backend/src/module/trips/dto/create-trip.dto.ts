import {
  IsString,
  IsOptional,
  IsEnum,
  IsInt,
  MaxLength,
  Min,
  IsArray,
  ValidateNested,
  Max,
  Length,
  IsNumberString,
  IsNotEmpty,
  ArrayMaxSize,
} from 'class-validator';
import { Type } from 'class-transformer';
import {
  MAX_DESTINATIONS_PER_TRIP,
  MAX_INTERESTS_PER_TRIP,
} from './trip.constants';
import {
  BudgetLevel,
  TRIP_TYPE,
  TRIP_VISIBILITY,
} from '../../../generated/prisma/client';
import { TripDestinationInputDto } from './trip-destinations.dto';
import { IsOptionalNonNull } from './is-optional-non-null.decorator';

export class CreateTripDto {
  @IsString()
  @MaxLength(80)
  name!: string;

  @IsOptional()
  @IsString()
  @MaxLength(2000)
  description?: string;

  @IsOptional()
  @IsNumberString()
  estimatedBudgetPerPerson?: string;

  @IsOptional()
  @IsString()
  @Length(3, 3)
  budgetCurrency?: string;

  @IsOptional()
  @IsEnum(BudgetLevel)
  budgetLevel?: BudgetLevel;

  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  maxMembers!: number;

  @IsOptionalNonNull()
  @IsEnum(TRIP_TYPE)
  tripType?: TRIP_TYPE;

  @IsOptionalNonNull()
  @IsEnum(TRIP_VISIBILITY)
  visibility?: TRIP_VISIBILITY;

  @IsArray()
  @ArrayMaxSize(MAX_DESTINATIONS_PER_TRIP)
  @ValidateNested({ each: true })
  @Type(() => TripDestinationInputDto)
  destinations!: TripDestinationInputDto[];

  @IsOptionalNonNull()
  @IsArray()
  @ArrayMaxSize(MAX_INTERESTS_PER_TRIP)
  @IsString({ each: true })
  interestIds?: string[];

  @IsString()
  @IsNotEmpty()
  coverMediaId!: string;
}
