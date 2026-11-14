import { ApiProperty } from '@nestjs/swagger';
import { TRAVEL_DNA_TYPE } from '../../generated/prisma/enums';

export class TravelDnaRadarBadgeResponseDto {
  @ApiProperty({ enum: TRAVEL_DNA_TYPE })
  type!: TRAVEL_DNA_TYPE;

  @ApiProperty({ example: 'Foodie Traveler' })
  name!: string;

  @ApiProperty({ example: '🍜' })
  icon!: string;

  @ApiProperty({ example: 'You love discovering local food and cuisine.' })
  description!: string;

  @ApiProperty({ example: 88 })
  score!: number;

  @ApiProperty({ example: 0 })
  tripTypeCount!: number;

  @ApiProperty({ example: 16 })
  activityCount!: number;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;

  @ApiProperty({ format: 'date-time' })
  updatedAt!: string;

  @ApiProperty({ example: 'Ẩm Thực' })
  shortLabel!: string;

  @ApiProperty({ example: 'Bậc thầy vị giác' })
  badgeTitle!: string;
}

export class TravelDnaRadarDnaResponseDto {
  @ApiProperty({ type: TravelDnaRadarBadgeResponseDto, nullable: true })
  dominant!: TravelDnaRadarBadgeResponseDto | null;

  @ApiProperty({ type: [TravelDnaRadarBadgeResponseDto] })
  topBadges!: TravelDnaRadarBadgeResponseDto[];

  @ApiProperty({ type: [TravelDnaRadarBadgeResponseDto] })
  all!: TravelDnaRadarBadgeResponseDto[];
}

export class TravelDnaRadarCommunityResponseDto {
  @ApiProperty({ enum: TRAVEL_DNA_TYPE })
  type!: TRAVEL_DNA_TYPE;

  @ApiProperty({ example: 62, description: 'Rounded mean of scores above 0.' })
  averageScore!: number;

  @ApiProperty({ minimum: 0, example: 40 })
  sampleCount!: number;
}

export class TravelDnaRadarPlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ example: 'Cao lầu Hội An' })
  name!: string;

  @ApiProperty({ example: 'Hội An' })
  city!: string;
}

export class TravelDnaRadarFitPlacesResponseDto {
  @ApiProperty({ enum: TRAVEL_DNA_TYPE })
  type!: TRAVEL_DNA_TYPE;

  @ApiProperty({ type: [TravelDnaRadarPlaceResponseDto] })
  places!: TravelDnaRadarPlaceResponseDto[];
}

export class TravelDnaRadarJourneyResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty({ example: 'Khám phá ẩm thực Hội An' })
  name!: string;

  @ApiProperty({ minimum: 0, maximum: 100, example: 92 })
  matchPercent!: number;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  coverImageUrl!: string | null;

  @ApiProperty({ minimum: 0, example: 8 })
  activityCount!: number;
}

export class TravelDnaRadarPersonaResponseDto {
  @ApiProperty({ example: 'Foodie Traveler' })
  name!: string;

  @ApiProperty({ example: '🍜' })
  icon!: string;
}

export class TravelDnaRadarCompanionResponseDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty({ example: 'Lan Phương' })
  displayName!: string;

  @ApiProperty({ example: 'lanphuong' })
  username!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  avatarUrl!: string | null;

  @ApiProperty({ minimum: 70, maximum: 100, example: 94 })
  matchPercent!: number;

  @ApiProperty({ type: TravelDnaRadarPersonaResponseDto })
  persona!: TravelDnaRadarPersonaResponseDto;
}

export class TravelDnaRadarResponseDto {
  @ApiProperty({ type: TravelDnaRadarDnaResponseDto })
  dna!: TravelDnaRadarDnaResponseDto;

  @ApiProperty({ type: [TravelDnaRadarCommunityResponseDto] })
  community!: TravelDnaRadarCommunityResponseDto[];

  @ApiProperty({
    type: Number,
    nullable: true,
    minimum: 0,
    maximum: 100,
    description:
      'Percent of scores on the dominant type that are lower than the viewer. Null when that type has fewer than 20 scores.',
  })
  dominantPercentile!: number | null;

  @ApiProperty({ type: [TravelDnaRadarFitPlacesResponseDto] })
  fitPlaces!: TravelDnaRadarFitPlacesResponseDto[];

  @ApiProperty({ type: TravelDnaRadarJourneyResponseDto, nullable: true })
  journey!: TravelDnaRadarJourneyResponseDto | null;

  @ApiProperty({ type: [TravelDnaRadarCompanionResponseDto] })
  companions!: TravelDnaRadarCompanionResponseDto[];
}

export class TravelDnaRadarEnvelopeResponseDto {
  @ApiProperty({ type: TravelDnaRadarResponseDto })
  data!: TravelDnaRadarResponseDto;

  @ApiProperty({ example: 'Travel DNA radar retrieved successfully' })
  message!: string;
}
