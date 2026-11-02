import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../../../prisma.service';
import {
  MEMBER_STATUS,
  TRIP_STATUS,
  USER_STATUS,
} from '../../../../generated/prisma/browser';
import { FriendService } from '../../../friends/friends.service';
import { TripAccessPolicy } from '../../policies';
import {
  buildTripDnaProfile,
  joinRequestMatchScore,
  topProfilePersona,
  travelPersonaLabel,
  type TravelDnaScore,
} from '../trip-join-requests/join-request-match';

export type CompanionRecommendationsResult = {
  recommendations: CompanionRecommendation[];
  tripTravelPersona: string | null;
};

type CompanionRecommendation = {
  user: {
    id: string;
    displayname: string;
    username: string;
    avatarId: string | null;
  };
  tripsTogetherCount: number;
  invitationStatus: string | null;
  travelPersona: string | null;
  matchScore: number | null;
  lastInteractionAt: Date | null;
};

@Injectable()
export class RecommendFriendsToTripService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly friendService: FriendService,
  ) {}

  async getCompanionRecommendations(
    tripId: string,
    userId: string,
  ): Promise<CompanionRecommendationsResult> {
    const trip = await this.prisma.trip.findUnique({
      where: { id: tripId },
      select: {
        id: true,
        tripType: true,
        itineraryItems: {
          select: { place: { select: { category: true } } },
        },
      },
    });

    if (!trip) {
      throw new NotFoundException('Trip not found');
    }

    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'GET_COMPANION_RECOMMENDATIONS',
    );

    const profile = buildTripDnaProfile(
      trip.tripType,
      trip.itineraryItems.map((item) => item.place.category),
    );
    const tripTravelPersona =
      topProfilePersona(profile)?.travelPersona ?? null;

    const friends = await this.friendService.getFriends(userId);
    const friendIds = friends.map((friendship) => friendship.friendId);
    const empty = { recommendations: [], tripTravelPersona };

    if (friendIds.length === 0) return empty;

    const currentMembers = await this.prisma.tripMember.findMany({
      where: { tripId, status: MEMBER_STATUS.ACTIVE },
      select: { userId: true },
    });
    const currentMemberIds = new Set(
      currentMembers.map((member) => member.userId),
    );
    const candidateIds = friendIds.filter(
      (friendId) => friendId !== userId && !currentMemberIds.has(friendId),
    );

    if (candidateIds.length === 0) return empty;

    const myPastTrips = await this.prisma.tripMember.findMany({
      where: {
        userId,
        status: MEMBER_STATUS.ACTIVE,
        trip: { status: TRIP_STATUS.COMPLETED },
      },
      select: { tripId: true },
    });
    const pastTripIds = myPastTrips.map((item) => item.tripId);

    const togetherMemberships =
      pastTripIds.length > 0
        ? await this.prisma.tripMember.findMany({
            where: {
              userId: { in: candidateIds },
              tripId: { in: pastTripIds },
              status: MEMBER_STATUS.ACTIVE,
            },
            select: { userId: true, tripId: true },
          })
        : [];

    const tripsByUser = new Map<string, Set<string>>();
    for (const membership of togetherMemberships) {
      let trips = tripsByUser.get(membership.userId);
      if (!trips) {
        trips = new Set<string>();
        tripsByUser.set(membership.userId, trips);
      }
      trips.add(membership.tripId);
    }

    const invitations = await this.prisma.tripInvitation.findMany({
      where: { tripId, inviteeId: { in: candidateIds } },
      select: { inviteeId: true, status: true },
    });
    const invitationStatusByUser = new Map(
      invitations.map((invitation) => [
        invitation.inviteeId,
        invitation.status,
      ]),
    );

    const [users, dnaByUser, lastMessageAt] = await Promise.all([
      this.prisma.user.findMany({
        where: {
          id: { in: candidateIds },
          status: USER_STATUS.ACTIVE,
          deletedAt: null,
        },
        select: {
          id: true,
          displayname: true,
          username: true,
          avatarId: true,
        },
      }),
      this.loadTravelDna(candidateIds),
      this.loadLatestMessageAt(userId, candidateIds),
    ]);

    const friendshipAt = new Map(
      friends.map((friendship) => [friendship.friendId, friendship.createdAt]),
    );

    const results = users.map((user) => {
      const scores = dnaByUser.get(user.id) ?? [];
      return {
        user,
        tripsTogetherCount: tripsByUser.get(user.id)?.size ?? 0,
        invitationStatus: invitationStatusByUser.get(user.id) ?? null,
        travelPersona: travelPersonaLabel(scores),
        matchScore: joinRequestMatchScore(profile, scores),
        lastInteractionAt: laterDate(
          friendshipAt.get(user.id) ?? null,
          lastMessageAt.get(user.id) ?? null,
        ),
      };
    });

    results.sort((a, b) => {
      if (b.tripsTogetherCount !== a.tripsTogetherCount) {
        return b.tripsTogetherCount - a.tripsTogetherCount;
      }
      return a.user.displayname.localeCompare(b.user.displayname);
    });

    return { recommendations: results, tripTravelPersona };
  }

  private async loadTravelDna(
    userIds: string[],
  ): Promise<Map<string, TravelDnaScore[]>> {
    const rows = await this.prisma.userTravelDNA.findMany({
      where: { userId: { in: userIds }, score: { gt: 0 } },
      select: { userId: true, type: true, score: true },
    });
    const byUser = new Map<string, TravelDnaScore[]>();
    for (const { userId, type, score } of rows) {
      const scores = byUser.get(userId) ?? [];
      scores.push({ type, score });
      byUser.set(userId, scores);
    }
    return byUser;
  }

  private async loadLatestMessageAt(
    userId: string,
    friendIds: string[],
  ): Promise<Map<string, Date>> {
    const conversations = await this.prisma.friendConversation.findMany({
      where: {
        OR: [
          { user1Id: userId, user2Id: { in: friendIds } },
          { user2Id: userId, user1Id: { in: friendIds } },
        ],
      },
      select: {
        user1Id: true,
        user2Id: true,
        messages: {
          orderBy: { createdAt: 'desc' },
          take: 1,
          select: { createdAt: true },
        },
      },
    });
    const latest = new Map<string, Date>();
    for (const conversation of conversations) {
      const sentAt = conversation.messages[0]?.createdAt;
      if (!sentAt) continue;
      const friendId =
        conversation.user1Id === userId
          ? conversation.user2Id
          : conversation.user1Id;
      latest.set(friendId, sentAt);
    }
    return latest;
  }
}

function laterDate(left: Date | null, right: Date | null): Date | null {
  if (!left) return right;
  if (!right) return left;
  return left.getTime() >= right.getTime() ? left : right;
}
