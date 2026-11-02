import { BadRequestException } from '@nestjs/common';

export type PlacePolicyErrorCode =
  | 'INVALID_OFFSET'
  | 'INVALID_RADIUS'
  | 'INVALID_COORDINATES'
  | 'INVALID_TITLE'
  | 'INVALID_RATING'
  | 'COLLECTION_FORBIDDEN'
  | 'RATING_OWN_COLLECTION'
  | 'COPY_OWN_COLLECTION'
  | 'COLLECTION_NOT_PUBLIC'
  | 'MEMBERSHIP_EMPTY'
  | 'MEMBERSHIP_DUPLICATE';

export class PlacePolicyError extends BadRequestException {
  constructor(
    public readonly code: PlacePolicyErrorCode,
    message: string,
    public readonly details?: Record<string, unknown>,
  ) {
    super({ code, message, details });
    this.name = 'PlacePolicyError';
  }
}

export function ensure(
  condition: unknown,
  code: PlacePolicyErrorCode,
  message: string,
  details?: Record<string, unknown>,
): asserts condition {
  if (!condition) throw new PlacePolicyError(code, message, details);
}
