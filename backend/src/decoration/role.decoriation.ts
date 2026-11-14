import { SetMetadata } from '@nestjs/common';
import { USER_ROLE } from '../generated/prisma/browser';
export const ROLES_KEY = 'roles';
export const Roles = (...roles: [USER_ROLE, ...USER_ROLE[]]) =>
  SetMetadata(ROLES_KEY, roles);
