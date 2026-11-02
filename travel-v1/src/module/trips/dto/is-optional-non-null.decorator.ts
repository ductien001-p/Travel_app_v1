import { ValidateIf } from 'class-validator';

/**
 * Like `@IsOptional()` but only for `undefined`: an explicit `null` still runs
 * the remaining validators, so a NOT NULL column can be omitted, never cleared.
 */
export const IsOptionalNonNull = () =>
  ValidateIf((_object: object, value: unknown) => value !== undefined);
