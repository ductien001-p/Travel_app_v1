import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { Prisma } from '../../../generated/prisma/client';
import {
  MEMBER_STATUS,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../../generated/prisma/enums';
import type { TripRole } from './policy.types';

export interface TripAccessSubject {
  id?: string;
  role: TripRole;
  status: string;
}

type MembershipReader = Pick<Prisma.TransactionClient, 'tripMember' | 'trip'>;

type TripOwnerReader = Pick<Prisma.TransactionClient, 'trip'>;

const ACCESS_MEMBER_SELECT = {
  id: true,
  userId: true,
  tripId: true,
  role: true,
  status: true,
} satisfies Prisma.TripMemberSelect;

export type TripAction =
  | 'READ'
  | 'EDIT_TRIP'
  | 'MANAGE_DESTINATIONS'
  | 'MANAGE_ITINERARY'
  | 'BATCH_ITINERARY'
  | 'REORDER_ITINERARY'
  | 'CHECK_IN'
  | 'MANAGE_MEMBERS'
  | 'INVITE_MEMBER'
  | 'MANAGE_INVITATIONS'
  | 'MANAGE_JOIN_REQUESTS'
  | 'MANAGE_INTERESTS'
  | 'GET_COMPANION_RECOMMENDATIONS'
  | 'READ_TIMELINE'
  | 'CREATE_TIMELINE_EVENT'
  | 'READ_MESSAGES'
  | 'SEND_MESSAGE'
  | 'MANAGE_EXPENSES'
  | 'READ_EXPENSES'
  | 'READ_MEMORIES'
  | 'CREATE_MEMORY'
  | 'MODERATE_MEMORIES'
  | 'COMPLETE_TRIP'
  | 'SHARE_TRIP'
  | 'REVOKE_SHARE';

const ROLES: Record<TripAction, readonly TripRole[]> = {
  READ: ['OWNER', 'ADMIN', 'MEMBER'],
  EDIT_TRIP: ['OWNER'],
  MANAGE_DESTINATIONS: ['OWNER'],
  MANAGE_ITINERARY: ['OWNER', 'ADMIN'],
  BATCH_ITINERARY: ['OWNER', 'ADMIN'],
  REORDER_ITINERARY: ['OWNER', 'ADMIN'],
  CHECK_IN: ['OWNER', 'ADMIN', 'MEMBER'],
  MANAGE_MEMBERS: ['OWNER', 'ADMIN'],
  INVITE_MEMBER: ['OWNER'],
  MANAGE_INVITATIONS: ['OWNER', 'ADMIN'],
  MANAGE_JOIN_REQUESTS: ['OWNER', 'ADMIN'],
  MANAGE_INTERESTS: ['OWNER'],
  GET_COMPANION_RECOMMENDATIONS: ['OWNER'],
  READ_TIMELINE: ['OWNER', 'ADMIN', 'MEMBER'],
  CREATE_TIMELINE_EVENT: ['OWNER', 'ADMIN', 'MEMBER'],
  READ_MESSAGES: ['OWNER', 'ADMIN', 'MEMBER'],
  SEND_MESSAGE: ['OWNER', 'ADMIN', 'MEMBER'],
  MANAGE_EXPENSES: ['OWNER', 'ADMIN', 'MEMBER'],
  READ_EXPENSES: ['OWNER', 'ADMIN', 'MEMBER'],
  READ_MEMORIES: ['OWNER', 'ADMIN', 'MEMBER'],
  CREATE_MEMORY: ['OWNER', 'ADMIN', 'MEMBER'],
  MODERATE_MEMORIES: ['OWNER', 'ADMIN'],
  COMPLETE_TRIP: ['OWNER', 'ADMIN', 'MEMBER'],
  SHARE_TRIP: ['OWNER', 'ADMIN', 'MEMBER'],
  REVOKE_SHARE: ['OWNER', 'ADMIN'],
};

export class TripAccessPolicy {
  static async authorize(
    reader: MembershipReader,
    tripId: string,
    userId: string,
    action: TripAction,
  ) {
    const member = await reader.tripMember.findUnique({
      where: { tripId_userId: { tripId, userId } },
      select: ACCESS_MEMBER_SELECT,
    });
    if (!member || member.status !== 'ACTIVE') {
      await this.assertTripExists(reader, tripId);
      throw new NotFoundException('Trip not found');
    }
    this.assertAllowed(member, action);
    return member;
  }

  /**
   * Trip.ownerId is a denormalized copy of the OWNER membership; the caller
   * must be the owner by both, so the two can never grant different rights.
   */
  static async authorizeOwner(
    reader: TripOwnerReader,
    tripId: string,
    userId: string,
  ) {
    const trip = await reader.trip.findUnique({
      where: { id: tripId },
      select: {
        ownerId: true,
        members: { where: { userId }, select: ACCESS_MEMBER_SELECT },
      },
    });
    if (!trip) throw new NotFoundException('Trip not found');
    const [member] = trip.members;
    if (!member || member.status !== 'ACTIVE') {
      throw new NotFoundException('Trip not found');
    }
    if (trip.ownerId !== userId || member.role !== 'OWNER') {
      throw new ForbiddenException(
        'Only the trip owner can perform this action',
      );
    }
    return member;
  }

  /** Lets callers that read membership themselves report a missing trip as 404. */
  static async assertTripExists(
    reader: TripOwnerReader,
    tripId: string,
  ): Promise<void> {
    const trip = await reader.trip.findUnique({
      where: { id: tripId },
      select: { id: true },
    });
    if (!trip) throw new NotFoundException('Trip not found');
  }

  static assertAllowed(
    member: TripAccessSubject | null | undefined,
    action: TripAction,
  ): asserts member is TripAccessSubject {
    if (!member) {
      throw new NotFoundException('Trip not found');
    }
    if (member.status !== 'ACTIVE') {
      throw new ForbiddenException('Active trip membership required');
    }
    if (!ROLES[action].includes(member.role)) {
      throw new ForbiddenException(`Role not allowed: ${action}`);
    }
  }

  static can(member: TripAccessSubject | null | undefined, action: TripAction) {
    return Boolean(
      member &&
      member.status === 'ACTIVE' &&
      ROLES[action].includes(member.role),
    );
  }
}

export function buildTripReadAccessWhere(
  userId: string,
): Prisma.TripWhereInput {
  return {
    OR: [
      {
        visibility: TRIP_VISIBILITY.PUBLIC,
        status: { not: TRIP_STATUS.DRAFT },
      },
      { ownerId: userId },
      { members: { some: { userId, status: MEMBER_STATUS.ACTIVE } } },
    ],
  };
}
