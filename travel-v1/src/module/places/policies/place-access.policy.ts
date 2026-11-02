import { NotFoundException } from '@nestjs/common';
import { PlaceStatus } from '../../../generated/prisma/enums';
import { ensure } from './policy.error';
import { PLACE_RADIUS_KM, type PlaceRadiusKm } from './policy.types';

export class PlaceAccessPolicy {
  static assertUtcOffsetMinutes(value: number): void {
    ensure(
      Number.isInteger(value) && value >= -840 && value <= 840,
      'INVALID_OFFSET',
      'utcOffsetMinutes must be an integer from -840 to 840',
    );
  }

  static assertRadiusKm(value: number): asserts value is PlaceRadiusKm {
    ensure(
      (PLACE_RADIUS_KM as readonly number[]).includes(value),
      'INVALID_RADIUS',
      'radiusKm must be 1, 5, or 10',
    );
  }

  static assertCoordinates(latitude: number, longitude: number): void {
    ensure(
      Number.isFinite(latitude) && latitude >= -90 && latitude <= 90,
      'INVALID_COORDINATES',
      'latitude must be between -90 and 90',
    );
    ensure(
      Number.isFinite(longitude) && longitude >= -180 && longitude <= 180,
      'INVALID_COORDINATES',
      'longitude must be between -180 and 180',
    );
  }

  /** Missing and unapproved places are both hidden. */
  static assertApproved(place: { status: PlaceStatus } | null): void {
    if (!place || place.status !== PlaceStatus.APPROVED) {
      throw new NotFoundException('Place not found');
    }
  }

  static assertSavedRecord(record: { id: string } | null): void {
    if (!record) {
      throw new NotFoundException('Saved place not found');
    }
  }
}
