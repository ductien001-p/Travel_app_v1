import { PlacePolicyError } from './policy.error';
import { PlaceAccessPolicy } from './place-access.policy';
import { PlaceStatus } from '../../../generated/prisma/enums';
import { NotFoundException } from '@nestjs/common';

describe('PlaceAccessPolicy', () => {
  it('rejects an offset outside the device range', () => {
    expect(() => PlaceAccessPolicy.assertUtcOffsetMinutes(841)).toThrow(
      PlacePolicyError,
    );
    expect(() => PlaceAccessPolicy.assertUtcOffsetMinutes(-840)).not.toThrow();
  });

  it('accepts only the home radius choices', () => {
    expect(() => PlaceAccessPolicy.assertRadiusKm(10)).not.toThrow();
    expect(() => PlaceAccessPolicy.assertRadiusKm(5)).not.toThrow();
    expect(() => PlaceAccessPolicy.assertRadiusKm(1)).not.toThrow();
    try {
      PlaceAccessPolicy.assertRadiusKm(20);
      fail('expected invalid radius');
    } catch (error) {
      expect(error).toBeInstanceOf(PlacePolicyError);
      expect((error as PlacePolicyError).code).toBe('INVALID_RADIUS');
    }
  });

  it('hides places that are not approved', () => {
    expect(() =>
      PlaceAccessPolicy.assertApproved({ status: PlaceStatus.PENDING }),
    ).toThrow(NotFoundException);
    expect(() => PlaceAccessPolicy.assertApproved(null)).toThrow(
      NotFoundException,
    );
    expect(() =>
      PlaceAccessPolicy.assertApproved({ status: PlaceStatus.APPROVED }),
    ).not.toThrow();
  });

  it('requires an existing saved row before unsave', () => {
    expect(() => PlaceAccessPolicy.assertSavedRecord(null)).toThrow(
      NotFoundException,
    );
  });
});
