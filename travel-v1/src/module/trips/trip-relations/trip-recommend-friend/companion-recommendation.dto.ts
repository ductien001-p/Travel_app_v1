import { ApiProperty } from '@nestjs/swagger';
import { INVITATION_STATUS } from '../../../../generated/prisma/enums';

export class CompanionRecommendationUserDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  displayname!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty({ nullable: true, type: String })
  avatarId!: string | null;
}

export class CompanionRecommendationDto {
  @ApiProperty({ type: CompanionRecommendationUserDto })
  user!: CompanionRecommendationUserDto;

  @ApiProperty({ minimum: 0 })
  tripsTogetherCount!: number;

  @ApiProperty({ enum: INVITATION_STATUS, nullable: true })
  invitationStatus!: INVITATION_STATUS | null;

  @ApiProperty({
    nullable: true,
    type: String,
    example: 'Beach Lover 🏖️',
    description: 'Strongest Travel DNA badge of the friend',
  })
  travelPersona!: string | null;

  @ApiProperty({
    nullable: true,
    type: Number,
    minimum: 0,
    maximum: 100,
    description:
      'Fit between the friend Travel DNA and this trip. Null when either side has nothing to compare.',
  })
  matchScore!: number | null;

  @ApiProperty({
    nullable: true,
    type: String,
    format: 'date-time',
    description:
      'Later of the friendship date and the latest direct message with the owner',
  })
  lastInteractionAt!: Date | null;
}

export class CompanionRecommendationsResponseDto {
  @ApiProperty({ type: [CompanionRecommendationDto] })
  data!: CompanionRecommendationDto[];

  @ApiProperty({
    nullable: true,
    type: String,
    example: 'Beach Lover 🏖️',
    description: 'Travel DNA this trip leans toward most',
  })
  tripTravelPersona!: string | null;

  @ApiProperty({ example: 'Recommended friends retrieved successfully' })
  message!: string;
}
