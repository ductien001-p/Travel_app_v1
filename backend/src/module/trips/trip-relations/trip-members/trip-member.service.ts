import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../../../prisma.service';
import {
  MEMBER_STATUS,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
} from '../../../../generated/prisma/enums';
import { lockTripRow } from '../../trip-lock';
import { reconcileRecruitmentState } from '../trip-recruitment/recruitment-state';
import { TripMembershipPolicy, TripAccessPolicy } from '../../policies';
import { TripItinerariesActivitiesService } from '../trip-itineraries/trip-itineraries-activities.service';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import { TripGateway } from '../../../../websocket/gateway';
import { generateInviteCode } from '../trip-invitations/invite-code';

@Injectable()
export class TripMembersService {
  private readonly logger = new Logger(TripMembersService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly tripItineraryActivitiesService: TripItinerariesActivitiesService,
    private readonly tripTimelineService: TripTimelineService,
    private readonly tripGateway: TripGateway,
  ) {}

  async leaveTrip(tripId: string, userId: string) {
    const result = await this.prisma.$transaction(async (tx) => {
      if (!(await lockTripRow(tx, tripId))) {
        throw new NotFoundException('Trip not found');
      }
      const member = await tx.tripMember.findUnique({
        where: { tripId_userId: { tripId, userId } },
        select: { status: true, role: true },
      });
      TripMembershipPolicy.assertCanLeave(member);

      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.MEMBER_LEFT,
          content: 'Đã rời khỏi chuyến đi',
          metadata: null,
        },
      );
      const updated = await tx.tripMember.update({
        where: { tripId_userId: { tripId, userId } },
        data: { status: MEMBER_STATUS.LEFT, leftAt: new Date() },
      });
      await this.tripItineraryActivitiesService.recalculateAllActivitiesCompletion(
        tx,
        tripId,
      );
      await reconcileRecruitmentState(tx, tripId);
      return {
        updated,
        timelineEvent,
      };
    });
    await this.removeFromTripRoom(tripId, userId);
    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
    return result.updated;
  }

  async kickMember(tripId: string, targetUserId: string, requesterId: string) {
    const result = await this.prisma.$transaction(async (tx) => {
      if (!(await lockTripRow(tx, tripId))) {
        throw new NotFoundException('Trip not found');
      }
      const requester = await TripAccessPolicy.authorize(
        tx,
        tripId,
        requesterId,
        'MANAGE_MEMBERS',
      );

      const target = await tx.tripMember.findUnique({
        where: { tripId_userId: { tripId, userId: targetUserId } },
        select: {
          id: true,
          userId: true,
          role: true,
          status: true,
          user: { select: { username: true, displayname: true } },
        },
      });
      TripMembershipPolicy.assertActiveTarget(target);
      TripMembershipPolicy.assertCanKick(requester, target);

      // The event is authored by the requester, so it names the removed member.
      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        requesterId,
        {
          type: TIMELINE_EVENT_TYPE.MEMBER_KICKED,
          content: `Đã xóa ${target.user.username} khỏi chuyến đi`,
          metadata: {
            targetMemberId: target.id,
            targetName: target.user.displayname,
          },
          target: { type: TIMELINE_TARGET_TYPE.MEMBER, id: target.id },
        },
      );
      const updated = await tx.tripMember.update({
        where: { tripId_userId: { tripId, userId: targetUserId } },
        data: { status: MEMBER_STATUS.KICKED, leftAt: new Date() },
      });
      // A removed member must not be able to pass the old code on.
      await tx.trip.update({
        where: { id: tripId },
        data: { inviteCode: generateInviteCode() },
      });

      // Vẫn cần vì kick có thể xảy ra khi trip đang ONGOING (đã có checkin)
      await this.tripItineraryActivitiesService.recalculateAllActivitiesCompletion(
        tx,
        tripId,
      );
      await reconcileRecruitmentState(tx, tripId);
      return {
        updated,
        timelineEvent,
      };
    });
    await this.removeFromTripRoom(tripId, targetUserId);
    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
    return result.updated;
  }

  /** Invalidates the current invite code; only the owner sees and shares it. */
  async rotateInviteCode(tripId: string, userId: string) {
    return this.prisma.$transaction(async (tx) => {
      await TripAccessPolicy.authorizeOwner(tx, tripId, userId);
      return tx.trip.update({
        where: { id: tripId },
        data: { inviteCode: generateInviteCode() },
        select: { id: true, inviteCode: true },
      });
    });
  }

  /** The membership change is already committed; a socket failure must not fail the request. */
  private async removeFromTripRoom(tripId: string, userId: string) {
    try {
      await this.tripGateway.removeUserFromTripRoom(tripId, userId);
    } catch (error) {
      this.logger.warn(
        `Failed to remove user ${userId} from trip room ${tripId}: ${
          error instanceof Error ? error.message : 'unknown error'
        }`,
      );
    }
  }
}
