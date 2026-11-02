import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  RECRUITMENT_STATE,
  TRIP_VISIBILITY,
} from '../../../../../generated/prisma/enums';
import { RECRUITMENT_BLOCKERS } from '../recruitment.constants';

export class RecruitmentSummaryDto {
  @ApiProperty()
  activeRecruitmentCount!: number;
}

export class RecruitmentSummaryEnvelopeDto {
  @ApiProperty({ type: RecruitmentSummaryDto })
  data!: RecruitmentSummaryDto;

  @ApiProperty()
  message!: string;
}

export class PublishDraftDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  description!: string | null;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiPropertyOptional({ nullable: true })
  draftStep!: number | null;

  @ApiProperty({ format: 'date-time' })
  startDate!: Date;

  @ApiProperty({ format: 'date-time' })
  endDate!: Date;

  @ApiProperty()
  maxMembers!: number;

  @ApiPropertyOptional({ nullable: true })
  budgetLevel!: string | null;

  @ApiProperty({
    description: 'Publisher marked this draft as urgent recruitment',
  })
  urgent!: boolean;

  @ApiProperty({ format: 'date-time' })
  updatedAt!: Date;
}

export class RecruitmentMineTripDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  description!: string | null;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiProperty({ format: 'date-time' })
  startDate!: Date;

  @ApiProperty({ format: 'date-time' })
  endDate!: Date;

  @ApiProperty()
  maxMembers!: number;

  @ApiProperty()
  memberCount!: number;

  @ApiProperty()
  pendingRequestCount!: number;

  @ApiProperty()
  slotsRemaining!: number;

  @ApiPropertyOptional({ nullable: true })
  requirements!: string | null;

  @ApiPropertyOptional({ nullable: true })
  estimatedBudgetPerPerson!: string | null;

  @ApiPropertyOptional({ nullable: true })
  budgetLevel!: string | null;

  @ApiPropertyOptional({ nullable: true, format: 'date-time' })
  expiresAt!: Date | null;

  @ApiProperty({ enum: RECRUITMENT_STATE })
  effectiveState!: RECRUITMENT_STATE;

  @ApiProperty()
  canPublish!: boolean;

  @ApiProperty({ enum: RECRUITMENT_BLOCKERS, isArray: true })
  blockers!: string[];

  @ApiProperty({ type: [String] })
  destinationLabels!: string[];

  @ApiProperty({
    description: 'Publisher marked this post as urgent recruitment',
  })
  urgent!: boolean;
}

export class RecruitmentMineDto {
  @ApiProperty()
  activeRecruitmentCount!: number;

  @ApiPropertyOptional({ type: PublishDraftDto, nullable: true })
  latestPublishDraft!: PublishDraftDto | null;

  @ApiProperty({ type: [RecruitmentMineTripDto] })
  trips!: RecruitmentMineTripDto[];
}

export class RecruitmentMineEnvelopeDto {
  @ApiProperty({ type: RecruitmentMineDto })
  data!: RecruitmentMineDto;

  @ApiProperty()
  message!: string;
}

export class RecruitmentPublishResultDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty({ enum: RECRUITMENT_STATE })
  state!: RECRUITMENT_STATE;

  @ApiProperty({ enum: RECRUITMENT_STATE })
  effectiveState!: RECRUITMENT_STATE;

  @ApiPropertyOptional({ nullable: true, format: 'date-time' })
  publishedAt!: Date | null;

  @ApiPropertyOptional({ nullable: true, format: 'date-time' })
  expiresAt!: Date | null;

  @ApiProperty({ enum: TRIP_VISIBILITY })
  visibility!: TRIP_VISIBILITY;

  @ApiPropertyOptional({ enum: TRIP_VISIBILITY, nullable: true })
  previousVisibility!: TRIP_VISIBILITY | null;
}

export class RecruitmentPublishEnvelopeDto {
  @ApiProperty({ type: RecruitmentPublishResultDto })
  data!: RecruitmentPublishResultDto;

  @ApiProperty()
  message!: string;
}
