import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsNumber,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

export class FindFriendsQueryDto {
  @ApiPropertyOptional({
    description: 'Search by display name or username (with optional leading @).',
    minLength: 1,
    maxLength: 100,
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(100)
  q?: string;

  @ApiPropertyOptional({
    description: 'Viewer latitude for nearby suggestions (optional override).',
    minimum: -90,
    maximum: 90,
  })
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  lat?: number;

  @ApiPropertyOptional({
    description: 'Viewer longitude for nearby suggestions (optional override).',
    minimum: -180,
    maximum: 180,
  })
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  lng?: number;
}

export enum FindFriendsActionDto {
  ADD_FRIEND = 'ADD_FRIEND',
  REQUEST_SENT = 'REQUEST_SENT',
  MESSAGE = 'MESSAGE',
  FOLLOW = 'FOLLOW',
  FOLLOWING = 'FOLLOWING',
}

export enum FindFriendsBadgeToneDto {
  AMBER = 'AMBER',
  TEAL = 'TEAL',
  INDIGO = 'INDIGO',
  ROSE = 'ROSE',
  PRIMARY = 'PRIMARY',
  PRIMARY_SOFT = 'PRIMARY_SOFT',
  SUBDUED = 'SUBDUED',
}

export enum FindFriendsContactChipToneDto {
  PRIMARY = 'PRIMARY',
  SECONDARY = 'SECONDARY',
}

export class FindFriendsBadgeResponseDto {
  @ApiProperty()
  label!: string;

  @ApiProperty({ enum: FindFriendsBadgeToneDto })
  tone!: FindFriendsBadgeToneDto;

  @ApiPropertyOptional({ nullable: true })
  icon?: string | null;
}

export class FindFriendsUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  displayName!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({ nullable: true })
  avatarUrl!: string | null;

  @ApiProperty()
  isOnline!: boolean;

  @ApiProperty()
  verified!: boolean;

  @ApiProperty({ enum: FindFriendsActionDto })
  action!: FindFriendsActionDto;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Pending outbound friend request id when action is REQUEST_SENT.',
  })
  friendRequestId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  conversationId!: string | null;

  @ApiProperty({ type: [FindFriendsBadgeResponseDto] })
  badges!: FindFriendsBadgeResponseDto[];

  @ApiPropertyOptional({ nullable: true })
  metaIcon!: string | null;

  @ApiPropertyOptional({ nullable: true })
  metaLine!: string | null;

  @ApiPropertyOptional({ nullable: true })
  travelPersona!: string | null;

  @ApiPropertyOptional({ nullable: true })
  dnaMatchPercent!: number | null;

  @ApiPropertyOptional({ nullable: true })
  sharedTripsCount!: number | null;
}

export class FindFriendsNearbySuggestionResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({ nullable: true })
  avatarUrl!: string | null;

  @ApiProperty({ example: 'Đang ở gần bạn (1.2km)' })
  subtitle!: string;

  @ApiProperty({ example: 'Cùng thích Camp' })
  chipLabel!: string;

  @ApiProperty({ enum: FindFriendsContactChipToneDto })
  chipTone!: FindFriendsContactChipToneDto;

  @ApiProperty({ enum: FindFriendsActionDto })
  action!: FindFriendsActionDto;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Pending outbound friend request id when action is REQUEST_SENT.',
  })
  friendRequestId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  distanceKm!: number | null;
}

export class FindFriendsDnaBannerResponseDto {
  @ApiProperty({ example: 'TRAVEL DNA MATCH' })
  badgeLabel!: string;

  @ApiProperty({ example: 'Tìm Bạn Đồng Hành Hợp Gu 95%+' })
  title!: string;

  @ApiProperty()
  subtitle!: string;

  @ApiProperty({ example: 'Quét DNA ngay' })
  ctaLabel!: string;

  @ApiProperty({ example: 42 })
  extraCount!: number;

  @ApiProperty({ type: [String] })
  previewAvatars!: string[];
}

export class FindFriendsPageResponseDto {
  @ApiProperty()
  query!: string;

  @ApiProperty()
  matchCount!: number;

  @ApiProperty({ example: '4 tìm kiếm khớp' })
  matchCountLabel!: string;

  @ApiProperty({
    type: [String],
    description: 'Always empty from server; client owns recent search history.',
  })
  recentSearches!: string[];

  @ApiProperty({ type: FindFriendsDnaBannerResponseDto })
  dnaBanner!: FindFriendsDnaBannerResponseDto;

  @ApiProperty({ type: [FindFriendsUserResponseDto] })
  results!: FindFriendsUserResponseDto[];

  @ApiProperty({
    type: [FindFriendsNearbySuggestionResponseDto],
    description: 'Nearby discovery suggestions (not phone contacts).',
  })
  nearbySuggestions!: FindFriendsNearbySuggestionResponseDto[];
}

export class FindFriendsEnvelopeResponseDto {
  @ApiProperty({ type: FindFriendsPageResponseDto })
  data!: FindFriendsPageResponseDto;

  @ApiProperty({ example: 'Find friends retrieved successfully' })
  message!: string;
}
