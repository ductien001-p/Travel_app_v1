import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { TripAccessPolicy } from './trip-access.policy';

describe('TripAccessPolicy', () => {
  const activeMember = {
    id: 'member-1',
    userId: 'user-1',
    tripId: 'trip-1',
    role: 'MEMBER' as const,
    status: 'ACTIVE',
  };

  function reader(member: unknown, tripExists = true) {
    return {
      tripMember: {
        findUnique: jest.fn().mockResolvedValue(member),
      },
      trip: {
        findUnique: jest.fn().mockResolvedValue(
          tripExists
            ? {
                id: 'trip-1',
                ownerId: 'owner-1',
                members: member ? [member] : [],
              }
            : null,
        ),
      },
    };
  }

  it('hides an existing trip from a caller who is not a member', async () => {
    const missing = reader(null, false);
    await expect(
      TripAccessPolicy.authorize(missing as never, 'trip-1', 'user-1', 'READ'),
    ).rejects.toThrow(NotFoundException);

    const hidden = reader(null, true);
    await expect(
      TripAccessPolicy.authorize(hidden as never, 'trip-1', 'user-1', 'READ'),
    ).rejects.toThrow(new NotFoundException('Trip not found'));
  });

  it('keeps 403 when an active member lacks the role', async () => {
    const access = reader(activeMember, true);
    await expect(
      TripAccessPolicy.authorize(
        access as never,
        'trip-1',
        'user-1',
        'MANAGE_MEMBERS',
      ),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('returns 404 from authorizeOwner when the caller is not a member', async () => {
    const access = reader(null, true);
    await expect(
      TripAccessPolicy.authorizeOwner(access as never, 'trip-1', 'user-1'),
    ).rejects.toThrow(new NotFoundException('Trip not found'));
  });

  it('hides a trip when assertAllowed is called without a membership', () => {
    expect(() =>
      TripAccessPolicy.assertAllowed(null, 'MANAGE_EXPENSES'),
    ).toThrow(new NotFoundException('Trip not found'));
  });

  it('keeps 403 when a known membership is no longer active', () => {
    expect(() =>
      TripAccessPolicy.assertAllowed(
        { role: 'OWNER', status: 'LEFT' },
        'MANAGE_EXPENSES',
      ),
    ).toThrow(new ForbiddenException('Active trip membership required'));
  });

  it('returns 403 from authorizeOwner when a member is not the owner', async () => {
    const access = reader(activeMember, true);
    await expect(
      TripAccessPolicy.authorizeOwner(access as never, 'trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});
