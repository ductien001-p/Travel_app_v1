import { OmitType, PartialType } from '@nestjs/mapped-types';
import { CreateTripDto } from './create-trip.dto';
import {
  ArrayMaxSize,
  IsArray,
  IsBoolean,
  IsString,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { TripDestinationInputDto } from './trip-destinations.dto';
import { IsOptionalNonNull } from './is-optional-non-null.decorator';
import { MAX_DESTINATIONS_PER_TRIP } from './trip.constants';

// skipNullProperties: false -> required fields may be omitted but not cleared
// with null (e.g. city, maxMembers); nullable ones keep @IsOptional.
export class UpdateTripDestinationDto extends PartialType(
  OmitType(TripDestinationInputDto, ['pendingPlaceIds'] as const),
  { skipNullProperties: false },
) {
  @IsString()
  id!: string;
}

export class UpdateTripDto extends PartialType(
  OmitType(CreateTripDto, ['destinations'] as const),
  { skipNullProperties: false },
) {
  @IsOptionalNonNull()
  @IsArray()
  @ArrayMaxSize(MAX_DESTINATIONS_PER_TRIP)
  @ValidateNested({ each: true })
  @Type(() => TripDestinationInputDto)
  addDestinations?: TripDestinationInputDto[];

  @IsOptionalNonNull()
  @IsArray()
  @ArrayMaxSize(MAX_DESTINATIONS_PER_TRIP)
  @IsString({ each: true })
  removeDestinationIds?: string[];

  @IsOptionalNonNull()
  @IsArray()
  @ArrayMaxSize(MAX_DESTINATIONS_PER_TRIP)
  @ValidateNested({ each: true })
  @Type(() => UpdateTripDestinationDto)
  updateDestinations?: UpdateTripDestinationDto[];

  @IsOptionalNonNull()
  @IsBoolean()
  acknowledgeRecruitmentImpact?: boolean;
}
