import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { TRIP_STATUS, TRIP_VISIBILITY } from '../../../generated/prisma/enums';

export class TripListDestinationDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  country!: string;

  @ApiProperty()
  lat!: number;

  @ApiProperty()
  lng!: number;

  @ApiProperty()
  order!: number;

  @ApiProperty()
  startDate!: Date;

  @ApiProperty()
  endDate!: Date;

  @ApiPropertyOptional({
    nullable: true,
    example: 'BEACH',
    description:
      'Snapshot of DestinationCatalog.type, for example BEACH. Null when the stop has no catalog type.',
  })
  destinationType!: string | null;
}

export class TripListNextActivityDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  startTime!: Date | null;
}

export class TripListMemberPreviewDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({ nullable: true, format: 'uri' })
  avatarUrl!: string | null;
}

export class TripListOwnerDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  displayname!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({ nullable: true, format: 'uri' })
  avatarUrl!: string | null;
}

export class TripListItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  description!: string | null;

  @ApiProperty()
  startDate!: Date;

  @ApiProperty()
  endDate!: Date;

  @ApiPropertyOptional({
    nullable: true,
    example: 'MEDIUM',
  })
  budgetLevel!: string | null;

  @ApiProperty()
  maxMembers!: number;

  @ApiProperty({
    example: 'FRIENDS',
  })
  tripType!: string;

  @ApiProperty({
    enum: TRIP_VISIBILITY,
  })
  visibility!: TRIP_VISIBILITY;

  @ApiProperty({
    enum: TRIP_STATUS,
  })
  status!: TRIP_STATUS;

  @ApiProperty({
    type: [TripListDestinationDto],
  })
  destinations!: TripListDestinationDto[];

  @ApiProperty()
  memberCount!: number;

  @ApiProperty({ type: [TripListMemberPreviewDto] })
  memberPreviews!: TripListMemberPreviewDto[];

  @ApiPropertyOptional({
    type: TripListOwnerDto,
    nullable: true,
  })
  owner!: TripListOwnerDto | null;

  @ApiProperty({
    description: 'True when memberCount is below maxMembers',
  })
  recruiting!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Public URL generated from coverMedia.objectKey',
  })
  coverImageUrl!: string | null;

  @ApiProperty({
    description:
      'Total number of TripCheckin records across activities in the trip',
  })
  checkinCount!: number;

  @ApiProperty()
  totalActivities!: number;

  @ApiProperty()
  completedActivities!: number;

  @ApiProperty({
    minimum: 0,
    maximum: 100,
  })
  progressPercent!: number;

  @ApiPropertyOptional({
    type: TripListNextActivityDto,
    nullable: true,
    description: 'Hidden from non-members, including discover cards',
  })
  nextActivity!: TripListNextActivityDto | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Present on discover cards for an effective-open post',
  })
  requirements?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Per-person budget on an effective-open post',
  })
  estimatedBudgetPerPerson?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Open seats on an effective-open post',
  })
  slotsRemaining?: number | null;

  @ApiPropertyOptional({
    nullable: true,
    format: 'date-time',
    description: 'When the effective-open post leaves the feed',
  })
  expiresAt?: Date | null;

  @ApiPropertyOptional({
    description:
      'Publisher marked this effective-open post as urgent recruitment',
  })
  urgent?: boolean;
}
