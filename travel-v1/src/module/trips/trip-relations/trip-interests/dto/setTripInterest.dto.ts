import {
  IsArray,
  ArrayMaxSize,
  ArrayNotEmpty,
  IsString,
} from 'class-validator';
import { MAX_INTERESTS_PER_TRIP } from '../../../dto/trip.constants';

export class SetTripInterestsDto {
  @IsArray()
  @ArrayNotEmpty()
  @ArrayMaxSize(MAX_INTERESTS_PER_TRIP)
  @IsString({ each: true })
  interestIds!: string[];
}
