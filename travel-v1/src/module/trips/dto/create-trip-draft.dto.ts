import { PartialType } from '@nestjs/mapped-types';
import { Type } from 'class-transformer';
import { ArrayMaxSize, IsArray, ValidateNested } from 'class-validator';
import { IsOptionalNonNull } from './is-optional-non-null.decorator';
import { CreateTripDto } from './create-trip.dto';
import { TripDestinationInputDto } from './trip-destinations.dto';
import { MAX_DESTINATIONS_PER_TRIP } from './trip.constants';

/**
 * A draft intentionally accepts an incomplete first step. Final validation is
 * performed by POST /trips/:tripId/finalize.
 */
export class CreateTripDraftDto extends PartialType(CreateTripDto, {
  skipNullProperties: false,
}) {
  @IsOptionalNonNull()
  @IsArray()
  @ArrayMaxSize(MAX_DESTINATIONS_PER_TRIP)
  @ValidateNested({ each: true })
  @Type(() => TripDestinationInputDto)
  destinations?: TripDestinationInputDto[];
}
