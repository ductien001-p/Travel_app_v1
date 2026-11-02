import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { TripMembershipPolicy } from './trip-membership.policy';

describe('TripMembershipPolicy.assertJoinable', () => {
  const joinable = {
    status: 'UPCOMING',
    maxMembers: 5,
    activeMemberCount: 2,
    previousMemberStatus: null,
  };

  it('allows a new user to join an open trip', () => {
    expect(() => TripMembershipPolicy.assertJoinable(joinable)).not.toThrow();
  });

  it('allows a user who previously left to rejoin', () => {
    expect(() =>
      TripMembershipPolicy.assertJoinable({
        ...joinable,
        previousMemberStatus: 'LEFT',
      }),
    ).not.toThrow();
  });

  it('rejects a kicked user even when the trip has room', () => {
    expect(() =>
      TripMembershipPolicy.assertJoinable({
        ...joinable,
        previousMemberStatus: 'KICKED',
      }),
    ).toThrow(ForbiddenException);
  });

  it('reports "already a member" before "trip is full"', () => {
    expect(() =>
      TripMembershipPolicy.assertJoinable({
        ...joinable,
        activeMemberCount: 5,
        previousMemberStatus: 'ACTIVE',
      }),
    ).toThrow('User is already a member of this trip');
  });

  it('rejects joining a full trip', () => {
    expect(() =>
      TripMembershipPolicy.assertJoinable({
        ...joinable,
        activeMemberCount: 5,
      }),
    ).toThrow('Trip is full');
  });

  it('rejects joining a trip that is not upcoming', () => {
    expect(() =>
      TripMembershipPolicy.assertJoinable({ ...joinable, status: 'DRAFT' }),
    ).toThrow(ConflictException);
  });
});

describe('TripMembershipPolicy.assertCanLeave', () => {
  it('allows an active non-owner to leave', () => {
    expect(() =>
      TripMembershipPolicy.assertCanLeave({ status: 'ACTIVE', role: 'ADMIN' }),
    ).not.toThrow();
  });

  it('rejects the owner leaving their own trip', () => {
    expect(() =>
      TripMembershipPolicy.assertCanLeave({ status: 'ACTIVE', role: 'OWNER' }),
    ).toThrow(ConflictException);
  });

  it.each([null, { status: 'LEFT', role: 'MEMBER' as const }])(
    'rejects a missing or inactive membership (%o)',
    (member) => {
      expect(() => TripMembershipPolicy.assertCanLeave(member)).toThrow(
        NotFoundException,
      );
    },
  );
});

describe('TripMembershipPolicy.assertCanKick', () => {
  it.each([
    ['OWNER', 'ADMIN'],
    ['OWNER', 'MEMBER'],
    ['ADMIN', 'MEMBER'],
  ] as const)('allows %s to remove %s', (requesterRole, targetRole) => {
    expect(() =>
      TripMembershipPolicy.assertCanKick(
        { userId: 'requester', role: requesterRole },
        { userId: 'target', role: targetRole },
      ),
    ).not.toThrow();
  });

  it.each([
    ['ADMIN', 'OWNER'],
    ['ADMIN', 'ADMIN'],
    ['MEMBER', 'MEMBER'],
  ] as const)('forbids %s from removing %s', (requesterRole, targetRole) => {
    expect(() =>
      TripMembershipPolicy.assertCanKick(
        { userId: 'requester', role: requesterRole },
        { userId: 'target', role: targetRole },
      ),
    ).toThrow(ForbiddenException);
  });

  it('rejects removing yourself', () => {
    expect(() =>
      TripMembershipPolicy.assertCanKick(
        { userId: 'owner-1', role: 'OWNER' },
        { userId: 'owner-1', role: 'OWNER' },
      ),
    ).toThrow(BadRequestException);
  });
});
