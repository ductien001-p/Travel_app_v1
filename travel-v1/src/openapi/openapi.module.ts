import { Module, Type } from '@nestjs/common';
import { AuthController } from '../module/auth/auth.controller';
import { FollowController } from '../module/follow/follow.controller';
import { FriendController } from '../module/friends/friends.controller';
import { MediaController } from '../module/media/media.controller';
import { PlacesController } from '../module/places/places.controller';
import { PlaceCollectionsController } from '../module/places/place-collections/place-collections.controller';
import { PlaceReviewsController } from '../module/places/reviews-places/review-places.controller';
import { SavedPlacesController } from '../module/places/saved-places/saved-places.controller';
import { RankingController } from '../module/ranking/ranking.controller';
import { PostCommentsController } from '../module/social/post-comments.controller';
import { PostLikesController } from '../module/social/post-likes.controller';
import { PostSharesController } from '../module/social/post-shares.controller';
import { PostsController } from '../module/social/post.controller';
import { TravelDnaController } from '../module/travelDNA/travel-dna.controller';
import { TripsController } from '../module/trips/trips.controller';
import { TripRecruitmentController } from '../module/trips/trip-relations/trip-recruitment/trip-recruitment.controller';
import { TripCompletionController } from '../module/trips/trip-relations/trip-completetion/tripCompletetion.controller';
import { TripExpenseController } from '../module/trips/trip-relations/trip-expenses/tripExpense.controller';
import { TripInterestsController } from '../module/trips/trip-relations/trip-interests/trip-interest.controller';
import { TripInvitationsController } from '../module/trips/trip-relations/trip-invitations/tripInvitations.controller';
import { TripJoinRequestsController } from '../module/trips/trip-relations/trip-join-requests/trip-join-requests.controller';
import {
  ItineraryDayItemsController,
  TripItinerariesController,
} from '../module/trips/trip-relations/trip-itineraries/trip-itianeraries.controller';
import { TripMessageController } from '../module/trips/trip-relations/trip-messages/tripMessages.controller';
import { TripSharesController } from '../module/trips/trip-relations/trip-shares/trip-shares.controller';
import { TripTimelineController } from '../module/trips/trip-relations/trip-timeline/tripTimeline.controller';
import { UsersController } from '../module/users/users.controller';
import { UploadsController } from '../uploads/presign-upload/presign-upload.controller';
import { DeviceTokenController } from '../module/auth/device-token/device-token.controller';

export const openApiControllers: Type<unknown>[] = [
  AuthController,
  DeviceTokenController,
  FollowController,
  FriendController,
  MediaController,
  PlacesController,
  PlaceCollectionsController,
  PlaceReviewsController,
  SavedPlacesController,
  RankingController,
  PostCommentsController,
  PostLikesController,
  PostSharesController,
  PostsController,
  TravelDnaController,
  TripsController,
  TripRecruitmentController,
  TripCompletionController,
  TripExpenseController,
  TripInterestsController,
  TripInvitationsController,
  TripJoinRequestsController,
  TripItinerariesController,
  ItineraryDayItemsController,
  TripMessageController,
  TripSharesController,
  TripTimelineController,
  UsersController,
  UploadsController,
];

// Swagger only needs controller metadata. Mock every constructor dependency so
// generation never initializes databases, queues, storage, Redis or mail.
const dependencyTokens = [
  ...new Set<Type<unknown>>(
    openApiControllers.flatMap(
      (controller) =>
        (Reflect.getMetadata('design:paramtypes', controller) as
          Type<unknown>[] | undefined) ?? [],
    ),
  ),
];

@Module({
  controllers: openApiControllers,
  providers: dependencyTokens.map((provide) => ({ provide, useValue: {} })),
})
export class OpenApiModule {}
