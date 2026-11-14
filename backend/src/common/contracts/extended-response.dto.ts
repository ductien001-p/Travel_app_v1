import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { CursorMetaDto, PaginationMetaDto } from './pagination-meta.dto';
import {
  BudgetLevel,
  CURRENCY,
  EXPENSE_CATEGORY,
  EXPENSE_SPLIT_TYPE,
  FRIEND_REQUEST_STATUS,
  HOST_STATUS,
  INVITATION_STATUS,
  JOIN_REQUEST_STATUS,
  MEMBER_STATUS,
  RANK,
  SocialPostVisibility,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRAVEL_DNA_TYPE,
  TRIP_ROLE,
  TRIP_STATUS,
  TRIP_TYPE,
  TRIP_VISIBILITY,
} from '../../generated/prisma/browser';
import { MEMORY_BADGE_LABELS } from '../../module/trips/trip-relations/trip-memories/memory-badge/memory-badge.constants';
import {
  AchievementProgressDto,
  TravelTierDto,
  TripDetailMissionsPreviewDto,
} from '../../module/trips/trip-relations/trip-missions/dto/trip-mission-response.dto';

export {
  AchievementProgressDto,
  TravelTierDto,
  TripDetailMissionsPreviewDto,
  TripMissionItemDto,
  TripMissionsPageDto,
} from '../../module/trips/trip-relations/trip-missions/dto/trip-mission-response.dto';

export class MessageResponseDto {
  @ApiProperty()
  message!: string;
}

export class SuccessResponseDto {
  @ApiProperty()
  success!: boolean;
}

export class BatchResultResponseDto {
  @ApiProperty({ minimum: 0 })
  count!: number;
}

export class DeviceTokenResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  installationId!: string;

  @ApiProperty({ description: 'Push-provider device token.' })
  token!: string;

  @ApiProperty({ enum: ['IOS', 'ANDROID', 'WEB'] })
  platform!: string;

  @ApiProperty({ nullable: true, type: String })
  deviceName!: string | null;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;
}

export class PresignedUploadItemResponseDto {
  @ApiProperty({ format: 'uri' })
  url!: string;

  @ApiProperty({ type: 'object', additionalProperties: { type: 'string' } })
  headers!: Record<string, string>;

  @ApiProperty()
  key!: string;
}

export class PresignedUploadsResponseDto {
  @ApiProperty({ enum: ['PUT'] })
  method!: 'PUT';

  @ApiProperty({ minimum: 1 })
  expiresIn!: number;

  @ApiProperty({ type: [PresignedUploadItemResponseDto] })
  uploads!: PresignedUploadItemResponseDto[];
}

export class SessionTokensResponseDto {
  @ApiProperty()
  accessToken!: string;

  @ApiProperty()
  refreshToken!: string;
}

export class AuthTokensResponseDto extends SessionTokensResponseDto {
  @ApiProperty()
  id!: string;
}

export class PublicUserBriefResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty({ nullable: true, type: String })
  avatarId!: string | null;
}

export class PublicUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty()
  displayname!: string;

  @ApiProperty({ nullable: true, type: String })
  avatarId!: string | null;

  @ApiProperty({ nullable: true, type: String })
  bio!: string | null;

  @ApiProperty({ nullable: true, type: String })
  location!: string | null;

  @ApiProperty({ nullable: true, type: String })
  gender!: string | null;

  @ApiProperty({ nullable: true, enum: ['LOW', 'MEDIUM', 'HIGH'] })
  budgetLevel!: string | null;

  @ApiProperty({ type: [String] })
  languages!: string[];

  @ApiProperty({ type: [String] })
  interests!: string[];

  @ApiProperty({
    minimum: 0,
    example: 12,
  })
  visitedCount!: number;
}

/** Profile of the authenticated user. Includes contact fields hidden from other users. */
export class MeUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty()
  displayname!: string;

  @ApiProperty()
  email!: string;

  @ApiProperty({ nullable: true, type: String })
  phone!: string | null;

  @ApiProperty({ nullable: true, type: String })
  address!: string | null;

  @ApiProperty({ nullable: true, type: String })
  avatarId!: string | null;

  @ApiProperty({ nullable: true, type: String })
  bio!: string | null;

  @ApiProperty({ nullable: true, type: String })
  location!: string | null;

  @ApiProperty({ nullable: true, type: String })
  gender!: string | null;

  @ApiProperty({ nullable: true, type: String })
  dateofBirth!: string | null;

  @ApiProperty({ nullable: true, enum: ['LOW', 'MEDIUM', 'HIGH'] })
  budgetLevel!: string | null;

  @ApiProperty({ type: [Object] })
  travelStyle!: object[];

  @ApiProperty({ type: [String] })
  languages!: string[];

  @ApiProperty({ type: [String] })
  interests!: string[];

  @ApiProperty()
  notificationEnabled!: boolean;

  @ApiProperty({
    minimum: 0,
    example: 12,
  })
  visitedCount!: number;
}

export class MeUserEnvelopeResponseDto {
  @ApiProperty({
    type: MeUserResponseDto,
  })
  data!: MeUserResponseDto;

  @ApiProperty({
    example: 'User retrieved successfully',
  })
  message!: string;
}
export class PublicUserEnvelopeResponseDto {
  @ApiProperty({
    type: PublicUserResponseDto,
  })
  data!: PublicUserResponseDto;

  @ApiProperty({
    example: 'User retrieved successfully',
  })
  message!: string;
}
export class CreatedUserDataResponseDto {
  @ApiProperty()
  id!: string;
}

export class CreateUserResponseDto {
  @ApiProperty({
    type: CreatedUserDataResponseDto,
  })
  data!: CreatedUserDataResponseDto;

  @ApiProperty({
    example: 'User created successfully',
  })
  message!: string;
}
export class UserActionResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'User deleted successfully',
  })
  message!: string;
}

export class PublicUsersPageResponseDto {
  @ApiProperty({ type: [PublicUserResponseDto] })
  data!: PublicUserResponseDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;
}

export class UserSearchResultResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty()
  displayname!: string;

  @ApiProperty({ nullable: true, type: String })
  avatarId!: string | null;
}

export class UserSearchPageResponseDto {
  @ApiProperty({ type: [UserSearchResultResponseDto] })
  data!: UserSearchResultResponseDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;
}
//==========================================ACTIVITIES===========================================
export class ItineraryPlaceResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() name!: string;
  @ApiPropertyOptional({ nullable: true }) description!: string | null;
  @ApiProperty() category!: string;
  @ApiProperty() city!: string;
  @ApiProperty() country!: string;
  @ApiProperty() address!: string;
  @ApiProperty() latitude!: number;
  @ApiProperty() longitude!: number;
  @ApiPropertyOptional({ nullable: true, format: 'uri' })
  imageUrl?: string | null;
}

export class ActivityResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  dayId!: string;

  @ApiProperty()
  placeId!: string;

  @ApiProperty()
  title!: string;

  @ApiPropertyOptional({ nullable: true })
  notes!: string | null;

  @ApiProperty({ nullable: true, type: String, format: 'date-time' })
  startTime!: string | null;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'Decimal serialized as a base-10 string.',
  })
  estimatedCost!: string | null;

  @ApiProperty({ nullable: true, type: Number })
  estimatedDuration!: number | null;

  @ApiProperty()
  isCheckin!: boolean;

  @ApiProperty()
  orderIndex!: number;

  @ApiProperty({ type: ItineraryPlaceResponseDto })
  place!: ItineraryPlaceResponseDto;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;

  @ApiProperty({ format: 'date-time' })
  updatedAt!: string;
}
export class ActivityEnvelopeResponseDto {
  @ApiProperty({
    type: ActivityResponseDto,
  })
  data!: ActivityResponseDto;

  @ApiProperty({
    example: 'Activity created successfully',
  })
  message!: string;
}
export class ItineraryItemsBatchResponseDto {
  @ApiProperty() success!: boolean;
  @ApiProperty({ minimum: 0 }) createdCount!: number;
  @ApiProperty({ type: [ActivityResponseDto] }) items!: ActivityResponseDto[];
}
export class ItineraryDayResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  destinationId!: string;

  @ApiProperty()
  dayNumber!: number;

  @ApiProperty({
    format: 'date-time',
  })
  date!: string;

  @ApiProperty({
    type: [ActivityResponseDto],
  })
  activities!: ActivityResponseDto[];

  @ApiProperty({
    example: {
      activityCount: 5,
      estimatedDurationMinutes: 420,
      estimatedCost: '1250000.00',
    },
  })
  summary!: {
    activityCount: number;
    estimatedDurationMinutes: number;
    estimatedCost: string;
  };
}
export class DestinationItineraryResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiPropertyOptional({ nullable: true })
  destinationId?: string | null;

  @ApiPropertyOptional({ nullable: true })
  destinationType?: string | null;

  @ApiProperty({ type: [String] })
  highlights!: string[];

  @ApiPropertyOptional({ nullable: true, format: 'uri' })
  coverImageUrl?: string | null;

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

  @ApiProperty({
    format: 'date-time',
  })
  startDate!: string;

  @ApiProperty({
    format: 'date-time',
  })
  endDate!: string;

  @ApiProperty({
    type: [ItineraryDayResponseDto],
  })
  itineraryDays!: ItineraryDayResponseDto[];
}
export class DestinationItineraryEnvelopeResponseDto {
  @ApiProperty({
    type: DestinationItineraryResponseDto,
  })
  data!: DestinationItineraryResponseDto;

  @ApiProperty({
    example: 'Destination itinerary retrieved successfully',
  })
  message!: string;
}
export class TripItineraryEnvelopeResponseDto {
  @ApiProperty({
    type: [DestinationItineraryResponseDto],
  })
  data!: DestinationItineraryResponseDto[];

  @ApiProperty({
    example: { canManageItinerary: true },
  })
  permissions!: {
    canManageItinerary: boolean;
  };

  @ApiProperty({
    example: 'Itinerary retrieved successfully',
  })
  message!: string;
}
export class ItineraryActionResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty()
  message!: string;
}
export class TripCompletionStatusResponseDto {
  @ApiProperty({
    minimum: 0,
    example: 10,
  })
  totalActivities!: number;

  @ApiProperty({
    minimum: 0,
    example: 7,
  })
  completedActivities!: number;

  @ApiProperty({
    minimum: 0,
    maximum: 100,
    example: 70,
  })
  progressPercent!: number;

  @ApiProperty({
    example: false,
  })
  isTripCompleted!: boolean;
}

export class TripCompletionStatusEnvelopeResponseDto {
  @ApiProperty({
    type: TripCompletionStatusResponseDto,
  })
  data!: TripCompletionStatusResponseDto;

  @ApiProperty({
    example: 'Trip completion status retrieved successfully',
  })
  message!: string;
}
export class TripCheckinResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  placeId!: string;

  @ApiProperty()
  memberId!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  activityId!: string | null;

  @ApiProperty()
  latitude!: number;

  @ApiProperty()
  longitude!: number;

  @ApiProperty({ format: 'date-time' })
  visitedAt!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;
}

export class TripCheckinEnvelopeResponseDto {
  @ApiProperty({
    type: TripCheckinResponseDto,
  })
  data!: TripCheckinResponseDto;

  @ApiProperty({
    example: 'Check-in successful',
  })
  message!: string;
}
export class ViewerCheckinResponseDto {
  @ApiPropertyOptional({ nullable: true, type: String })
  activityId!: string | null;

  @ApiProperty()
  placeId!: string;

  @ApiProperty({ format: 'date-time' })
  visitedAt!: string;
}
export class ViewerCheckinsEnvelopeResponseDto {
  @ApiProperty({ type: [ViewerCheckinResponseDto] })
  data!: ViewerCheckinResponseDto[];

  @ApiProperty({ example: 'Check-ins retrieved successfully' })
  message!: string;
}
export class DayRouteLegResponseDto {
  @ApiProperty()
  fromActivityId!: string;

  @ApiProperty()
  toActivityId!: string;

  @ApiProperty()
  available!: boolean;

  @ApiPropertyOptional({ nullable: true, type: Number, minimum: 0 })
  distanceMeters!: number | null;

  @ApiPropertyOptional({ nullable: true, type: Number, minimum: 0 })
  durationSeconds!: number | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'Google encoded polyline',
  })
  polyline!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    enum: [
      'MISSING_COORDINATES',
      'PROVIDER_UNAVAILABLE',
      'STOP_LIMIT_EXCEEDED',
    ],
  })
  unavailableReason!:
    | 'MISSING_COORDINATES'
    | 'PROVIDER_UNAVAILABLE'
    | 'STOP_LIMIT_EXCEEDED'
    | null;
}
export class DayRouteResponseDto {
  @ApiProperty()
  dayId!: string;

  @ApiProperty({ description: 'True when every leg has route data' })
  available!: boolean;

  @ApiProperty({ minimum: 0, description: 'Sum over available legs' })
  totalDistanceMeters!: number;

  @ApiProperty({ minimum: 0, description: 'Sum over available legs' })
  totalDurationSeconds!: number;

  @ApiProperty({ type: [DayRouteLegResponseDto] })
  legs!: DayRouteLegResponseDto[];
}
export class DayRouteEnvelopeResponseDto {
  @ApiProperty({ type: DayRouteResponseDto })
  data!: DayRouteResponseDto;

  @ApiProperty({ example: 'Day route retrieved successfully' })
  message!: string;
}
export class TripShareLinkResponseDto {
  @ApiProperty({ format: 'uri' })
  url!: string;

  @ApiProperty({ format: 'date-time' })
  expiresAt!: string;
}
export class TripShareLinkEnvelopeResponseDto {
  @ApiProperty({ type: TripShareLinkResponseDto })
  data!: TripShareLinkResponseDto;

  @ApiProperty({ example: 'Share link created successfully' })
  message!: string;
}
export class TripShareRevokeResponseDto {
  @ApiProperty({ minimum: 0 })
  revokedCount!: number;
}
export class TripShareRevokeEnvelopeResponseDto {
  @ApiProperty({ type: TripShareRevokeResponseDto })
  data!: TripShareRevokeResponseDto;

  @ApiProperty({ example: 'Share links revoked successfully' })
  message!: string;
}
export class SharedTripSummaryResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty({ enum: TRIP_STATUS, enumName: 'TRIP_STATUS' })
  status!: TRIP_STATUS;

  @ApiPropertyOptional({ nullable: true, format: 'uri', type: String })
  coverImageUrl!: string | null;
}
export class SharedItineraryResponseDto {
  @ApiProperty({ type: SharedTripSummaryResponseDto })
  trip!: SharedTripSummaryResponseDto;

  @ApiProperty({ type: [DestinationItineraryResponseDto] })
  destinations!: DestinationItineraryResponseDto[];

  @ApiProperty({ example: { canManageItinerary: false } })
  permissions!: { canManageItinerary: boolean };

  @ApiProperty({ example: { isMember: false } })
  viewer!: { isMember: boolean };
}
export class SharedItineraryEnvelopeResponseDto {
  @ApiProperty({ type: SharedItineraryResponseDto })
  data!: SharedItineraryResponseDto;

  @ApiProperty({ example: 'Shared itinerary retrieved successfully' })
  message!: string;
}
//===========================================PLACES===========================================
export class PlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ nullable: true, type: String })
  description!: string | null;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  country!: string;

  @ApiProperty()
  address!: string;

  @ApiProperty()
  latitude!: number;

  @ApiProperty()
  longitude!: number;

  @ApiProperty()
  category!: string;

  @ApiProperty({ enum: ['APPROVED'] })
  status!: string;

  @ApiProperty()
  averageRating!: number;

  @ApiProperty({ type: [String] })
  coverImageUrls!: string[];

  @ApiProperty({ minimum: 0 })
  vistedCount!: number;
}

export class PlacesPageResponseDto {
  @ApiProperty({ type: [PlaceResponseDto] })
  data!: PlaceResponseDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;
}
export class PlaceEnvelopeResponseDto {
  @ApiProperty({
    type: PlaceResponseDto,
  })
  data!: PlaceResponseDto;

  @ApiProperty({
    example: 'Place retrieved successfully',
  })
  message!: string;
}
export class PendingPlacesPageResponseDto {
  @ApiProperty({
    type: [PlaceResponseDto],
  })
  data!: PlaceResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}
export class PlaceSearchResultResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  description!: string | null;

  @ApiProperty()
  latitude!: number;

  @ApiProperty()
  longitude!: number;

  @ApiProperty()
  similarity!: number;

  @ApiPropertyOptional({ nullable: true })
  distance_km!: number | null;

  @ApiPropertyOptional({ nullable: true })
  category!: string | null;

  @ApiPropertyOptional({ nullable: true })
  address!: string | null;

  @ApiPropertyOptional({ nullable: true })
  averageRating!: number | null;

  @ApiProperty()
  reviewCount!: number;

  @ApiProperty()
  saveCount!: number;

  @ApiProperty()
  bookmarked!: boolean;

  @ApiPropertyOptional({ nullable: true, format: 'uri' })
  thumbnailUrl!: string | null;
}

export class PlaceSearchResponseDto {
  @ApiProperty({
    type: [PlaceSearchResultResponseDto],
  })
  data!: PlaceSearchResultResponseDto[];

  @ApiProperty({
    example: 'Places searched successfully',
  })
  message!: string;
}
export class PlaceDeleteResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Place deleted successfully',
  })
  message!: string;
}
//===========================================UPLOADS===========================================
export class UploadedMediaResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  objectKey!: string;

  @ApiProperty({ nullable: true, type: String })
  userId!: string | null;

  @ApiProperty({ nullable: true, type: String })
  mimeType!: string | null;

  @ApiPropertyOptional({ nullable: true })
  fileSize?: number | null;

  @ApiPropertyOptional({ nullable: true })
  width?: number | null;

  @ApiPropertyOptional({ nullable: true })
  height?: number | null;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;
}
//===========================================MEDIA===========================================
export class MediaUrlResponseDto {
  @ApiProperty({ format: 'uri' })
  url!: string;
}

export class MediaUrlEnvelopeResponseDto {
  @ApiProperty({
    type: MediaUrlResponseDto,
  })
  data!: MediaUrlResponseDto;

  @ApiProperty({
    example: 'Media URL retrieved successfully',
  })
  message!: string;
}
//=======================================FOLLOW=================================
export class FollowResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() followerId!: string;
  @ApiProperty() followingId!: string;
  @ApiProperty({ format: 'date-time' }) createdAt!: string;
}
export class FollowUserSummaryResponseDto {
  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  avatarId!: string | null;
}
export class FollowWithUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  followerId!: string;

  @ApiProperty()
  followingId!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    type: FollowUserSummaryResponseDto,
  })
  follower!: FollowUserSummaryResponseDto;
}
export class FollowersPageResponseDto {
  @ApiProperty({
    type: [FollowWithUserResponseDto],
  })
  data!: FollowWithUserResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}

export class FollowEnvelopeResponseDto {
  @ApiProperty({
    type: FollowResponseDto,
  })
  data!: FollowResponseDto;

  @ApiProperty({
    example: 'Followed user successfully',
  })
  message!: string;
}

//FRIENDS===================================================================
export class FriendUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty({
    description: 'Display name (falls back to username when empty)',
  })
  displayName!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarUrl!: string | null;

  @ApiProperty({
    default: false,
  })
  isOnline!: boolean;

  @ApiProperty({
    default: false,
  })
  verified!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  subtitle?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  metaIcon?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  metaLine?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  badgeLabel?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    enum: ['PRIMARY', 'SECONDARY', 'SUBDUED', 'INFO'],
  })
  badgeTone?: 'PRIMARY' | 'SECONDARY' | 'SUBDUED' | 'INFO' | null;
}

export class FriendConversationUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}
export class FriendRequestResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  fromUserId!: string;

  @ApiProperty()
  toUserId!: string;

  @ApiProperty({
    enum: FRIEND_REQUEST_STATUS,
  })
  status!: FRIEND_REQUEST_STATUS;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    format: 'date-time',
  })
  updatedAt!: string;
}
export class ReceivedFriendRequestResponseDto extends FriendRequestResponseDto {
  @ApiProperty({
    type: FriendUserResponseDto,
  })
  fromUser!: FriendUserResponseDto;
}
export class SentFriendRequestResponseDto extends FriendRequestResponseDto {
  @ApiProperty({
    type: FriendUserResponseDto,
  })
  toUser!: FriendUserResponseDto;
}

export class FriendshipResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  friendId!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    type: FriendUserResponseDto,
  })
  friend!: FriendUserResponseDto;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  conversationId?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: Number,
  })
  sharedTripsCount?: number | null;

  @ApiPropertyOptional({
    nullable: true,
    type: Number,
  })
  dnaMatchPercent?: number | null;
}

export class RemoveFriendResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Friend removed successfully',
  })
  message!: string;
}

export enum FriendStatus {
  SELF = 'SELF',
  FRIENDS = 'FRIENDS',
  REQUEST_SENT = 'REQUEST_SENT',
  REQUEST_RECEIVED = 'REQUEST_RECEIVED',
  NOT_FRIENDS = 'NOT_FRIENDS',
}

export class FriendStatusResponseDto {
  @ApiProperty({
    enum: FriendStatus,
  })
  status!: FriendStatus;
  @ApiPropertyOptional({
    type: String,
  })
  requestId?: string;
}
export class FriendMessageBaseResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  conversationId!: string;

  @ApiProperty()
  senderId!: string;

  @ApiProperty()
  content!: string;

  @ApiProperty({
    example: 'TEXT',
  })
  messageType!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;
}

export class FriendMessageSenderResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}

export class FriendMessageResponseDto extends FriendMessageBaseResponseDto {
  @ApiProperty({
    type: FriendMessageSenderResponseDto,
  })
  sender!: FriendMessageSenderResponseDto;
}
export class FriendMessagesPageResponseDto {
  @ApiProperty({
    type: [FriendMessageResponseDto],
  })
  data!: FriendMessageResponseDto[];

  @ApiProperty({
    type: CursorMetaDto,
  })
  meta!: CursorMetaDto;
}

export class FriendConversationResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  user1Id!: string;

  @ApiProperty()
  user2Id!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    type: FriendConversationUserResponseDto,
  })
  user1!: FriendConversationUserResponseDto;

  @ApiProperty({
    type: FriendConversationUserResponseDto,
  })
  user2!: FriendConversationUserResponseDto;
}

export class FriendConversationLastMessageResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  content!: string;

  @ApiProperty()
  senderId!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;
}

export class FriendConversationListItemResponseDto extends FriendConversationResponseDto {
  @ApiPropertyOptional({
    type: FriendConversationLastMessageResponseDto,
    nullable: true,
  })
  lastMessage!: FriendConversationLastMessageResponseDto | null;
}

export class FriendConversationsPageResponseDto {
  @ApiProperty({
    type: [FriendConversationListItemResponseDto],
  })
  data!: FriendConversationListItemResponseDto[];

  @ApiProperty({
    type: CursorMetaDto,
  })
  meta!: CursorMetaDto;
}

export class FriendConversationJoinAckDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;
}

export class FriendConversationJoinedEventDto {
  @ApiProperty()
  conversationId!: string;

  @ApiProperty({
    type: [FriendMessageResponseDto],
  })
  messages!: FriendMessageResponseDto[];
}
export class FriendMessageSendAckDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    type: FriendMessageResponseDto,
  })
  message!: FriendMessageResponseDto;
}

export class FriendConversationLeaveAckDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;
}

export class FriendGatewayErrorDto {
  @ApiProperty({
    example: 'conversationId is required',
  })
  message!: string;
}
export class FriendRequestEnvelopeResponseDto {
  @ApiProperty({
    type: FriendRequestResponseDto,
  })
  data!: FriendRequestResponseDto;

  @ApiProperty({
    example: 'Friend request sent successfully',
  })
  message!: string;
}

export class ReceivedFriendRequestsResponseDto {
  @ApiProperty({
    type: [ReceivedFriendRequestResponseDto],
  })
  data!: ReceivedFriendRequestResponseDto[];

  @ApiProperty({
    example: 'Received friend requests retrieved successfully',
  })
  message!: string;
}

export class SentFriendRequestsResponseDto {
  @ApiProperty({
    type: [SentFriendRequestResponseDto],
  })
  data!: SentFriendRequestResponseDto[];

  @ApiProperty({
    example: 'Sent friend requests retrieved successfully',
  })
  message!: string;
}

export class FriendshipsResponseDto {
  @ApiProperty({
    type: [FriendshipResponseDto],
  })
  data!: FriendshipResponseDto[];

  @ApiProperty({
    example: 'Friends retrieved successfully',
  })
  message!: string;
}

export class FriendStatusEnvelopeResponseDto {
  @ApiProperty({
    type: FriendStatusResponseDto,
  })
  data!: FriendStatusResponseDto;

  @ApiProperty({
    example: 'Friend status retrieved successfully',
  })
  message!: string;
}

export class FriendConversationEnvelopeResponseDto {
  @ApiProperty({
    type: FriendConversationResponseDto,
  })
  data!: FriendConversationResponseDto;

  @ApiProperty({
    example: 'Conversation retrieved successfully',
  })
  message!: string;
}

export class FriendConversationReadResponseDto {
  @ApiProperty()
  conversationId!: string;

  @ApiProperty({ type: String, format: 'date-time' })
  lastReadAt!: Date;
}

export class FriendConversationReadEnvelopeResponseDto {
  @ApiProperty({
    type: FriendConversationReadResponseDto,
  })
  data!: FriendConversationReadResponseDto;

  @ApiProperty({
    example: 'Conversation marked as read',
  })
  message!: string;
}

//=======================================REVIEW=========================================
export class PlaceReviewUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}

export class PlaceReviewPlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;
}

export class PlaceReviewResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  placeId!: string;

  @ApiProperty({
    minimum: 1,
    maximum: 5,
  })
  rating!: number;

  @ApiPropertyOptional({
    nullable: true,
  })
  comment!: string | null;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiPropertyOptional({
    format: 'date-time',
    nullable: true,
  })
  updatedAt?: string;

  @ApiProperty({
    type: PlaceReviewUserResponseDto,
  })
  user!: PlaceReviewUserResponseDto;
}
export class PlaceReviewDetailResponseDto extends PlaceReviewResponseDto {
  @ApiProperty({
    type: PlaceReviewPlaceResponseDto,
  })
  place!: PlaceReviewPlaceResponseDto;
}
export class PlaceReviewEnvelopeResponseDto {
  @ApiProperty({
    type: PlaceReviewDetailResponseDto,
  })
  data!: PlaceReviewDetailResponseDto;

  @ApiProperty({
    example: 'Review retrieved successfully',
  })
  message!: string;
}
export class PlaceReviewsPageResponseDto {
  @ApiProperty({
    type: [PlaceReviewResponseDto],
  })
  data!: PlaceReviewResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}
export class MyPlaceReviewResponseDto {
  @ApiProperty({
    type: PlaceReviewDetailResponseDto,
    nullable: true,
  })
  data!: PlaceReviewDetailResponseDto | null;

  @ApiProperty({
    example: 'My review retrieved successfully',
  })
  message!: string;
}
export class RatingDistributionResponseDto {
  @ApiProperty({ example: 3 })
  1!: number;

  @ApiProperty({ example: 5 })
  2!: number;

  @ApiProperty({ example: 7 })
  3!: number;

  @ApiProperty({ example: 12 })
  4!: number;

  @ApiProperty({ example: 20 })
  5!: number;
}

export class PlaceRatingSummaryResponseDto {
  @ApiProperty({
    example: 4.6,
  })
  averageRating!: number;

  @ApiProperty({
    example: 47,
  })
  totalReviews!: number;

  @ApiProperty({
    type: RatingDistributionResponseDto,
  })
  distribution!: RatingDistributionResponseDto;
}

export class PlaceRatingSummaryEnvelopeResponseDto {
  @ApiProperty({
    type: PlaceRatingSummaryResponseDto,
  })
  data!: PlaceRatingSummaryResponseDto;

  @ApiProperty({
    example: 'Rating summary retrieved successfully',
  })
  message!: string;
}
export class DeletePlaceReviewResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Review deleted successfully',
  })
  message!: string;
}

//=======================================SAVED PLACES=========================================import {
export class SavedPlacePlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  description!: string | null;

  @ApiPropertyOptional({
    nullable: true,
  })
  category!: string | null;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  country!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  address!: string | null;

  @ApiProperty()
  latitude!: number;

  @ApiProperty()
  longitude!: number;

  @ApiProperty()
  averageRating!: number;
}
export class SavedPlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  placeId!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    type: SavedPlacePlaceResponseDto,
  })
  place!: SavedPlacePlaceResponseDto;
}
export class SavedPlaceEnvelopeResponseDto {
  @ApiProperty({
    type: SavedPlaceResponseDto,
  })
  data!: SavedPlaceResponseDto;

  @ApiProperty({
    example: 'Place saved successfully',
  })
  message!: string;
}
export class RemoveSavedPlaceResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Place unsaved successfully',
  })
  message!: string;
}
export class SavedPlaceStatusResponseDto {
  @ApiProperty()
  saved!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    format: 'date-time',
  })
  savedAt!: string | null;
}

export class SavedPlaceStatusEnvelopeResponseDto {
  @ApiProperty({
    type: SavedPlaceStatusResponseDto,
  })
  data!: SavedPlaceStatusResponseDto;

  @ApiProperty({
    example: 'Saved place status retrieved successfully',
  })
  message!: string;
}
export class SavedPlacesPageResponseDto {
  @ApiProperty({
    type: [SavedPlaceResponseDto],
  })
  data!: SavedPlaceResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}
export class SavedPlacesCountResponseDto {
  @ApiProperty({
    example: 12,
  })
  count!: number;
}

export class SavedPlacesCountEnvelopeResponseDto {
  @ApiProperty({
    type: SavedPlacesCountResponseDto,
  })
  data!: SavedPlacesCountResponseDto;

  @ApiProperty({
    example: 'Saved places count retrieved successfully',
  })
  message!: string;
}
//=======================================POST COMMENT=========================================
export class PostCommentUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}

export class PostCommentResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  postId!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  content!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    format: 'date-time',
  })
  updatedAt!: string;

  @ApiPropertyOptional({
    nullable: true,
    format: 'date-time',
  })
  deletedAt!: string | null;

  @ApiProperty({
    type: PostCommentUserResponseDto,
  })
  user!: PostCommentUserResponseDto;
}

export class PostCommentEnvelopeResponseDto {
  @ApiProperty({
    type: PostCommentResponseDto,
  })
  data!: PostCommentResponseDto;

  @ApiProperty({
    example: 'Comment created successfully',
  })
  message!: string;
}

export class PostCommentsPageResponseDto {
  @ApiProperty({
    type: [PostCommentResponseDto],
  })
  data!: PostCommentResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}

export class DeletePostCommentResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Comment deleted successfully',
  })
  message!: string;
}
//=======================================POST LIKES=========================================
export class InteractionActionResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Post liked successfully',
  })
  message!: string;
}

export class InteractionStatusResponseDto {
  @ApiProperty({
    example: true,
  })
  liked!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    format: 'date-time',
  })
  likedAt!: string | null;
}

export class InteractionStatusEnvelopeResponseDto {
  @ApiProperty({
    type: InteractionStatusResponseDto,
  })
  data!: InteractionStatusResponseDto;

  @ApiProperty({
    example: 'Like status retrieved successfully',
  })
  message!: string;
}
//=======================================POST SHARES=========================================
export class ShareStatusResponseDto {
  @ApiProperty({
    example: true,
  })
  shared!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    format: 'date-time',
  })
  sharedAt!: string | null;
}

export class ShareStatusEnvelopeResponseDto {
  @ApiProperty({
    type: ShareStatusResponseDto,
  })
  data!: ShareStatusResponseDto;

  @ApiProperty({
    example: 'Share status retrieved successfully',
  })
  message!: string;
}
//=======================================POST=========================================
export class PostAuthorResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({ type: String })
  displayName?: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  avatarUrl?: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  badgeLabel?: string | null;

  @ApiPropertyOptional()
  verified?: boolean;
}

export class PostPlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  detail?: string | null;
}

export class PostMediaResponseDto {
  @ApiProperty()
  mediaId!: string;

  @ApiProperty()
  orderIndex!: number;

  @ApiPropertyOptional({ nullable: true, type: String })
  url?: string | null;
}
export class PostCountsResponseDto {
  @ApiProperty()
  likes!: number;

  @ApiProperty()
  comments!: number;

  @ApiProperty()
  shares!: number;

  @ApiPropertyOptional()
  saves?: number;
}
export class PostResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  authorId!: string;

  @ApiPropertyOptional({
    nullable: true,
  })
  placeId!: string | null;

  @ApiPropertyOptional({
    nullable: true,
  })
  caption!: string | null;

  @ApiProperty({
    enum: SocialPostVisibility,
  })
  visibility!: SocialPostVisibility;

  @ApiPropertyOptional({ nullable: true, type: String })
  tipTitle?: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  tipBody?: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  topic?: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  placeDetail?: string | null;

  @ApiProperty()
  likesCount!: number;

  @ApiProperty()
  commentsCount!: number;

  @ApiProperty()
  sharesCount!: number;

  @ApiPropertyOptional()
  savesCount?: number;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    format: 'date-time',
  })
  updatedAt!: string;

  @ApiProperty({
    type: PostAuthorResponseDto,
  })
  author!: PostAuthorResponseDto;

  @ApiPropertyOptional({
    type: PostPlaceResponseDto,
    nullable: true,
  })
  place!: PostPlaceResponseDto | null;

  @ApiProperty({
    type: [PostMediaResponseDto],
  })
  postMedias!: PostMediaResponseDto[];

  @ApiProperty({
    type: PostCountsResponseDto,
  })
  _count!: PostCountsResponseDto;

  @ApiProperty()
  liked!: boolean;

  @ApiProperty()
  shared!: boolean;

  @ApiPropertyOptional()
  bookmarked?: boolean;

  @ApiPropertyOptional({ nullable: true, type: String })
  trendLabel?: string | null;

  @ApiPropertyOptional({ type: String })
  timeLabel?: string;
}
export class PostEnvelopeResponseDto {
  @ApiProperty({
    type: PostResponseDto,
  })
  data!: PostResponseDto;

  @ApiProperty({
    example: 'Post retrieved successfully',
  })
  message!: string;
}
export class PostsPageResponseDto {
  @ApiProperty({
    type: [PostResponseDto],
  })
  data!: PostResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}
export class DeletePostResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Post deleted successfully',
  })
  message!: string;
}
//=======================================TRAVELDNA=========================================
export class TravelDnaBadgeResponseDto {
  @ApiProperty({
    enum: TRAVEL_DNA_TYPE,
  })
  type!: TRAVEL_DNA_TYPE;

  @ApiProperty({
    example: 'Food Explorer',
  })
  name!: string;

  @ApiProperty({
    example: '🍜',
  })
  icon!: string;

  @ApiProperty({
    example: 'Loves discovering local food experiences',
  })
  description!: string;

  @ApiProperty({
    example: 75,
  })
  score!: number;

  @ApiProperty({
    example: 3,
  })
  tripTypeCount!: number;

  @ApiProperty({
    example: 12,
  })
  activityCount!: number;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    format: 'date-time',
  })
  updatedAt!: string;
}
export class TravelDnaResponseDto {
  @ApiPropertyOptional({
    type: TravelDnaBadgeResponseDto,
    nullable: true,
  })
  dominant!: TravelDnaBadgeResponseDto | null;

  @ApiProperty({
    type: [TravelDnaBadgeResponseDto],
  })
  topBadges!: TravelDnaBadgeResponseDto[];

  @ApiProperty({
    type: [TravelDnaBadgeResponseDto],
  })
  all!: TravelDnaBadgeResponseDto[];
}
export class TravelDnaEnvelopeResponseDto {
  @ApiProperty({
    type: TravelDnaResponseDto,
  })
  data!: TravelDnaResponseDto;

  @ApiProperty({
    example: 'Travel DNA retrieved successfully',
  })
  message!: string;
}

export class ProfileShowcaseRankingResponseDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty({ minimum: 0 })
  totalPoints!: number;

  @ApiProperty({ minimum: 0 })
  totalTripsCompleted!: number;

  @ApiProperty({ enum: RANK })
  rank!: RANK;

  @ApiProperty({ nullable: true, type: Number })
  ranking!: number | null;

  @ApiProperty({
    nullable: true,
    type: Number,
    description:
      'Leaderboard position expressed as a top percent. 5 means top 5%. Null when the user is absent from the latest snapshot.',
  })
  percentile!: number | null;
}

export class ProfileShowcaseSocialResponseDto {
  @ApiProperty({ minimum: 0 })
  tripCount!: number;

  @ApiProperty({ minimum: 0 })
  followerCount!: number;

  @ApiProperty({ minimum: 0 })
  followingCount!: number;
}

export class ProfileShowcaseTripResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  coverImageUrl!: string | null;

  @ApiProperty({ enum: TRIP_STATUS })
  status!: TRIP_STATUS;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty({ enum: BudgetLevel, nullable: true })
  budgetLevel!: BudgetLevel | null;

  @ApiProperty({ minimum: 1 })
  maxMembers!: number;

  @ApiProperty({ minimum: 0 })
  memberCount!: number;

  @ApiProperty({ minimum: 0 })
  totalActivities!: number;

  @ApiProperty({ minimum: 0 })
  completedActivities!: number;

  @ApiProperty({ type: [String] })
  highlights!: string[];
}

export class ProfileShowcaseMemoryResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ format: 'uri' })
  imageUrl!: string;
}

export class ProfileShowcaseMemoriesResponseDto {
  @ApiProperty({ minimum: 0 })
  totalCount!: number;

  @ApiProperty({ type: [ProfileShowcaseMemoryResponseDto] })
  items!: ProfileShowcaseMemoryResponseDto[];
}

export class ProfileShowcaseSavedPlaceResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  placeId!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  country!: string;

  @ApiProperty()
  category!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  coverImageUrl!: string | null;
}

export class ProfileShowcaseSavedPlacesResponseDto {
  @ApiProperty({ minimum: 0 })
  count!: number;

  @ApiProperty({ type: [ProfileShowcaseSavedPlaceResponseDto] })
  items!: ProfileShowcaseSavedPlaceResponseDto[];
}

export class ProfileShowcasePostResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ nullable: true, type: String })
  caption!: string | null;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  imageUrl!: string | null;
}

export class ProfileShowcasePostsResponseDto {
  @ApiProperty({ minimum: 0 })
  count!: number;

  @ApiProperty({ type: [ProfileShowcasePostResponseDto] })
  items!: ProfileShowcasePostResponseDto[];
}

export class ProfileShowcaseResponseDto {
  @ApiProperty({ enum: HOST_STATUS })
  hostStatus!: HOST_STATUS;

  @ApiProperty({ type: ProfileShowcaseRankingResponseDto })
  ranking!: ProfileShowcaseRankingResponseDto;

  @ApiProperty({ type: ProfileShowcaseSocialResponseDto })
  social!: ProfileShowcaseSocialResponseDto;

  @ApiProperty({ type: TravelDnaResponseDto })
  travelDna!: TravelDnaResponseDto;

  @ApiProperty({ type: ProfileShowcaseTripResponseDto, nullable: true })
  ongoingTrip!: ProfileShowcaseTripResponseDto | null;

  @ApiProperty({ type: ProfileShowcaseTripResponseDto, nullable: true })
  upcomingTrip!: ProfileShowcaseTripResponseDto | null;

  @ApiProperty({ type: ProfileShowcaseMemoriesResponseDto })
  memories!: ProfileShowcaseMemoriesResponseDto;

  @ApiProperty({ type: ProfileShowcaseSavedPlacesResponseDto })
  savedPlaces!: ProfileShowcaseSavedPlacesResponseDto;

  @ApiProperty({ type: ProfileShowcasePostsResponseDto })
  posts!: ProfileShowcasePostsResponseDto;
}

export class ProfileShowcaseEnvelopeResponseDto {
  @ApiProperty({ type: ProfileShowcaseResponseDto })
  data!: ProfileShowcaseResponseDto;

  @ApiProperty({ example: 'Profile showcase retrieved successfully' })
  message!: string;
}
//====================================MEMORIES===================================
export class MemoryResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty({ nullable: true, type: String })
  caption!: string | null;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;

  @ApiProperty({ format: 'uri' })
  imageUrl!: string;

  @ApiProperty({ type: PublicUserBriefResponseDto, nullable: true })
  user!: PublicUserBriefResponseDto | null;

  @ApiProperty({ type: UploadedMediaResponseDto })
  media!: UploadedMediaResponseDto;

  @ApiProperty({
    nullable: true,
    type: String,
    description:
      'Label suggested from the photo content, null until classified or when no label fits',
    enum: Object.values(MEMORY_BADGE_LABELS),
    example: 'Khoảnh khắc đêm',
  })
  badge!: string | null;

  @ApiProperty({ minimum: 0 })
  likeCount!: number;

  @ApiProperty()
  liked!: boolean;
}

export class MemoryDayCountResponseDto {
  @ApiProperty({ minimum: 1, description: '1-based trip day, in UTC' })
  day!: number;

  @ApiProperty({ minimum: 1 })
  count!: number;
}

export class MemoriesCursorMetaDto extends CursorMetaDto {
  @ApiProperty({
    nullable: true,
    type: Number,
    description:
      'Memories matching every filter; only on the first page (no cursor)',
  })
  totalCount!: number | null;

  @ApiProperty({
    nullable: true,
    type: [MemoryDayCountResponseDto],
    description:
      'Memories per trip day ignoring `day`, days without memories omitted; only on the first page',
  })
  dayCounts!: MemoryDayCountResponseDto[] | null;
}

export class MemoriesBatchEnvelopeResponseDto {
  @ApiProperty({ type: [MemoryResponseDto] })
  data!: MemoryResponseDto[];

  @ApiProperty({ example: 'Memories created successfully' })
  message!: string;
}

export class MemoriesCursorResponseDto {
  @ApiProperty({ type: [MemoryResponseDto] })
  data!: MemoryResponseDto[];

  @ApiProperty({ type: MemoriesCursorMetaDto })
  meta!: MemoriesCursorMetaDto;
}

export class MyMemoryResponseDto extends MemoryResponseDto {
  @ApiProperty()
  tripName!: string;
}

export class MyMemoryCollectionResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({
    enum: [
      'DRAFT',
      'UPCOMING',
      'ONGOING',
      'CANCELLED',
      'COMPLETED',
      'NOTCOMPLETED',
    ],
  })
  status!: string;

  @ApiProperty({ minimum: 0 })
  memoryCount!: number;
}

export class MyMemoriesCursorMetaDto extends CursorMetaDto {
  @ApiProperty({
    nullable: true,
    type: Number,
    description: 'Photos in the selected set; only on the first page',
  })
  totalCount!: number | null;
}

export class MyMemoriesResponseDto {
  @ApiProperty({ type: [MyMemoryResponseDto] })
  data!: MyMemoryResponseDto[];

  @ApiProperty({
    type: [MyMemoryCollectionResponseDto],
    nullable: true,
    description: 'Trip chips; only on the first page',
  })
  collections!: MyMemoryCollectionResponseDto[] | null;

  @ApiProperty({ type: MyMemoryResponseDto, nullable: true })
  highlight!: MyMemoryResponseDto | null;

  @ApiProperty({ type: MyMemoriesCursorMetaDto })
  meta!: MyMemoriesCursorMetaDto;
}

export class MemoryLikeResponseDto {
  @ApiProperty({ minimum: 0 })
  likeCount!: number;

  @ApiProperty()
  liked!: boolean;
}
//=======================================TRIP=========================================
export class TripResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ nullable: true, type: String })
  description!: string | null;

  @ApiPropertyOptional({ nullable: true, format: 'uri' })
  coverImageUrl?: string | null;

  @ApiProperty({ nullable: true, type: String })
  ownerId!: string | null;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty({ nullable: true, enum: ['LOW', 'MEDIUM', 'HIGH'] })
  budgetLevel!: string | null;

  @ApiProperty({ minimum: 1 })
  maxMembers!: number;

  @ApiProperty({
    enum: ['SOLO', 'COUPLE', 'FAMILY', 'FRIENDS', 'BACKPACKER', 'OTHER'],
  })
  tripType!: string;

  @ApiProperty({ enum: ['PUBLIC', 'PRIVATE'] })
  visibility!: string;

  @ApiProperty({
    enum: [
      'DRAFT',
      'UPCOMING',
      'ONGOING',
      'CANCELLED',
      'COMPLETED',
      'NOTCOMPLETED',
    ],
  })
  status!: string;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;

  @ApiProperty({ format: 'date-time' })
  updatedAt!: string;

  @ApiPropertyOptional({ type: Object, nullable: true })
  owner?: object | null;

  @ApiPropertyOptional({ type: [Object] })
  destinations?: object[];

  @ApiPropertyOptional({ type: [Object] })
  interests?: object[];

  @ApiPropertyOptional({ type: [Object] })
  tripInterests?: object[];

  @ApiPropertyOptional({ type: [Object] })
  members?: object[];

  @ApiPropertyOptional({ type: [Object] })
  timelineEvents?: object[];
}

export class TripsPageResponseDto {
  @ApiProperty({ type: [TripResponseDto] })
  data!: TripResponseDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;
}
export class TripEnvelopeResponseDto {
  @ApiProperty({
    type: TripResponseDto,
  })
  data!: TripResponseDto;

  @ApiProperty({
    example: 'Trip retrieved successfully',
  })
  message!: string;
}
export class TripDetailViewerDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty({
    enum: TRIP_ROLE,
    nullable: true,
    description: 'null when the viewer is not an active member',
  })
  role!: TRIP_ROLE | null;
}

export class TripDetailExpenseSummaryDto {
  @ApiProperty({ minimum: 0 })
  totalAmount!: number;

  @ApiProperty({ enum: CURRENCY })
  currency!: CURRENCY;
}

export class TripDetailCheckinProgressDto {
  @ApiProperty({
    minimum: 0,
    description: 'Activities every active member has checked in at',
  })
  completedCount!: number;

  @ApiProperty({ minimum: 0 })
  totalCount!: number;

  @ApiProperty({
    minimum: 0,
    description: 'Points the viewer was awarded for completing this trip',
  })
  pointsEarned!: number;
}

export class TripDetailMemberDto {
  @ApiProperty({ description: 'TripMember id' })
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  displayName!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  avatarUrl!: string | null;

  @ApiProperty({ enum: TRIP_ROLE })
  role!: TRIP_ROLE;

  @ApiProperty({ format: 'date-time' })
  joinedAt!: string;

  @ApiProperty({
    nullable: true,
    type: String,
    example: 'Beach Lover 🏖️',
    description: 'Strongest Travel DNA badge',
  })
  travelPersona!: string | null;

  @ApiProperty({
    nullable: true,
    type: String,
    description: "Content of the member's latest event in the timeline preview",
  })
  activityNote!: string | null;

  @ApiProperty({ description: 'Has the trip room open (members only)' })
  isOnline!: boolean;

  @ApiProperty()
  isNewMember!: boolean;

  @ApiProperty({
    nullable: true,
    type: Number,
    description: 'null when the viewer cannot read expenses',
  })
  amountSpent!: number | null;

  @ApiProperty({ minimum: 0 })
  memoryCount!: number;
}

export class TripDetailDestinationDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  country!: string;

  @ApiProperty({ minimum: 0 })
  order!: number;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty()
  isCurrent!: boolean;
}

export class TripDetailNextActivityDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty({ nullable: true, type: String })
  description!: string | null;

  @ApiProperty({ format: 'date-time' })
  startTime!: string;

  @ApiProperty({
    minimum: 0,
    description: 'Active members already checked in at the activity place',
  })
  confirmedCount!: number;

  @ApiProperty({ minimum: 0, description: 'Active member count' })
  totalCount!: number;
}

export class TripDetailMemoryDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ format: 'uri' })
  imageUrl!: string;

  @ApiProperty({ nullable: true, type: String })
  caption!: string | null;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'null when the uploader deleted their account',
  })
  authorName!: string | null;
}

export class TripDetailMemoriesPreviewDto {
  @ApiProperty({ minimum: 0 })
  totalCount!: number;

  @ApiProperty({ type: [TripDetailMemoryDto] })
  items!: TripDetailMemoryDto[];
}

export class TripDetailCompletionRewardDto {
  @ApiProperty({ minimum: 0 })
  points!: number;

  @ApiProperty()
  canClaim!: boolean;

  @ApiProperty()
  claimed!: boolean;
}

export class TripDetailTimelineEventDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: TIMELINE_EVENT_TYPE })
  type!: TIMELINE_EVENT_TYPE;

  @ApiProperty()
  actorName!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  actorAvatarUrl!: string | null;

  @ApiProperty()
  content!: string;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;
}

export class TripDetailTimelinePreviewDto {
  @ApiProperty({ minimum: 0 })
  totalCount!: number;

  @ApiProperty({ type: [TripDetailTimelineEventDto] })
  items!: TripDetailTimelineEventDto[];
}

export class TripDetailResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ nullable: true, type: String })
  description!: string | null;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  coverImageUrl!: string | null;

  @ApiProperty({ enum: TRIP_STATUS })
  status!: TRIP_STATUS;

  @ApiProperty({ enum: TRIP_VISIBILITY })
  visibility!: TRIP_VISIBILITY;

  @ApiProperty({ enum: TRIP_TYPE })
  tripType!: TRIP_TYPE;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty({ minimum: 1 })
  maxMembers!: number;

  @ApiProperty({ enum: BudgetLevel, nullable: true })
  budgetLevel!: BudgetLevel | null;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'Only returned to the trip owner',
  })
  inviteCode!: string | null;

  @ApiProperty({ type: TripDetailViewerDto })
  viewer!: TripDetailViewerDto;

  @ApiProperty({
    type: TripDetailExpenseSummaryDto,
    nullable: true,
    description: 'Members only',
  })
  expenseSummary!: TripDetailExpenseSummaryDto | null;

  @ApiProperty({ type: TripDetailCheckinProgressDto })
  checkinProgress!: TripDetailCheckinProgressDto;

  @ApiProperty({ type: [TripDetailMemberDto] })
  members!: TripDetailMemberDto[];

  @ApiProperty({ type: [TripDetailDestinationDto] })
  destinations!: TripDetailDestinationDto[];

  @ApiProperty({ type: TripDetailNextActivityDto, nullable: true })
  nextActivity!: TripDetailNextActivityDto | null;

  @ApiProperty({
    type: TripDetailMemoriesPreviewDto,
    nullable: true,
    description: 'Members only',
  })
  memories!: TripDetailMemoriesPreviewDto | null;

  @ApiProperty({
    type: TripDetailCompletionRewardDto,
    nullable: true,
    description: 'Members only',
  })
  completionReward!: TripDetailCompletionRewardDto | null;

  @ApiProperty({
    type: TripDetailMissionsPreviewDto,
    nullable: true,
    description: 'Members only — trip-scoped missions progress',
  })
  missions!: TripDetailMissionsPreviewDto | null;

  @ApiProperty({
    type: TripDetailTimelinePreviewDto,
    nullable: true,
    description: 'Members only',
  })
  timeline!: TripDetailTimelinePreviewDto | null;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'Shown when the post is effectively open',
  })
  requirements!: string | null;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'Per-person budget shown when the post is effectively open',
  })
  estimatedBudgetPerPerson!: string | null;

  @ApiProperty({
    nullable: true,
    type: Number,
    description: 'Open seats when the post is effectively open',
  })
  slotsRemaining!: number | null;

  @ApiProperty({
    nullable: true,
    type: String,
    format: 'date-time',
    description: 'Feed expiry when the post is effectively open',
  })
  expiresAt!: string | null;
}

export class TripDetailEnvelopeResponseDto {
  @ApiProperty({ type: TripDetailResponseDto })
  data!: TripDetailResponseDto;

  @ApiProperty({ example: 'Trip retrieved successfully' })
  message!: string;
}
export class TripActionResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Trip deleted successfully',
  })
  message!: string;
}
export class MemoryEnvelopeResponseDto {
  @ApiProperty({
    type: MemoryResponseDto,
  })
  data!: MemoryResponseDto;

  @ApiProperty({
    example: 'Memory created successfully',
  })
  message!: string;
}
export class TripMemberResponseDto {
  @ApiProperty({
    example: 'cm123abc',
  })
  id!: string;

  @ApiProperty({
    example: 'trip123',
  })
  tripId!: string;

  @ApiProperty({
    example: 'user123',
  })
  userId!: string;

  @ApiProperty({
    enum: TRIP_ROLE,
    example: TRIP_ROLE.MEMBER,
  })
  role!: TRIP_ROLE;

  @ApiProperty({
    enum: MEMBER_STATUS,
    example: MEMBER_STATUS.ACTIVE,
  })
  status!: MEMBER_STATUS;

  @ApiProperty({
    format: 'date-time',
  })
  joinedAt!: string;

  @ApiPropertyOptional({
    nullable: true,
    format: 'date-time',
  })
  leftAt!: string | null;
}
export class TripMemberEnvelopeResponseDto {
  @ApiProperty({
    type: TripMemberResponseDto,
  })
  data!: TripMemberResponseDto;

  @ApiProperty()
  message!: string;
}

export class InviteCodeResponseDto {
  @ApiProperty() id!: string;

  @ApiProperty({ example: 'K7M2Q9XA' })
  inviteCode!: string;
}

export class InviteCodeEnvelopeResponseDto {
  @ApiProperty({ type: InviteCodeResponseDto })
  data!: InviteCodeResponseDto;

  @ApiProperty({ example: 'Invite code rotated successfully' })
  message!: string;
}

//=======================================RANKING=========================================
export class RankingResponseDto {
  @ApiProperty() userId!: string;
  @ApiProperty() totalPoints!: number;
  @ApiProperty() totalTripsCompleted!: number;
  @ApiProperty({ enum: RANK }) rank!: RANK;
  @ApiProperty({ nullable: true, type: Number }) ranking!: number | null;
  @ApiProperty() displayName!: string;
  @ApiProperty() username!: string;
  @ApiPropertyOptional({ nullable: true, type: String, format: 'uri' })
  avatarUrl!: string | null;
  @ApiProperty() isVerified!: boolean;
  @ApiPropertyOptional({ nullable: true, type: String })
  badgeLabel!: string | null;
  @ApiPropertyOptional({ nullable: true, type: String })
  badgeIcon!: string | null;
}

export class RankingMeResponseDto extends RankingResponseDto {
  @ApiProperty({
    description:
      'Change vs previous equivalent period window. Positive means climbed.',
  })
  rankDelta!: number;

  @ApiPropertyOptional({ nullable: true, type: Number })
  previousRanking!: number | null;

  @ApiPropertyOptional({ enum: RANK, nullable: true })
  nextRank!: RANK | null;

  @ApiProperty({
    description: 'Progress label for Top-N target (e.g. Top 10).',
  })
  nextTierLabel!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: Number,
    description: 'Points needed to reach / hold Top-N threshold for the period.',
  })
  nextRankPoints!: number | null;

  @ApiProperty()
  progressHint!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'date-time',
  })
  snapshotAt!: string | null;

  @ApiProperty({ enum: ['WEEK', 'MONTH', 'SEASON', 'ALL_TIME'] })
  period!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  seasonLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String, format: 'date-time' })
  windowStart!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String, format: 'date-time' })
  windowEnd!: string | null;

  @ApiProperty({ type: TravelTierDto })
  travelTier!: TravelTierDto;

  @ApiProperty({ type: [AchievementProgressDto] })
  achievements!: AchievementProgressDto[];
}

export class RankingLeaderboardResponseDto {
  @ApiProperty({ type: [RankingResponseDto] })
  data!: RankingResponseDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;

  @ApiProperty({ enum: ['WEEK', 'MONTH', 'SEASON', 'ALL_TIME'] })
  period!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  seasonLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String, format: 'date-time' })
  windowStart!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String, format: 'date-time' })
  windowEnd!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'date-time',
  })
  snapshotAt!: string | null;
}

export class RankingMeEnvelopeResponseDto {
  @ApiProperty({ type: RankingMeResponseDto })
  data!: RankingMeResponseDto;

  @ApiProperty({ example: 'User ranking retrieved successfully' })
  message!: string;
}

export class RankingQuestResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() code!: string;
  @ApiProperty() title!: string;
  @ApiProperty() subtitle!: string;
  @ApiProperty() icon!: string;
  @ApiProperty() pointsReward!: number;
  @ApiProperty({ enum: ['START', 'CONTINUE', 'WRITE'] }) action!: string;
  @ApiProperty({ enum: ['PRIMARY', 'SECONDARY', 'TERTIARY'] }) tone!: string;
  @ApiProperty() targetCount!: number;
  @ApiProperty() progressCurrent!: number;
  @ApiProperty() claimed!: boolean;
  @ApiProperty() claimable!: boolean;
}

export class RankingQuestsResponseDto {
  @ApiProperty({ type: [RankingQuestResponseDto] })
  data!: RankingQuestResponseDto[];

  @ApiProperty() questsTotal!: number;
}

export class RankingQuestClaimResponseDto {
  @ApiProperty({ type: RankingQuestResponseDto })
  data!: RankingQuestResponseDto;

  @ApiProperty({ example: 'Quest claimed successfully' })
  message!: string;
}
//=======================================TRIP TIMELINE=========================================
export class TripTimelineUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiProperty()
  displayName!: string;

  @ApiProperty({ nullable: true, type: String, format: 'uri' })
  avatarUrl!: string | null;
}

export class TripTimelineMemberResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({
    type: TripTimelineUserResponseDto,
  })
  user!: TripTimelineUserResponseDto;
}

/**
 * Snapshot captured when the event happened. One flat object; which fields are
 * present depends on `type`. Null for events recorded before metadata existed.
 */
export class TripTimelineEventMetadataDto {
  @ApiPropertyOptional({ description: 'TRIP_CREATED' })
  tripName?: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'date-time',
    description: 'TRIP_CREATED',
  })
  startDate?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'date-time',
    description: 'TRIP_CREATED',
  })
  endDate?: string | null;

  @ApiPropertyOptional({ minimum: 0, description: 'TRIP_CREATED' })
  destinationCount?: number;

  @ApiPropertyOptional({
    enum: ['INVITE_CODE', 'INVITATION'],
    description: 'MEMBER_JOINED. The invite code itself is never exposed.',
  })
  via?: string;

  @ApiPropertyOptional({ description: 'MEMBER_KICKED' })
  targetMemberId?: string;

  @ApiPropertyOptional({ description: 'MEMBER_KICKED' })
  targetName?: string;

  @ApiPropertyOptional({ description: 'ACTIVITY_*' })
  activityTitle?: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'ACTIVITY_ADDED, ACTIVITY_UPDATED, ACTIVITY_CHECKIN',
  })
  placeName?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'ACTIVITY_CHECKIN: city of the place',
  })
  placeArea?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: Number,
    description: 'ACTIVITY_ADDED, ACTIVITY_UPDATED, ACTIVITY_DELETED',
  })
  dayNumber?: number | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'date-time',
    description: 'ACTIVITY_ADDED, ACTIVITY_UPDATED',
  })
  startTime?: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'date-time',
    description: 'ACTIVITY_UPDATED',
  })
  previousStartTime?: string | null;

  @ApiPropertyOptional({
    description: 'ACTIVITY_CHECKIN: place coordinates, not the member GPS',
  })
  latitude?: number;

  @ApiPropertyOptional({ description: 'ACTIVITY_CHECKIN' })
  longitude?: number;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    format: 'uri',
    description: 'ACTIVITY_CHECKIN: place cover',
  })
  imageUrl?: string | null;

  @ApiPropertyOptional({ description: 'ACTIVITY_CHECKIN' })
  verified?: boolean;

  @ApiPropertyOptional({
    minimum: 0,
    description: 'ACTIVITY_CHECKIN: points granted on trip completion',
  })
  pointsEarned?: number;

  @ApiPropertyOptional({
    example: '1200000',
    description: 'EXPENSE_CREATED, EXPENSE_SETTLED. Base-10 string.',
  })
  amount?: string;

  @ApiPropertyOptional({
    enum: CURRENCY,
    description: 'EXPENSE_CREATED, EXPENSE_SETTLED',
  })
  currency?: string;

  @ApiPropertyOptional({ description: 'EXPENSE_CREATED' })
  category?: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'EXPENSE_CREATED, EXPENSE_SETTLED',
  })
  description?: string | null;

  @ApiPropertyOptional({
    enum: EXPENSE_SPLIT_TYPE,
    description: 'EXPENSE_CREATED',
  })
  splitType?: string;

  @ApiPropertyOptional({ minimum: 1, description: 'EXPENSE_CREATED' })
  splitCount?: number;

  @ApiPropertyOptional({ description: 'EXPENSE_SETTLED' })
  payerMemberId?: string;

  @ApiPropertyOptional({ description: 'EXPENSE_SETTLED' })
  payerName?: string;

  @ApiPropertyOptional({ description: 'EXPENSE_SETTLED' })
  debtorMemberId?: string;

  @ApiPropertyOptional({ description: 'EXPENSE_SETTLED' })
  debtorName?: string;

  @ApiPropertyOptional({
    type: [String],
    description: 'MEMORY_ADDED: memories that still exist',
  })
  memoryIds?: string[];

  @ApiPropertyOptional({
    type: [String],
    description: 'MEMORY_ADDED: same order as memoryIds',
  })
  photoUrls?: string[];

  @ApiPropertyOptional({ minimum: 0, description: 'MEMORY_ADDED' })
  photoCount?: number;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'MEMORY_ADDED',
  })
  caption?: string | null;
}

export class TripTimelineEventResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  memberId!: string;

  @ApiProperty({
    enum: TIMELINE_EVENT_TYPE,
  })
  type!: TIMELINE_EVENT_TYPE;

  @ApiProperty({ description: 'Human-readable fallback sentence' })
  content!: string;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    enum: TIMELINE_TARGET_TYPE,
    nullable: true,
    description: 'Resource opened by "Xem chi tiết"',
  })
  targetType!: TIMELINE_TARGET_TYPE | null;

  @ApiProperty({ nullable: true, type: String })
  targetId!: string | null;

  @ApiProperty({
    type: TripTimelineMemberResponseDto,
  })
  member!: TripTimelineMemberResponseDto;

  @ApiProperty({ type: TripTimelineEventMetadataDto, nullable: true })
  metadata!: TripTimelineEventMetadataDto | null;
}

export class TripTimelineCountsDto {
  @ApiProperty({ minimum: 0 }) all!: number;
  @ApiProperty({ minimum: 0 }) checkin!: number;
  @ApiProperty({ minimum: 0 }) expense!: number;
  @ApiProperty({ minimum: 0 }) memory!: number;
  @ApiProperty({ minimum: 0 }) member!: number;
}

export class TripTimelineCursorMetaDto extends CursorMetaDto {
  @ApiProperty({
    type: TripTimelineCountsDto,
    nullable: true,
    description:
      'Totals per filter group for the whole trip; only sent with the first page (no cursor).',
  })
  counts!: TripTimelineCountsDto | null;
}

export class TripTimelinePageResponseDto {
  @ApiProperty({
    type: [TripTimelineEventResponseDto],
  })
  data!: TripTimelineEventResponseDto[];

  @ApiProperty({
    type: TripTimelineCursorMetaDto,
  })
  meta!: TripTimelineCursorMetaDto;
}
//=======================================TRIP MESSAGES=========================================
export class TripMessageUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}

export class TripMessageSenderResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({
    type: TripMessageUserResponseDto,
  })
  user!: TripMessageUserResponseDto;
}

export class TripMessageResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  senderId!: string;

  @ApiProperty({
    description: 'Text for TEXT messages; the uploaded media id for IMAGE',
  })
  content!: string;

  @ApiProperty({
    example: 'TEXT',
  })
  messageType!: string;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'Public URL of the image for IMAGE messages, otherwise null',
  })
  imageUrl!: string | null;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    type: TripMessageSenderResponseDto,
  })
  sender!: TripMessageSenderResponseDto;
}

export class TripMessagesCursorResponseDto {
  @ApiProperty({
    type: [TripMessageResponseDto],
  })
  data!: TripMessageResponseDto[];

  @ApiProperty({
    type: CursorMetaDto,
  })
  meta!: CursorMetaDto;
}

export class TripMessageReadResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty({ type: String, format: 'date-time' })
  lastReadAt!: Date;
}

export class TripMessageReadEnvelopeResponseDto {
  @ApiProperty({
    type: TripMessageReadResponseDto,
  })
  data!: TripMessageReadResponseDto;

  @ApiProperty({
    example: 'Trip messages marked as read',
  })
  message!: string;
}
//=======================================TRIP INVITATIONS=========================================
export class TripInvitationResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  inviterId!: string;

  @ApiProperty()
  inviteeId!: string;

  @ApiProperty({
    enum: INVITATION_STATUS,
  })
  status!: INVITATION_STATUS;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;
  @ApiProperty({
    format: 'date-time',
  })
  updatedAt!: string;
}
export class TripInvitationEnvelopeResponseDto {
  @ApiProperty({
    type: TripInvitationResponseDto,
  })
  data!: TripInvitationResponseDto;

  @ApiProperty({
    example: 'Trip invitation sent successfully',
  })
  message!: string;
}
export class TripInvitationInviterResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}

export class TripInvitationTripResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({
    enum: TRIP_STATUS,
  })
  status!: TRIP_STATUS;

  @ApiProperty({
    format: 'date-time',
  })
  startDate!: string;

  @ApiProperty({
    format: 'date-time',
  })
  endDate!: string;
}

export class PendingTripInvitationResponseDto extends TripInvitationResponseDto {
  @ApiProperty({
    type: TripInvitationInviterResponseDto,
  })
  inviter!: TripInvitationInviterResponseDto;

  @ApiProperty({
    type: TripInvitationTripResponseDto,
  })
  trip!: TripInvitationTripResponseDto;
}
export class TripInvitationsPageResponseDto {
  @ApiProperty({
    type: [PendingTripInvitationResponseDto],
  })
  data!: PendingTripInvitationResponseDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;
}
//=======================================TRIP JOIN REQUESTS=========================================
export class TripJoinRequesterResponseDto {
  @ApiProperty() id!: string;

  @ApiProperty({ example: 'Minh Anh' })
  displayName!: string;

  @ApiProperty({ example: 'minhanh_travel' })
  username!: string;

  @ApiProperty({ nullable: true, type: String })
  avatarUrl!: string | null;

  @ApiProperty({ description: 'Approved host account' })
  isVerified!: boolean;

  @ApiProperty({ description: 'Has a connected socket right now' })
  isOnline!: boolean;
}

export class TripJoinRequestResponseDto {
  @ApiProperty() id!: string;

  @ApiProperty() tripId!: string;

  @ApiProperty({ enum: JOIN_REQUEST_STATUS })
  status!: JOIN_REQUEST_STATUS;

  @ApiProperty({ type: TripJoinRequesterResponseDto })
  requester!: TripJoinRequesterResponseDto;

  @ApiProperty({ nullable: true, type: String, maxLength: 500 })
  message!: string | null;

  @ApiProperty({
    nullable: true,
    type: String,
    example: 'Foodie Traveler',
    description: 'Name of the strongest Travel DNA of the requester',
  })
  travelPersona!: string | null;

  @ApiProperty({ nullable: true, enum: TRAVEL_DNA_TYPE })
  personaType!: TRAVEL_DNA_TYPE | null;

  @ApiProperty({
    nullable: true,
    type: Number,
    minimum: 0,
    maximum: 100,
    description:
      'Fit between the Travel DNA of the requester and the trip type and itinerary places',
  })
  matchScore!: number | null;

  @ApiProperty({ nullable: true, type: String })
  matchNote!: string | null;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;

  @ApiProperty({ nullable: true, type: String, format: 'date-time' })
  decidedAt!: string | null;
}

export class TripJoinRequestEnvelopeResponseDto {
  @ApiProperty({ type: TripJoinRequestResponseDto })
  data!: TripJoinRequestResponseDto;

  @ApiProperty({ example: 'Join request approved successfully' })
  message!: string;
}

/** Preview of a trip when looking up an invite code before requesting to join. */
export class TripJoinInvitePreviewResponseDto {
  @ApiProperty({ example: 'HE2025VN', nullable: true, type: String })
  inviteCode!: string | null;

  @ApiProperty()
  tripId!: string;

  @ApiProperty({
    example: 'Mùa Hè Rực Rỡ: Bán Đảo Sơn Trà & Phố Cổ Hội An',
  })
  name!: string;

  @ApiProperty({ nullable: true, type: String })
  coverImageUrl!: string | null;

  @ApiProperty({ format: 'date-time' })
  startDate!: string;

  @ApiProperty({ format: 'date-time' })
  endDate!: string;

  @ApiProperty({ example: 'Alex Nguyễn' })
  ownerDisplayName!: string;

  @ApiProperty({ minimum: 0 })
  memberCount!: number;

  @ApiProperty({ minimum: 1 })
  maxMembers!: number;

  @ApiProperty({
    nullable: true,
    type: Number,
    minimum: 0,
    maximum: 100,
    description:
      'Fit between the viewer Travel DNA and the trip type and itinerary places',
  })
  matchScore!: number | null;
}

export class TripJoinInvitePreviewEnvelopeResponseDto {
  @ApiProperty({ type: TripJoinInvitePreviewResponseDto })
  data!: TripJoinInvitePreviewResponseDto;

  @ApiProperty({ example: 'Invite preview retrieved successfully' })
  message!: string;
}

export class TripJoinRequestCountsDto {
  @ApiProperty({ minimum: 0 }) pending!: number;

  @ApiProperty({ minimum: 0 }) approved!: number;

  @ApiProperty({ minimum: 0 }) rejected!: number;
}

export class TripJoinRequestsCursorMetaDto extends CursorMetaDto {
  @ApiProperty({
    type: TripJoinRequestCountsDto,
    description: 'Requests of the whole trip per status, ignoring `status`',
  })
  counts!: TripJoinRequestCountsDto;
}

export class TripJoinRequestsCursorResponseDto {
  @ApiProperty({ type: [TripJoinRequestResponseDto] })
  data!: TripJoinRequestResponseDto[];

  @ApiProperty({ type: TripJoinRequestsCursorMetaDto })
  meta!: TripJoinRequestsCursorMetaDto;
}

export class TripJoinRequestSettingsResponseDto {
  @ApiProperty() autoApproveFriends!: boolean;
}

export class TripJoinRequestSettingsEnvelopeResponseDto {
  @ApiProperty({ type: TripJoinRequestSettingsResponseDto })
  data!: TripJoinRequestSettingsResponseDto;

  @ApiProperty({ example: 'Join request settings retrieved successfully' })
  message!: string;
}
//=======================================TRIP INTERESTS=========================================
export class InterestResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({
    example: 'Camping',
  })
  name!: string;
}
export class InterestEnvelopeResponseDto {
  @ApiProperty({
    type: InterestResponseDto,
  })
  data!: InterestResponseDto;

  @ApiProperty({
    example: 'Interest created successfully',
  })
  message!: string;
}
export class InterestsEnvelopeResponseDto {
  @ApiProperty({
    type: [InterestResponseDto],
  })
  data!: InterestResponseDto[];

  @ApiProperty({
    example: 'Interests retrieved successfully',
  })
  message!: string;
}
export class InterestActionResponseDto {
  @ApiProperty({
    example: true,
  })
  success!: boolean;

  @ApiProperty({
    example: 'Interest deleted successfully',
  })
  message!: string;
}
//=======================================TRIP EXPENSES=========================================
export class TripExpenseUserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  username!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
  })
  avatarId!: string | null;
}
export class TripExpenseMemberResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty({
    type: TripExpenseUserResponseDto,
  })
  user!: TripExpenseUserResponseDto;
}
export class TripExpenseSplitResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  expenseId!: string;

  @ApiProperty()
  tripMemberId!: string;

  @ApiProperty({
    example: '125000.00',
    description: 'Decimal value serialized as a base-10 string',
  })
  amount!: string;

  @ApiProperty()
  isSettled!: boolean;

  @ApiProperty({
    type: TripExpenseMemberResponseDto,
  })
  member!: TripExpenseMemberResponseDto;
}
export class TripExpenseReceiptDto {
  @ApiProperty()
  mediaId!: string;

  @ApiProperty({
    description: 'Public URL of the receipt image',
  })
  url!: string;

  @ApiProperty({ minimum: 0 })
  sortOrder!: number;
}

export class TripExpenseResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  payerId!: string;

  @ApiProperty({
    example: '500000.00',
  })
  amount!: string;

  @ApiProperty({
    example: 'VND',
  })
  currency!: string;

  @ApiProperty()
  category!: string;

  @ApiProperty({
    enum: EXPENSE_SPLIT_TYPE,
  })
  splitType!: EXPENSE_SPLIT_TYPE;

  @ApiPropertyOptional({
    nullable: true,
  })
  description!: string | null;

  @ApiProperty({
    format: 'date-time',
    description: 'When the money was spent',
  })
  spentAt!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    maxLength: 200,
  })
  locationNote!: string | null;

  @ApiProperty({
    format: 'date-time',
  })
  createdAt!: string;

  @ApiProperty({
    type: TripExpenseMemberResponseDto,
  })
  payer!: TripExpenseMemberResponseDto;

  @ApiProperty({
    type: [TripExpenseSplitResponseDto],
  })
  splits!: TripExpenseSplitResponseDto[];

  @ApiProperty({
    type: [TripExpenseReceiptDto],
  })
  receipts!: TripExpenseReceiptDto[];
}
export class TripExpenseEnvelopeResponseDto {
  @ApiProperty({
    type: TripExpenseResponseDto,
  })
  data!: TripExpenseResponseDto;

  @ApiProperty({
    example: 'Expense created successfully',
  })
  message!: string;
}
export class TripExpenseSplitEnvelopeResponseDto {
  @ApiProperty({
    type: TripExpenseSplitResponseDto,
  })
  data!: TripExpenseSplitResponseDto;

  @ApiProperty({
    example: 'Expense share settled successfully',
  })
  message!: string;
}

/** Settlement progress of one expense on the group fund screen. */
export enum TripExpenseSettleStatusDto {
  SETTLED = 'SETTLED',
  PARTIAL = 'PARTIAL',
  PENDING = 'PENDING',
}

/** Suggested pairwise settlement row status for the viewer. */
export enum TripExpenseSettlementStatusDto {
  ACTIONABLE = 'ACTIONABLE',
  PENDING = 'PENDING',
}

export class TripExpenseOverviewSummaryDto {
  @ApiProperty({ minimum: 0 })
  totalAmount!: number;

  @ApiProperty({
    minimum: 0,
    description: 'Total the viewer paid as payer in the overview currency',
  })
  viewerPaidAmount!: number;

  @ApiProperty({
    description:
      'Positive = viewer should receive; negative = viewer still owes',
  })
  viewerNetBalance!: number;
}

export class TripExpenseCategoryShareDto {
  @ApiProperty({ enum: EXPENSE_CATEGORY })
  category!: EXPENSE_CATEGORY;

  @ApiProperty({ minimum: 0 })
  amount!: number;

  @ApiProperty({ minimum: 0, maximum: 100 })
  percent!: number;
}

export class TripExpenseSettlementDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ description: 'TripMember id of the debtor' })
  fromMemberId!: string;

  @ApiProperty()
  fromDisplayName!: string;

  @ApiProperty({ example: 'LP' })
  fromInitials!: string;

  @ApiProperty({
    description: 'True when the viewer is the debtor (fromMember)',
  })
  fromIsViewer!: boolean;

  @ApiProperty({ description: 'TripMember id of the creditor (expense payer)' })
  toMemberId!: string;

  @ApiProperty()
  toDisplayName!: string;

  @ApiProperty({
    description: 'True when the viewer is the creditor (expense payer)',
  })
  toIsViewer!: boolean;

  @ApiProperty({ minimum: 0 })
  amount!: number;

  @ApiPropertyOptional({ nullable: true, type: String })
  note!: string | null;

  @ApiProperty({ enum: TripExpenseSettlementStatusDto })
  status!: TripExpenseSettlementStatusDto;

  @ApiPropertyOptional({ nullable: true, type: String })
  expenseId!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'Split to settle via POST .../splits/:splitId/settle',
  })
  splitId!: string | null;
}

export class TripExpenseListPayerDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'Reserved for future roles/titles; currently always null',
  })
  title!: string | null;

  @ApiProperty({ type: TripExpenseUserResponseDto })
  user!: TripExpenseUserResponseDto;
}

export class TripExpenseListSplitDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  expenseId!: string;

  @ApiProperty()
  tripMemberId!: string;

  @ApiProperty({
    example: '320000.00',
    description: 'Decimal value serialized as a base-10 string',
  })
  amount!: string;

  @ApiProperty()
  isSettled!: boolean;
}

export class TripExpenseListItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  description!: string | null;

  @ApiProperty({ example: '1280000.00' })
  amount!: string;

  @ApiProperty({ enum: CURRENCY })
  currency!: CURRENCY;

  @ApiProperty({ enum: EXPENSE_CATEGORY })
  category!: EXPENSE_CATEGORY;

  @ApiProperty({ enum: EXPENSE_SPLIT_TYPE })
  splitType!: EXPENSE_SPLIT_TYPE;

  @ApiProperty({
    format: 'date-time',
    description: 'When the money was spent (preferred for display)',
  })
  spentAt!: string;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    maxLength: 200,
  })
  locationNote!: string | null;

  @ApiProperty({ format: 'date-time' })
  createdAt!: string;

  @ApiProperty()
  payerId!: string;

  @ApiProperty()
  payerIsViewer!: boolean;

  @ApiProperty({ type: TripExpenseListPayerDto })
  payer!: TripExpenseListPayerDto;

  @ApiProperty({ minimum: 0 })
  splitCount!: number;

  @ApiPropertyOptional({
    nullable: true,
    type: Number,
    description: 'Per-person share when EQUAL; null for CUSTOM',
  })
  amountPerPerson!: number | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  splitNote!: string | null;

  @ApiProperty({ minimum: 0 })
  settledCount!: number;

  @ApiProperty({ enum: TripExpenseSettleStatusDto })
  status!: TripExpenseSettleStatusDto;

  @ApiProperty({ type: [TripExpenseListSplitDto] })
  splits!: TripExpenseListSplitDto[];

  @ApiProperty({ type: [TripExpenseReceiptDto] })
  receipts!: TripExpenseReceiptDto[];
}

/** `GET /trips/{tripId}/expenses` — group fund screen overview. */
export class TripExpenseOverviewDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  tripName!: string;

  @ApiProperty({ minimum: 0 })
  memberCount!: number;

  @ApiProperty({ enum: CURRENCY })
  currency!: CURRENCY;

  @ApiProperty()
  viewerUserId!: string;

  @ApiProperty({ type: TripExpenseOverviewSummaryDto })
  summary!: TripExpenseOverviewSummaryDto;

  @ApiProperty({ type: [TripExpenseCategoryShareDto] })
  categories!: TripExpenseCategoryShareDto[];

  @ApiProperty({ type: [TripExpenseSettlementDto] })
  settlements!: TripExpenseSettlementDto[];

  @ApiProperty({ type: [TripExpenseListItemDto] })
  expenses!: TripExpenseListItemDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;
}

export class TripExpenseOverviewEnvelopeResponseDto {
  @ApiProperty({ type: TripExpenseOverviewDto })
  data!: TripExpenseOverviewDto;

  @ApiProperty({
    example: 'Trip expenses retrieved successfully',
  })
  message!: string;
}
//=======================================TRIP COMPLETION=========================================
export class TripCompletionRecordResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  memberId!: string;

  @ApiProperty({
    example: 25,
  })
  pointsAwarded!: number;

  @ApiProperty({ example: 10 })
  basePoints!: number;

  @ApiProperty({ example: 30 })
  missionPoints!: number;

  @ApiProperty({ example: 1.2 })
  multiplierUsed!: number;

  @ApiProperty({
    format: 'date-time',
  })
  completedAt!: string;
}
export class TripCompletionResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  userId!: string;

  @ApiProperty({
    example: 10,
  })
  totalPlaces!: number;

  @ApiProperty({
    example: 7,
  })
  totalCheckins!: number;

  @ApiProperty({
    minimum: 0,
    maximum: 100,
    example: 70,
  })
  completionPercent!: number;

  @ApiProperty({
    example: 35,
  })
  pointsAwarded!: number;

  @ApiProperty({ example: 10 })
  basePoints!: number;

  @ApiProperty({ example: 30 })
  missionPoints!: number;

  @ApiProperty({ example: 1.2 })
  multiplierUsed!: number;

  @ApiProperty({ example: 2 })
  missionsCompleted!: number;

  @ApiProperty({
    type: TripCompletionRecordResponseDto,
  })
  completion!: TripCompletionRecordResponseDto;
}
export class TripCompletionEnvelopeResponseDto {
  @ApiProperty({
    type: TripCompletionResponseDto,
  })
  data!: TripCompletionResponseDto;

  @ApiProperty({
    example: 'Trip completed successfully',
  })
  message!: string;
}
//=======================================OTHER=========================================
export class SavedStatusResponseDto {
  @ApiProperty() saved!: boolean;
  @ApiProperty({ nullable: true, type: String, format: 'date-time' }) savedAt!:
    string | null;
}
export class CountResponseDto {
  @ApiProperty({ minimum: 0 }) count!: number;
}
export class RemoveInterestResponseDto {
  @ApiProperty() message!: string;
  @ApiProperty({ minimum: 0 }) affectedTrips!: number;
}
export class InvitationResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() tripId!: string;
  @ApiProperty() inviterId!: string;
  @ApiProperty() inviteeId!: string;
  @ApiProperty() status!: string;
  @ApiProperty({ format: 'date-time' }) createdAt!: string;
  @ApiProperty({ format: 'date-time' }) updatedAt!: string;
}
export class PendingInvitationsResponseDto {
  @ApiProperty({ type: [InvitationResponseDto] })
  invitations!: InvitationResponseDto[];
  @ApiProperty({ minimum: 0 }) total!: number;
}
export class CompletionRecordResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() tripId!: string;
  @ApiProperty() memberId!: string;
  @ApiProperty({ format: 'date-time' }) completedAt!: string;
  @ApiProperty() pointsAwarded!: number;
}
export class ItineraryCompletionStatusResponseDto {
  @ApiProperty() totalActivities!: number;
  @ApiProperty() completedActivities!: number;
  @ApiProperty() progressPercent!: number;
  @ApiProperty() isTripCompleted!: boolean;
}
export class UncheckinResponseDto {
  @ApiProperty() success!: boolean;
  @ApiProperty() allCheckedIn!: boolean;
}
export class CheckinResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() memberId!: string;
  @ApiProperty() activityId!: string;
  @ApiProperty() latitude!: number;
  @ApiProperty() longitude!: number;
  @ApiProperty({ format: 'date-time' }) visitedAt!: string;
  @ApiProperty({ format: 'date-time' }) createdAt!: string;
}

export class ActionMessageResponseDto {
  @ApiProperty() success!: boolean;
  @ApiProperty() message!: string;
}
export class RawPlaceResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() name!: string;
  @ApiProperty({ nullable: true, type: String }) description!: string | null;
  @ApiProperty() city!: string;
  @ApiProperty() country!: string;
  @ApiProperty() address!: string;
  @ApiProperty() latitude!: number;
  @ApiProperty() longitude!: number;
  @ApiProperty() category!: string;
  @ApiProperty() status!: string;
  @ApiProperty() averageRating!: number;
  @ApiProperty({ nullable: true, type: String }) createdByUserId!:
    string | null;
  @ApiProperty({ format: 'date-time' }) createdAt!: string;
  @ApiProperty({ format: 'date-time' }) updatedAt!: string;
}
export class GalleryDeleteResponseDto {
  @ApiProperty() message!: string;
  @ApiProperty({ minimum: 0 }) deletedCount!: number;
}
export class GalleryDeleteEnvelopeResponseDto {
  @ApiProperty({ type: GalleryDeleteResponseDto })
  data!: GalleryDeleteResponseDto;

  @ApiProperty({ example: 'Gallery media deleted successfully' })
  message!: string;
}
export class TripInterestLinkResponseDto {
  @ApiProperty() id!: string;
  @ApiProperty() tripId!: string;
  @ApiProperty() interestId!: string;
  @ApiProperty({ type: InterestResponseDto }) interest!: InterestResponseDto;
}
