import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  TRIP_MISSION_GROUP,
  TRIP_MISSION_VERIFY,
} from '../../../../../generated/prisma/enums';

export class TripMissionItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  code!: string;

  @ApiProperty({ enum: TRIP_MISSION_GROUP })
  group!: TRIP_MISSION_GROUP;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  subtitle!: string;

  @ApiProperty()
  icon!: string;

  @ApiProperty({ enum: TRIP_MISSION_VERIFY })
  verifyType!: TRIP_MISSION_VERIFY;

  @ApiProperty({ minimum: 0 })
  pointsReward!: number;

  @ApiProperty({ minimum: 0 })
  progressCurrent!: number;

  @ApiProperty({ minimum: 1 })
  progressTarget!: number;

  @ApiProperty()
  completed!: boolean;

  @ApiProperty({ enum: ['ITINERARY', 'MEMORIES'] })
  cta!: 'ITINERARY' | 'MEMORIES';
}

export class TripMissionsPageDto {
  @ApiProperty({ minimum: 0 })
  completedCount!: number;

  @ApiProperty({ minimum: 0 })
  totalCount!: number;

  @ApiProperty({
    minimum: 0,
    description: 'Sum of pointsReward for completed missions (uncapped display)',
  })
  missionPointsEarned!: number;

  @ApiProperty({ minimum: 0, example: 80 })
  missionPointsCap!: number;

  @ApiProperty({
    minimum: 0,
    description: 'Points that would settle at completion after cap',
  })
  missionPointsPending!: number;

  @ApiProperty({ type: [TripMissionItemDto] })
  items!: TripMissionItemDto[];
}

export class TripMissionsEnvelopeResponseDto {
  @ApiProperty({ type: TripMissionsPageDto })
  data!: TripMissionsPageDto;

  @ApiProperty({ example: 'Trip missions retrieved successfully' })
  message!: string;
}

export class TripDetailMissionsPreviewDto {
  @ApiProperty({ minimum: 0 })
  completedCount!: number;

  @ApiProperty({ minimum: 0 })
  totalCount!: number;

  @ApiProperty({ minimum: 0 })
  missionPointsPending!: number;

  @ApiProperty({ minimum: 0, example: 80 })
  missionPointsCap!: number;

  @ApiProperty({ type: [TripMissionItemDto] })
  items!: TripMissionItemDto[];
}

export class TravelTierNextDto {
  @ApiProperty()
  code!: string;

  @ApiProperty()
  multiplier!: number;

  @ApiProperty({ minimum: 0 })
  tripsRemaining!: number;

  @ApiProperty({ minimum: 0 })
  citiesRemaining!: number;
}

export class TravelTierDto {
  @ApiProperty()
  code!: string;

  @ApiProperty()
  label!: string;

  @ApiProperty()
  multiplier!: number;

  @ApiProperty({ minimum: 0 })
  tripsCompleted!: number;

  @ApiProperty({ minimum: 0 })
  distinctCities!: number;

  @ApiPropertyOptional({ type: TravelTierNextDto, nullable: true })
  next!: TravelTierNextDto | null;
}

export class AchievementProgressDto {
  @ApiProperty()
  code!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  rarity!: string;

  @ApiProperty({ minimum: 0 })
  current!: number;

  @ApiProperty({ minimum: 1 })
  target!: number;

  @ApiProperty()
  unlocked!: boolean;
}
