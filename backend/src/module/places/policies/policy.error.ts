import { HttpException, HttpStatus } from '@nestjs/common';

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

const FORBIDDEN_POLICY_CODES = new Set<PlacePolicyErrorCode>([
  'COLLECTION_FORBIDDEN',
  'COLLECTION_NOT_PUBLIC',
]);

export class PlacePolicyError extends HttpException {
  constructor(
    public readonly code: PlacePolicyErrorCode,
    message: string,
    public readonly details?: Record<string, unknown>,
  ) {
    super(
      { code, message, details },
      FORBIDDEN_POLICY_CODES.has(code)
        ? HttpStatus.FORBIDDEN
        : HttpStatus.BAD_REQUEST,
    );
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
