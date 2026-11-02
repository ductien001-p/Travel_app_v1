import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import type { TripRole } from './policy.types';

const ROLE_RANK: Record<TripRole, number> = {
  MEMBER: 0,
  ADMIN: 1,
  OWNER: 2,
};

export class TripMembershipPolicy {
  static assertJoinable(input: {
    status: string;
    maxMembers: number | null;
    activeMemberCount: number;
    previousMemberStatus: string | null | undefined;
  }): void {
    if (input.previousMemberStatus === 'ACTIVE') {
      throw new ConflictException('User is already a member of this trip');
    }
    if (input.previousMemberStatus === 'KICKED') {
      throw new ForbiddenException(
        'You were removed from this trip and need a new invitation to rejoin',
      );
    }
    if (input.status !== 'UPCOMING') {
      throw new ConflictException('Trip is not open for joining');
    }
    if (
      input.maxMembers !== null &&
      input.activeMemberCount >= input.maxMembers
    ) {
      throw new ConflictException('Trip is full');
    }
  }

  static assertActiveTarget(
    member: { status: string } | null | undefined,
    message = 'Member not found in this trip',
  ): asserts member is { status: string } {
    if (!member || member.status !== 'ACTIVE') {
      throw new NotFoundException(message);
    }
  }

  static assertCanLeave(
    member: { status: string; role: TripRole } | null | undefined,
  ): asserts member is { status: string; role: TripRole } {
    this.assertActiveTarget(
      member,
      'You are not an active member of this trip',
    );
    if (member.role === 'OWNER') {
      throw new ConflictException('The trip owner cannot leave the trip');
    }
  }

  static assertCanKick(
    requester: { userId: string; role: TripRole },
    target: { userId: string; role: TripRole },
  ): void {
    if (requester.userId === target.userId) {
      throw new BadRequestException('You cannot remove yourself from a trip');
    }
    if (ROLE_RANK[requester.role] <= ROLE_RANK[target.role]) {
      throw new ForbiddenException(
        'You can only remove members with a lower role than yours',
      );
    }
  }
}
